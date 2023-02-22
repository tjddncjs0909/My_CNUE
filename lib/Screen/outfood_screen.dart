// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final mapSize = Size(mediaQuery.size.width, mediaQuery.size.height);
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
      body: naverMapSection(),
    );
  }

  Widget naverMapSection() =>
    NaverMap(
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

        info_alliance(String alliance1, String alliance2,
            String alliance3, String alliance4){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${alliance1}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              Text("${alliance2}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              Text("${alliance3}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              Text("${alliance4}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
            ],
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
          // 월담 애막골점
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
          // 월담 애막골점
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
        List<String> info_web_url_list = [
          // "석사돈사무소",
          "https://m.place.naver.com/restaurant/1300438892/home",
          // "가내수공업",
          "https://m.place.naver.com/restaurant/37183141/home",
          // "거두리밥상",
          "https://m.place.naver.com/restaurant/1515170665/home",
          // "부산 산꼼장어",
          "https://m.place.naver.com/restaurant/36330014/home?type=photoView",
          // "빈체로",
          "https://m.place.naver.com/restaurant/34015037/home?entry=plt",
          // "삼락",
          "https://m.place.naver.com/restaurant/15632807/home",
          // "설악추어탕",
          "https://m.place.naver.com/restaurant/36921059/home?type=photoView",
          // "스시환",
          "https://m.place.naver.com/restaurant/94972130/home?type=photoView",
          // "연미당",
          "https://m.place.naver.com/restaurant/1838098827/home",
          // "슬로우캘리",
          "https://m.place.naver.com/restaurant/1580123592/home?entry=ple",
          // "제일 닭갈비",
          "https://m.place.naver.com/restaurant/20031159/home",
          // "축제 닭갈비",
          "https://m.place.naver.com/restaurant/32168403/home",
          // "투빅버거",
          "https://m.place.naver.com/restaurant/901093252/home",
          // "파스따남",
          "https://m.place.naver.com/restaurant/37885193/home",
          // "황산차이나",
          "https://m.place.naver.com/restaurant/15633114/home",
          // "월담 애막골점",
          "https://m.place.naver.com/restaurant/1912235396/home?entry=pll",
          // "본도시락",
          "https://m.place.naver.com/restaurant/1030717329/home?entry=plt",
          // "돈치킨",
          "https://m.place.naver.com/restaurant/31946178/home?entry=pll",
          // "세할머니 막국수",
          "https://m.place.naver.com/restaurant/1227445803/home?entry=plt",
          // "수누리 감자탕",
          "https://m.place.naver.com/restaurant/15109913/home?entry=plt",
          // "피자플렉스",
          "https://m.place.naver.com/restaurant/1794366103/home?entry=plt",
          // "고향전집",
          "https://m.place.naver.com/restaurant/1104883654/home",
          // "참새방앗간"
          "https://m.place.naver.com/restaurant/345822208/home?entry=plt",
          // "이백장 돈까스",
          "https://m.place.naver.com/restaurant/1506186824/home?entry=plt",
          // "아리랑 떡볶이",
          "https://m.place.naver.com/restaurant/20973785/home?entry=pll",
          // "브리오슈",
          "https://m.place.naver.com/restaurant/1171347335/home?entry=pll",
          // "글리프",
          "https://m.place.naver.com/restaurant/1670877047/home",
        ];
        List<String> info_name_list = [
          "석사돈사무소",
          "가내수공업",
          "거두리밥상",
          "부산 산꼼장어",
          "빈체로",
          "삼락",
          "설악추어탕",
          "스시환",
          "연미당",
          "슬로우캘리",
          "제일 닭갈비",
          "축제 닭갈비",
          "투빅버거",
          "파스따남",
          "황산차이나",
          "월담 애막골점",
          "본도시락",
          "돈치킨",
          "세할머니 막국수",
          "수누리 감자탕",
          "피자플렉스",
          "고향전집",
          "참새방앗간",
          "이백장 돈까스",
          "아리랑 떡볶이",
          "브리오슈",
          "글리프",
        ];
        List<dynamic> info_alliance_list = [
          // "석사돈사무소",
          info_alliance(
              "3만원 이상 현금 결제 : 음료 서비스",
              "파불고기 주문 : 볶음밥 서비스",
              "장호찌개 주문 : 라면사리 서비스",
              ""),
          // "가내수공업",
          info_alliance(
              "세트 메뉴 주문 시 10% 할인",
              "",
              "",
              ""),
          // "거두리밥상",
          info_alliance(
              "전 품목 10% 할인",
              "",
              "",
              ""),
          // "부산 산꼼장어",
          info_alliance(
              "현금 결제시 10% 할인",
              "",
              "",
              ""),
          // "빈체로",
          info_alliance(
              "3인 이상 : 닭가슴살 샐러드 무료",
              "현금 결제 : 10% 할인",
              "",
              ""),
          // "삼락",
          info_alliance(
              "3만원 이상 : 1천원 할인",
              "5만원 이상 : 2천원 할인",
              "",
              ""),
          // "설악추어탕",
          info_alliance(
              "20% 할인",
              "",
              "",
              ""),
          // "스시환",
          info_alliance(
              "4인 미만 : 음료수 서비스",
              "4인 이상 : 피자 서비스",
              "",
              ""),
          // "연미당",
          info_alliance(
              "2만원 이상 : 음료 1개 서비스",
              "4만원 이상 : 음료 2개 서비스",
              "",
              ""),
          // "슬로우캘리",
          info_alliance(
              "4인 미만 : 음료수 서비스",
              "4인 이상 : 스프 서비스",
              "",
              ""),
          // "제일 닭갈비",
          info_alliance(
              "현금 결제 : 1천원 할인",
              "",
              "",
              ""),
          // "축제 닭갈비",
          info_alliance(
              "2,3인분 : 음료 서비스",
              "4인분 이상 : 음료+우동 사리 서비스",
              "",
              ""),
          // "투빅버거",
          info_alliance(
              "버거세트 500원 할인",
              "",
              "",
              ""),
          // "파스따남",
          info_alliance(
              "탄산음료 서비스",
              "",
              "",
              ""),
          // "황산차이나",
          info_alliance(
              "현금, 계좌 결제 : 10% 할인",
              "",
              "",
              ""),
          // "월담 애막골점",
          info_alliance(
              "모두 교대생인 경우 : 전체 금액의 10% 할인",
              "일행 중 교대생 있을 경우 : 전체 금액의 8% 할인",
              "",
              ""),
          // "본도시락",
          info_alliance(
              "도시락 1000원 할인 (할인 품목은 추후에 변경 가능)",
              "",
              "",
              ""),
          // "돈치킨",
          info_alliance(
              "4인 미만 : 500ml음료",
              "4인 이상 : 1.25L 음료 서비스",
              "",
              ""),
          // "세할머니 막국수",
          info_alliance(
              "20% 할인",
              "",
              "",
              ""),
          // "수누리 감자탕",
          info_alliance(
              "뼈해장국 주문 : 테이블당 공기밥 또는 음료 1개 서비스",
              "감자탕 주문 : 사리 하나 서비스",
              "",
              ""),
          // "피자플렉스",
          info_alliance(
              "<포장> : R주문 시 음료 작은거 / L주문 시 음료 큰 거 서비스",
              "<매장> : 19,900원 이상 주문 시 스파게티 서비스",
              "",
              ""),
          // "고향전집",
          info_alliance(
              "테이블당 주류 5병 이상 주문 : 계란말이 서비스",
              "",
              "",
              ""),
          // "참새방앗간",
          info_alliance(
              "테이블당 주류 5병 이상 주문 : 라면 서비스",
              "",
              "",
              ""),
          // "이백장 돈까스",
          info_alliance(
              "현금 결제 시 10% 할인",
              "",
              "",
              ""),
          // "아리랑 떡볶이",
          info_alliance(
              "현금 결제 시 10% 할인",
              "",
              "",
              ""),
          // "브리오슈",
          info_alliance(
              "TAKE OUT시 500원 할인",
              "",
              "",
              ""),
          // "글리프",
          info_alliance(
            "학생증 확인 후 쿠폰 증정",
            "5번 방문(쿠폰 5개) : 쿠키 1개",
            "10번 방문(쿠폰 10개) : 쿠키 2개 또는 아메리카노",
            "",
          ),
        ];

        for(int i = 0; i<marker_list.length; i++){
          _mapController.addOverlay(marker_list[i]);
          infoWindow_list[i].setOnTapListener((overlay) => Navigator.push(context,
              MaterialPageRoute(builder: (context1) => information1(
                info_web_url: "${info_web_url_list[i]}",
                info_name: "${info_name_list[i]}",
                info_alliance: info_alliance_list[i],
              )
              )
          ),
          );
          await marker_list[i].openInfoWindow(infoWindow_list[i]);
        }
      },
      onMapTapped: (point, latLng) async {
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
  const information1({Key? key, required this.info_web_url,
    required this.info_name,required this.info_alliance})
      : super(key: key);

  final String info_web_url;
  final String info_name;
  final dynamic info_alliance;

  @override
  State<information1> createState() => _information1State();
}

class _information1State extends State<information1> {

  @override
  Widget build(BuildContext context1) {
    return Scaffold(
      appBar: AppBar(
        title: Text('식당 정보',
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
          Text("${widget.info_name}",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 5,
            thickness: 1.5,
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          Text("★ 제휴 ★",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent
          ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.info_alliance
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 5,
            thickness: 1.5,
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("자세히 보기 - ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),),
              Text("(네이버 플레이스 제공)",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){
                  launchUrl(
                      Uri.parse("${widget.info_web_url}"),
                      mode: LaunchMode.externalApplication
                  );
                  Navigator.pop(context1);
                },
                child: Image.asset(
                  "asset/naver_map.png",
                  height: MediaQuery.of(context).size.height / 8 ,
                  width: MediaQuery.of(context).size.width / 8 ,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.arrow_back),
              Text("클릭하세요",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black
              ),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("※주의사항※",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                ),),
              Text("마지막 업데이트 : 2022 / 02 / 20"),
            ],
          ),
          Container(
              padding: EdgeInsets.all(10),
              height: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("#1 제휴를 이용하고자 하는 학우분들께서는 업체에",),
                  Text("“춘천교대 학생”임을 반드시 먼저 언급해주시기 바랍니다 ☺ ",
                    style: TextStyle(
                        color: Colors.red
                    ),
                  ),
                  Text("업체 담당자분들께서 제휴 혜택을 주시기 위해서는 확인이 필요하니 "
                      "이 점 꼭 유의해주세요."),
                  SizedBox(
                    height: 10,
                  ),
                  Text("#2 제휴 내용 및 업체 현황은 매일 업데이트 되지 않기 때문에, "
                      "추후에 누락된 업체가 생길 수 있습니다."),
                  Row(
                    children: [
                      Text("자세한 현황은 "),
                      TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: (){
                            launchUrl(Uri.parse("https://www.instagram.com/cnue39uni_jehue/"),
                                mode: LaunchMode.externalApplication
                            );
                            Navigator.pop(context1);
                          },
                          child: Text("총학생회 제휴 인스타그램 계정")),
                      Text("을")
                    ],
                  ),
                  Text("참고해주시기 바랍니다."),
                ],
              )
          ),
        ],
      )
    );
  }
}