// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:url_launcher/url_launcher.dart';

class school_food_screen extends StatefulWidget {
  const school_food_screen({Key? key}) : super(key: key);

  @override
  State<school_food_screen> createState() => _school_food_screenState();
}

class _school_food_screenState extends State<school_food_screen> {

  int _selectedIndex = 1;

  late DateFormat daysFormat;

  var now1 = DateTime.now();

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("HH:mm:ss ").format(now);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting();
    daysFormat = DateFormat.EEEE('ko');
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final Uri url1 = Uri.parse('https://www.cnue.ac.kr/life/info/food.do');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('학식'),
          backgroundColor: Colors.blueAccent,
          actions: [
            IconButton(
                onPressed: (){
                },
                icon: Icon(Icons.settings)),
          ]
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('금주의 학식',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),),
                OutlinedButton(
                  child: Text('식단 메뉴표 원본',
                    style: TextStyle(
                      fontSize: 15
                    ),),
                  onPressed: (){
                    launchUrl(url1);
                  },
                )
              ],
            ),
            Text('(3월 6일 ~ 3월 12일)',
              style: TextStyle(
                fontSize: 20,
              ),),
            SizedBox(
              height: 10,
            ),
            Text('* 식단표 공개일 자정에 업데이트 됩니다 *',
              style: TextStyle(
                fontSize: 15
              ),),
            Divider(
              height: 20.0,
              thickness: 1.5,
              color: Colors.grey,
            ),
            // 운영시간
            Row(
              children: [
                Text('< 운영 시간 >    ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900
                  ),
                ),
                Text('지금은 ',
                  style: TextStyle(
                      fontSize: 15,
                  ),
                ),
                Text(
                    daysFormat.format(now1),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    )
                ),
                TimerBuilder.periodic(Duration(seconds: 1), builder: (context){
                  print('${getSystemTime()}');
                  return Text(' ${getSystemTime()}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),);
                }
                ),
                Text('입니다.',
                  style: TextStyle(
                      fontSize: 15,
                  ),)
              ],
            ),
            Container(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(0),
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.lightGreen,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text('    '),
                            Container(
                              height: 18,
                            ),
                            Text('조식',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                            Container(
                              height: 7,
                            ),
                            Text('중식',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900
                              ),),
                            Container(
                              height: 10,
                            ),
                            Text('석식',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900
                              ),),
                          ],
                        ),
                        Column(
                          children: [
                            Text('평일',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900
                              ),),
                            Container(
                              height: 13,
                            ),
                            Text('07:30~09:00',
                              style: TextStyle(
                                  fontSize: 15,
                              ),),
                            Container(
                              height: 13,
                            ),
                            Text('11:30~13:30',
                              style: TextStyle(
                                  fontSize: 15,
                              ),),
                            Container(
                              height: 13,
                            ),
                            Text('17:00~18:30',
                              style: TextStyle(
                                  fontSize: 15,
                              ),),
                          ],
                        ),
                        Column(
                          children: [
                            Text('주말 및 공휴일',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900
                              ),),
                            Container(
                              height: 13,
                            ),
                            Text('08:00~09:00',
                              style: TextStyle(
                                fontSize: 15,
                              ),),
                            Container(
                              height: 13,
                            ),
                            Text('12:00~13:00',
                              style: TextStyle(
                                fontSize: 15,
                              ),),
                            Container(
                              height: 13,
                            ),
                            Text('17:00~18:00',
                              style: TextStyle(
                                fontSize: 15,
                              ),),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Container(
              height: 20,
            ),

            Divider(
              height: 20.0,
              thickness: 1.5,
              color: Colors.grey,
            ),

            // 월요일
            Text('3월 6일',
              style: TextStyle(
                fontSize: 20,
              ),),
            Text('월요일',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),),
            Container(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 50,
                  ),
                  Column(
                    children: [
                      Text('조식',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),),
                      Container(
                        height: 15,
                      ),
                      Text('★콩비지찌개★',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.red
                      ),),
                      Text('쌀밥',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('메추리알곤약조림',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('오복채무침',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('열무김치',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('음료/누룽지',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),
                  Container(
                    width: 100,
                  ),
                  Column(
                    children: [
                      Text('중식',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      Container(
                        height: 15,
                      ),
                      Text('★삼겹살김치찌개★',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.red
                        ),),
                      Text('쌀밥',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('생선가스, 타르타르소스',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('명엽채볶음',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('깻잎무침',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('깍두기',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),
                  Container(
                    width: 100,
                  ),
                  Column(
                    children: [
                      Text('석식',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      Container(
                        height: 15,
                      ),
                      Text('★함박스테이크, 데미소스★',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.red
                        ),),
                      Text('쌀밥',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('맑은우동국물',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('양배추샐러드, 드레싱',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('모듬피클',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text(' ',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),
                  Container(
                    width: 50,
                  ),
                ],
              ),
            ),
            Divider(
              height: 20.0,
              thickness: 1.5,
              color: Colors.grey,
            ),

            // 화요일
            Text('3월 7일',
              style: TextStyle(
                fontSize: 20,
              ),),
            Text('화요일',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),),
            Container(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 50,
                  ),
                  Column(
                    children: [
                      Text('조식',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      Container(
                        height: 15,
                      ),
                      Text('★콩비지찌개★',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.red
                        ),),
                      Text('쌀밥',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('메추리알곤약조림',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('오복채무침',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('열무김치',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('음료/누룽지',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),
                  Container(
                    width: 100,
                  ),
                  Column(
                    children: [
                      Text('중식',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      Container(
                        height: 15,
                      ),
                      Text('★삼겹살김치찌개★',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.red
                        ),),
                      Text('쌀밥',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('생선가스, 타르타르소스',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('명엽채볶음',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('깻잎무침',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('깍두기',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),
                  Container(
                    width: 100,
                  ),
                  Column(
                    children: [
                      Text('석식',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      Container(
                        height: 15,
                      ),
                      Text('★함박스테이크, 데미소스★',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.red
                        ),),
                      Text('쌀밥',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('맑은우동국물',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('양배추샐러드, 드레싱',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('모듬피클',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text(' ',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),
                  Container(
                    width: 50,
                  ),
                ],
              ),
            ),
            Divider(
              height: 20.0,
              thickness: 1.5,
              color: Colors.grey,
            ),

            //수요일
            Text('3월 8일',
              style: TextStyle(
                fontSize: 20,
              ),),
            Text('수요일',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),),
            Container(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 50,
                  ),
                  Column(
                    children: [
                      Text('조식',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      Container(
                        height: 15,
                      ),
                      Text('★콩비지찌개★',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.red
                        ),),
                      Text('쌀밥',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('메추리알곤약조림',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('오복채무침',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('열무김치',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('음료/누룽지',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),
                  Container(
                    width: 100,
                  ),
                  Column(
                    children: [
                      Text('중식',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      Container(
                        height: 15,
                      ),
                      Text('★삼겹살김치찌개★',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.red
                        ),),
                      Text('쌀밥',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('생선가스, 타르타르소스',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('명엽채볶음',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('깻잎무침',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('깍두기',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),
                  Container(
                    width: 100,
                  ),
                  Column(
                    children: [
                      Text('석식',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      Container(
                        height: 15,
                      ),
                      Text('★함박스테이크, 데미소스★',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.red
                        ),),
                      Text('쌀밥',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('맑은우동국물',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('양배추샐러드, 드레싱',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('모듬피클',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text(' ',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),
                  Container(
                    width: 50,
                  ),
                ],
              ),
            ),
            Divider(
              height: 20.0,
              thickness: 1.5,
              color: Colors.grey,
            ),

            //목요일
            Text('3월 9일',
              style: TextStyle(
                fontSize: 20,
              ),),
            Text('목요일',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),),
            Container(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 50,
                  ),
                  Column(
                    children: [
                      Text('조식',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      Container(
                        height: 15,
                      ),
                      Text('★콩비지찌개★',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.red
                        ),),
                      Text('쌀밥',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('메추리알곤약조림',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('오복채무침',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('열무김치',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('음료/누룽지',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),
                  Container(
                    width: 100,
                  ),
                  Column(
                    children: [
                      Text('중식',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      Container(
                        height: 15,
                      ),
                      Text('★삼겹살김치찌개★',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.red
                        ),),
                      Text('쌀밥',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('생선가스, 타르타르소스',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('명엽채볶음',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('깻잎무침',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('깍두기',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),
                  Container(
                    width: 100,
                  ),
                  Column(
                    children: [
                      Text('석식',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      Container(
                        height: 15,
                      ),
                      Text('★함박스테이크, 데미소스★',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.red
                        ),),
                      Text('쌀밥',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('맑은우동국물',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('양배추샐러드, 드레싱',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('모듬피클',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text(' ',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),
                  Container(
                    width: 50,
                  ),
                ],
              ),
            ),
            Divider(
              height: 20.0,
              thickness: 1.5,
              color: Colors.grey,
            ),

            //금요일
            Text('3월 10일',
              style: TextStyle(
                fontSize: 20,
              ),),
            Text('금요일',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),),
            Container(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 50,
                  ),
                  Column(
                    children: [
                      Text('조식',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      Container(
                        height: 15,
                      ),
                      Text('★콩비지찌개★',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.red
                        ),),
                      Text('쌀밥',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('메추리알곤약조림',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('오복채무침',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('열무김치',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('음료/누룽지',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),
                  Container(
                    width: 100,
                  ),
                  Column(
                    children: [
                      Text('중식',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      Container(
                        height: 15,
                      ),
                      Text('★삼겹살김치찌개★',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.red
                        ),),
                      Text('쌀밥',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('생선가스, 타르타르소스',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('명엽채볶음',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('깻잎무침',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('깍두기',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),
                  Container(
                    width: 100,
                  ),
                  Column(
                    children: [
                      Text('석식',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      Container(
                        height: 15,
                      ),
                      Text('★함박스테이크, 데미소스★',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.red
                        ),),
                      Text('쌀밥',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('맑은우동국물',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('양배추샐러드, 드레싱',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('모듬피클',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text(' ',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),
                  Container(
                    width: 50,
                  ),
                ],
              ),
            ),
            Divider(
              height: 20.0,
              thickness: 1.5,
              color: Colors.grey,
            ),

            //토요일
            Text('3월 11일',
              style: TextStyle(
                fontSize: 20,
              ),),
            Text('토요일',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),),
            Container(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 50,
                  ),
                  Column(
                    children: [
                      Text('조식',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      Container(
                        height: 15,
                      ),
                      Text('★콩비지찌개★',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.red
                        ),),
                      Text('쌀밥',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('메추리알곤약조림',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('오복채무침',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('열무김치',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('음료/누룽지',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),
                  Container(
                    width: 100,
                  ),
                  Column(
                    children: [
                      Text('중식',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      Container(
                        height: 15,
                      ),
                      Text('★삼겹살김치찌개★',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.red
                        ),),
                      Text('쌀밥',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('생선가스, 타르타르소스',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('명엽채볶음',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('깻잎무침',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('깍두기',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),
                  Container(
                    width: 100,
                  ),
                  Column(
                    children: [
                      Text('석식',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      Container(
                        height: 15,
                      ),
                      Text('★함박스테이크, 데미소스★',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.red
                        ),),
                      Text('쌀밥',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('맑은우동국물',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('양배추샐러드, 드레싱',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('모듬피클',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text(' ',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),
                  Container(
                    width: 50,
                  ),
                ],
              ),
            ),
            Divider(
              height: 20.0,
              thickness: 1.5,
              color: Colors.grey,
            ),

            //일요일
            Text('3월 12일',
              style: TextStyle(
                fontSize: 20,
              ),),
            Text('일요일',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),),
            Container(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 50,
                  ),
                  Column(
                    children: [
                      Text('조식',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      Container(
                        height: 15,
                      ),
                      Text('★콩비지찌개★',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.red
                        ),),
                      Text('쌀밥',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('메추리알곤약조림',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('오복채무침',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('열무김치',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('음료/누룽지',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),
                  Container(
                    width: 100,
                  ),
                  Column(
                    children: [
                      Text('중식',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      Container(
                        height: 15,
                      ),
                      Text('★삼겹살김치찌개★',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.red
                        ),),
                      Text('쌀밥',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('생선가스, 타르타르소스',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('명엽채볶음',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('깻잎무침',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('깍두기',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),
                  Container(
                    width: 100,
                  ),
                  Column(
                    children: [
                      Text('석식',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      Container(
                        height: 15,
                      ),
                      Text('★함박스테이크, 데미소스★',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.red
                        ),),
                      Text('쌀밥',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('맑은우동국물',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('양배추샐러드, 드레싱',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text('모듬피클',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      Text(' ',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),
                  Container(
                    width: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
