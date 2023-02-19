// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cnue_food_app/Screen/home_screen.dart';
import 'package:cnue_food_app/Screen/my_screen.dart';
import 'package:cnue_food_app/Screen/schoolfood_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cnue_food_app/Data/my_location.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
const String kakaomap_key = 'd807ac4fd35de9c7e8bb51845fa03c44';

class OutFoodScreen extends StatefulWidget {
  const OutFoodScreen({Key? key}) : super(key: key);

  @override
  State<OutFoodScreen> createState() => _OutFoodScreenState();
}

class _OutFoodScreenState extends State<OutFoodScreen> {



  @override
  void initState() {
    // TODO: implement initState
    _locationPermissionRequest();
  }

  late NaverMapController _mapController;
  final Completer<NaverMapController> mapControllercompleter = Completer();

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);
    final pixelRatio = mediaQuery.devicePixelRatio;
    final mapSize = Size(mediaQuery.size.width - 32, mediaQuery.size.height - 50);
    final physicalSize = Size(mapSize.width * pixelRatio, mapSize.height * pixelRatio);

    return Scaffold(
        appBar: AppBar(
          title: Text('MY CNUE',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: (){
                },
                icon: Icon(Icons.settings,
                  color: Colors.black,)),
          ],
          elevation: 0.0,
        ),
      body: SafeArea(
          child: Container(
              width: mediaQuery.size.width,
              height: mapSize.height,
              // color: Colors.greenAccent,
              child: _naverMapSection())),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final NLatLng nowPosition = await _mapController
                  .getCameraPosition()
                  .then((p) => p.target);
            },
            child: const Icon(Icons.clear_rounded))
    );
  }

  
  Widget _naverMapSection() => NaverMap(

    options: const NaverMapViewOptions(
      indoorEnable: true,
      locationButtonEnable: true,
      consumeSymbolTapEvents: true,
      zoomGesturesEnable: true,

      // 카메라 초기 위치
      initialCameraPosition: NCameraPosition(
        // 춘천교대
          target: NLatLng(37.85927003630758, 127.74758462114653),
          zoom: 15
      ),
    ),



    // 맵 초기설정
    onMapReady: (controller) async {
      _mapController = controller;
      mapControllercompleter.complete(controller);

      marker(String id, NLatLng latLng, Size size) {
        return NMarker(
          id: id,
          position: latLng,
          size: size,
        );
      }

      infoWindow(String id, String text){
        return NInfoWindow.onMarker(
            id: id,
            text: text
        );
      }

      List<dynamic> marker_list = [
        // 석사돈사무소
        marker("id0", NLatLng(37.858314519799436, 127.74532505754269), Size(20, 30)),
        // 가내수공업
        marker("id1", NLatLng(37.85710369999869, 127.75823258309367), Size(20, 30)),
        // 거두리밥상
        marker("id2", NLatLng(37.856302191953134, 127.75169458112128), Size(20, 30)),
        // 부산 산꼼장어
        marker("id3", NLatLng(37.86611196749082, 127.75260508752416), Size(20, 30)),
        // 빈체로
        marker("id4", NLatLng(37.863027110897264, 127.74985179685689), Size(20, 30)),
        // 삼락
        marker("id5", NLatLng(37.8613226998564, 127.74274019674425), Size(20, 30)),
        // 설악추어탕
        marker("id6", NLatLng(37.861109650259536, 127.74543947626432), Size(20, 30)),
        // 스시환
        marker("id7", NLatLng(37.8573323189718, 127.75378211068056), Size(20, 30)),
        // 연미당
        marker("id8", NLatLng(37.858050599471866, 127.75751926929479), Size(20, 30)),
        // 슬로우캘리
        marker("id9", NLatLng(37.85709957746343, 127.7586148919267), Size(20, 30)),
        // 제일 닭갈비
        marker("id10", NLatLng(37.854306087456976, 127.7474125575227), Size(20, 30)),
        // 축제 닭갈비
        marker("id11", NLatLng(37.857715950561726, 127.75532513782872), Size(20, 30)),
        // 투빅버거
        marker("id12", NLatLng(37.85659314793439, 127.74806977997929), Size(20, 30)),
        // 파스따남
        marker("id13", NLatLng(37.8610108021346, 127.7452580509086), Size(20, 30)),
        // 황산차이나
        marker("id14", NLatLng(37.85910118753354, 127.74513547528335), Size(20, 30)),
        // 월담
        marker("id15", NLatLng(37.86638562100373, 127.75260216309937), Size(20, 30)),
        // 본도시락
        marker("id16", NLatLng(37.85714656627593, 127.74703277201047), Size(20, 30)),
        // 돈치킨
        marker("id17", NLatLng(37.85276302145121, 127.75355106130831), Size(20, 30)),
        // 세할머니 막국수
        marker("id18", NLatLng(37.86127516618265, 127.74556987499642), Size(20, 30)),
        // 수누리 감자탕
        marker("id19", NLatLng(37.861977043402305, 127.7463714991656), Size(20, 30)),
        // 피자플렉스
        marker("id20", NLatLng(37.856572029354226, 127.7476139967726), Size(20, 30)),
        // 고향전집
        marker("id21", NLatLng(37.85881491015979, 127.74280277183527), Size(20, 30)),
        // 참새방앗간
        marker("id22", NLatLng(37.85767944027995, 127.74464169707772), Size(20, 30)),
        // 이백장 돈까스
        marker("id23", NLatLng(37.856506753330365, 127.74768755305166), Size(20, 30)),
        // 아리랑 떡볶이
        marker("id24", NLatLng(37.85767716704025, 127.74357173277161), Size(20, 30)),
        // 브리오슈
        marker("id25", NLatLng(37.85817259691656, 127.74601338483984), Size(20, 30)),
        // 글리프
        marker("id26", NLatLng(37.85796530843476, 127.75692756786816), Size(20, 30)),
      ];

      List<dynamic> infoWindow_list = [
        // 석사돈사무소
        infoWindow("id0", "석사돈사무소"),
        // 가내수공업
        infoWindow("id1", "가내수공업"),
        // 거두리밥상
        infoWindow("id2", "거두리밥상"),
        // 부산 산꼼장어
        infoWindow("id3", "부산 산꼼장어"),
        // 빈체로
        infoWindow("id4", "빈체로"),
        // 삼락
        infoWindow("id5", "삼락"),
        // 설악추어탕
        infoWindow("id6", "설악추어탕"),
        // 스시환
        infoWindow("id7", "스시환"),
        // 연미당
        infoWindow("id8", "연미당"),
        // 슬로우캘리
        infoWindow("id9", "슬로우캘리"),
        // 제일 닭갈비
        infoWindow("id10", "제일 닭갈비"),
        // 축제 닭갈비
        infoWindow("id11", "축제 닭갈비"),
        // 투빅버거
        infoWindow("id12", "투빅버거"),
        // 파스따남
        infoWindow("id13", "파스따남"),
        // 황산차이나
        infoWindow("id14", "황산차이나"),
        // 월담
        infoWindow("id15", "월담"),
        // 본도시락
        infoWindow("id16", "본도시락"),
        // 돈치킨
        infoWindow("id17", "돈치킨"),
        // 세할머니 막국수
        infoWindow("id18", "세할머니 막국수"),
        // 수누리 감자탕
        infoWindow("id19", "수누리 감자탕"),
        // 피자플렉스
        infoWindow("id20", "피자플렉스"),
        // 고향전집
        infoWindow("id21", "고향전집"),
        // 참새방앗간
        infoWindow("id22", "참새방앗간"),
        // 이백장 돈까스
        infoWindow("id23", "이백장 돈까스"),
        // 아리랑 떡볶이
        infoWindow("id24", "아리랑 떡볶이"),
        // 브리오슈
        infoWindow("id25", "브리오슈"),
        // 글리프
        infoWindow("id26", "글리프"),
      ];


      for(int i = 0; i<marker_list.length; i++){
        _mapController.addOverlay(marker_list[i]);
        infoWindow_list[i].setOnTapListener((overlay) => Navigator.push(context,
            MaterialPageRoute(builder: (context) => information1())));
        await marker_list[i].openInfoWindow(infoWindow_list[i]);
      }
    },
    onMapTapped: (point, latLng) async {
      print("onMapTapped: $latLng $point");
    },
  );

  // 위치 정보 수집 권한 message
  Future<void> _locationPermissionRequest() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final requestPermission = await Geolocator.requestPermission();
      if (requestPermission == LocationPermission.denied) {
      }
    }
  }
}


class information1 extends StatefulWidget {
  const information1({Key? key, required this.info_num, this.info_web_url, required this.info_name}) : super(key: key);

  final int info_num;
  final dynamic info_web_url;
  final String info_name;

  @override
  State<information1> createState() => _information1State();
}

class _information1State extends State<information1> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('석사돈사무소',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),),
        backgroundColor: Colors.grey[300],
        iconTheme: IconThemeData(
          color: Colors.black,//색변경
        ),
        actions: [
          IconButton(
              onPressed: (){
              },
              icon: Icon(Icons.settings,
                color: Colors.black,)
          ),
        ],
        elevation: 0.0,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Column(

          )
        ],
      )
    );
  }
}