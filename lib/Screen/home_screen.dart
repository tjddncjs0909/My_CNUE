// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cnue_food_app/Screen/schoolfood_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  
  final Uri url1 = Uri.parse("https://www.cnue.ac.kr/cnue/index.do"); // 학교 홈
  final Uri url2 = Uri.parse("https://www.cnue.ac.kr/cnue/info/schedule.do?mode=list&cYear=2023&allYn=Y");
  final Uri url3 = Uri.parse("https://www.cnue.ac.kr/cnue/news/notice03.do");
  final Uri url4 = Uri.parse("https://www.cnue.ac.kr/life/index.do");
  final Uri url5 = Uri.parse("https://www.cnue.ac.kr/cnue/uni/ethics.do");
  final Uri url6 = Uri.parse("https://cafe.daum.net/cnuefor15");

  // 시간 데이터
  var date = DateTime.now();
  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("a HH:mm ").format(now);
  }

  final db = FirebaseFirestore.instance;

  // 오늘의 메뉴
  List<String> menu_1 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> menu_2 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> menu_3 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];

  late DateFormat daysFormat;

  var now1 = DateTime.now();

  int num = 0;

  double menu_fontsize_1 = 20;
  double menu_fontsize_2 = 15;

  double tel_font_size = 14;

  static const List<String> telnum = [
    "tel:0332606400", // 윤리 0
    "tel:0332606410", // 국어 1
    "tel:0332606420", // 사회 2
    "tel:0332606430", // 교육 3
    "tel:0332606450", // 수학 4
    "tel:0332606460", // 과학 5
    "tel:0332606470", // 실과 6
    "tel:0332606480", // 음악 7
    "tel:0332606490", // 미술 8
    "tel:0332606500", // 체육 9
    "tel:0332606520", // 영어 10
    "tel:0332606530", // 컴퓨터 11
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // time calling
    initializeDateFormatting();
    daysFormat = DateFormat.EEEE('ko');
    Refreshing();
  }

  Refreshing(){
    if(daysFormat.format(now1) == "월요일"){
      num = 1;
    }
    else if(daysFormat.format(now1) == "화요일"){
      num = 2;
    }
    else if(daysFormat.format(now1) == "수요일"){
      num = 3;
    }
    else if(daysFormat.format(now1) == "목요일"){
      num = 4;
    }
    else if(daysFormat.format(now1) == "금요일"){
      num = 5;
    }
    else if(daysFormat.format(now1) == "토요일"){
      num = 6;
    }
    else if(daysFormat.format(now1) == "일요일"){
      num = 7;
    }

    db.collection('${num}_${daysFormat.format(now1)}').doc('1_조식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;

      for (int i = 0; i < 6; i++) {
        menu_1[i] = map['$i'];
      }
    }
    );
    db.collection('${num}_${daysFormat.format(now1)}').doc('2_중식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;

      for (int i = 0; i < 6; i++) {
        menu_2[i] = map['$i'];
      }
    }
    );
    db.collection('${num}_${daysFormat.format(now1)}').doc('3_석식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;

      for (int i = 0; i < 6; i++) {
        menu_3[i] = map['$i'];
      }
    }
    );
  }

  void showToast(){
    Fluttertoast.showToast(
      msg: "메뉴가 업데이트 되었습니다.",
      gravity: ToastGravity.BOTTOM,
      fontSize: 13,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.black,
      textColor: Colors.white70,
    );
  }

  //UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY CNUE',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white10,
        actions: [
          IconButton(
              onPressed: (){
                Refreshing();
                showToast();
              },
              color: Colors.black,
              icon: Icon(Icons.refresh_rounded)),
          IconButton(
              onPressed: (){
              },
              color: Colors.black,
              icon: Icon(Icons.settings)),
        ]
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Text('오늘의 학식 메뉴',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),),
            SingleChildScrollView(
              padding: EdgeInsets.all(20),
              scrollDirection: Axis.horizontal,
              child: Stack(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(0),
                        height: 250,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[300],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            TimerBuilder.periodic(Duration(milliseconds: 100), builder: (context){
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text('조식',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: menu_fontsize_1
                                    ),),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text('★${menu_1[0]}★',
                                    style: TextStyle(
                                        fontSize: menu_fontsize_2,
                                        color: Colors.red
                                    ),),
                                  for(int i=1; i<6; i++)
                                    Text('${menu_1[i]}',
                                      style: TextStyle(
                                          fontSize: menu_fontsize_2
                                      ),),
                                ],
                              );
                            }
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        height: 250,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[300],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            TimerBuilder.periodic(Duration(milliseconds: 100), builder: (context){
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text('중식',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                    ),),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text('★${menu_2[0]}★',
                                    style: TextStyle(
                                        fontSize: menu_fontsize_2,
                                        color: Colors.red
                                    ),),
                                  for(int i=1; i<6; i++)
                                    Text('${menu_2[i]}',
                                      style: TextStyle(
                                          fontSize: menu_fontsize_2
                                      ),),
                                ],
                              );
                            }
                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        height: 250,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[300],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            TimerBuilder.periodic(Duration(milliseconds: 100), builder: (context){
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text('석식',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: menu_fontsize_1
                                    ),),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text('★${menu_3[0]}★',
                                    style: TextStyle(
                                        fontSize: menu_fontsize_2,
                                        color: Colors.red
                                    ),),
                                  for(int i=1; i<6; i++)
                                    Text('${menu_3[i]}',
                                      style: TextStyle(
                                          fontSize: menu_fontsize_2
                                      ),),
                                ],
                              );
                            }
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),
            Text('CNUE 소식',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                        onPressed:(){
                          launchUrl(url1,);
                        },
                        icon: Icon(
                            Icons.home,
                            size: 30,
                            color: Colors.redAccent)
                    ),
                    Text("학교 홈"),

                    IconButton(
                        onPressed:(){
                          launchUrl(url4);
                        },
                        icon: Icon(
                          Icons.home_work,
                          size: 30,
                          color: Colors.blueAccent,
                        )
                    ),
                    Text("생활관"),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        onPressed:(){
                          launchUrl(url2);
                        },
                        icon: Icon(
                          Icons.calendar_month,
                          size: 30,
                          color: Colors.amberAccent,
                        )
                    ),
                    Text("학사 일정"),
                    IconButton(
                        onPressed:(){
                          launchUrl(url5);
                        },
                        icon: Icon(
                          Icons.work_history,
                          size: 30,
                          color: Colors.purple,
                        )
                    ),
                    Text("학과 홈페이지"),

                  ],
                ),

                Column(
                  children: [
                    IconButton(
                        onPressed:(){
                          launchUrl(url3);
                        },
                        icon: Icon(
                          Icons.speaker_notes,
                          size: 30,
                          color: Colors.green,
                        )
                    ),
                    Text("학생 공지"),
                    IconButton(
                        onPressed:(){
                          launchUrl(url6);
                        },
                        icon: Icon(
                          Icons.wechat,
                          size: 30,
                          color: Colors.grey,
                        )
                    ),
                    Text("석사동 친구들"),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text("학내 연락처",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),),
            SizedBox(
              height: 10,
            ),
            Text("<학과 사무실>",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("윤리교육과 :",
                          style: TextStyle(
                            fontSize: tel_font_size,
                          ),),
                        TextButton(
                            onPressed:(){
                              launchUrl(Uri.parse(telnum[0]));
                            },
                          child: Text("033-260-6400",
                            style: TextStyle(
                                fontSize: tel_font_size
                            ),),
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text("국어교육과 :",
                          style: TextStyle(
                            fontSize: tel_font_size,
                          ),),
                        TextButton(
                          onPressed:(){
                            launchUrl(Uri.parse(telnum[1]));
                          },
                          child: Text("033-260-6410",
                            style: TextStyle(
                                fontSize: tel_font_size
                            ),),
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text("사회과교육과 :",
                          style: TextStyle(
                            fontSize: tel_font_size,
                          ),),
                        TextButton(
                          onPressed:(){
                            launchUrl(Uri.parse(telnum[2]));
                          },
                          child: Text("033-260-6420",
                            style: TextStyle(
                                fontSize: tel_font_size
                            ),),
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text("교육학과 :",
                          style: TextStyle(
                            fontSize: tel_font_size,
                          ),),
                        TextButton(
                          onPressed:(){
                            launchUrl(Uri.parse(telnum[3]));
                          },
                          child: Text("033-260-6430",
                            style: TextStyle(
                                fontSize: tel_font_size
                            ),),
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text("수학교육과 :",
                          style: TextStyle(
                            fontSize: tel_font_size,
                          ),),
                        TextButton(
                          onPressed:(){
                            launchUrl(Uri.parse(telnum[4]));
                          },
                          child: Text("033-260-6450",
                            style: TextStyle(
                                fontSize: tel_font_size
                            ),),
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text("과학교육과 :",
                          style: TextStyle(
                            fontSize: tel_font_size,
                          ),),
                        TextButton(
                          onPressed:(){
                            launchUrl(Uri.parse(telnum[5]));
                          },
                          child: Text("033-260-6460",
                            style: TextStyle(
                                fontSize: tel_font_size
                            ),),
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("실과교육과 :",
                          style: TextStyle(
                            fontSize: tel_font_size,
                          ),),
                        TextButton(
                          onPressed:(){
                            launchUrl(Uri.parse(telnum[6]));
                          },
                          child: Text("033-260-6470",
                            style: TextStyle(
                                fontSize: tel_font_size
                            ),),
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text("음악교육과 :",
                          style: TextStyle(
                            fontSize: tel_font_size,
                          ),),
                        TextButton(
                          onPressed:(){
                            launchUrl(Uri.parse(telnum[7]));
                          },
                          child: Text("033-260-6480",
                            style: TextStyle(
                                fontSize: tel_font_size
                            ),),
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text("미술교육과 :",
                          style: TextStyle(
                            fontSize: tel_font_size,
                          ),),
                        TextButton(
                          onPressed:(){
                            launchUrl(Uri.parse(telnum[8]));
                          },
                          child: Text("033-260-6490",
                            style: TextStyle(
                                fontSize: tel_font_size
                            ),),
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text("체육교육과 :",
                          style: TextStyle(
                            fontSize: tel_font_size,
                          ),),
                        TextButton(
                          onPressed:(){
                            launchUrl(Uri.parse(telnum[9]));
                          },
                          child: Text("033-260-6500",
                            style: TextStyle(
                                fontSize: tel_font_size
                            ),),
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text("영어교육과 :",
                          style: TextStyle(
                            fontSize: tel_font_size,
                          ),),
                        TextButton(
                          onPressed:(){
                            launchUrl(Uri.parse(telnum[10]));
                          },
                          child: Text("033-260-6520",
                            style: TextStyle(
                                fontSize: tel_font_size
                            ),),
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),),
                      ],
                    ),

                    Row(
                      children: [
                        Text("컴퓨터교육과 :",
                          style: TextStyle(
                            fontSize: tel_font_size,
                          ),),
                        TextButton(
                          onPressed:(){
                            launchUrl(Uri.parse(telnum[11]));
                          },
                          child: Text("033-260-6530",
                            style: TextStyle(
                                fontSize: tel_font_size
                            ),),
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}