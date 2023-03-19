// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, sort_child_properties_last, curly_braces_in_flow_control_structures

import 'package:cnue_food_app/Screen/schoolfood_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cnue_food_app/Screen/schoolfood_screen_next.dart';


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  
  final Uri url1 = Uri.parse("https://www.cnue.ac.kr/cnue/index.do");
  final Uri url2 = Uri.parse("https://www.cnue.ac.kr/cnue/info/schedule.do?mode=list&cYear=2023&allYn=Y");
  final Uri url3 = Uri.parse("https://www.cnue.ac.kr/cnue/news/notice03.do");
  final Uri url4 = Uri.parse("https://www.cnue.ac.kr/life/index.do");
  final Uri url5 = Uri.parse("https://www.cnue.ac.kr/cnue/uni/ethics.do");
  final Uri url6 = Uri.parse("https://linktr.ee/cnue");
  final Uri url_menu = Uri.parse("https://www.cnue.ac.kr/life/info/food.do");
  // 시간 데이터
  var date = DateTime.now();

  String getSystemTime1() {
    var now = DateTime.now();
    return DateFormat("MM월 dd일").format(now);
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
  String kcal_1 = "";
  List<String> menu_2 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  String kcal_2 = "";
  List<String> menu_3 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  String kcal_3 = "";

  late DateFormat daysFormat;
  var now1 = DateTime.now();

  int num = 0;
  bool _isdayoff  = false;



  double tel_font_size = 14;

  final List<String> list1=[
    "1_조식",
    "2_중식",
    "3_석식"
  ];

  List<String> dropdownList = ['자세히 보기','이번주 메뉴', '지난 메뉴', '다음 주 메뉴'];
  String selectedDropdown = '자세히 보기';

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
      _isdayoff = true;
    }
    else if(daysFormat.format(now1) == "일요일"){
      num = 7;
      _isdayoff = true;
    }
    for(int j=0; j<3; j++){
      db.collection('${num}_${daysFormat.format(now1)}').doc(list1[j])
          .get().then((DocumentSnapshot ds) {
        Map<String, dynamic> map = ds.data() as Map<String, dynamic>;
        if(j==0){
          for (int i = 0; i < 6; i++) {
            menu_1[i] = map['$i'];
          }
          kcal_1 = map['칼로리'];
        }
        else if(j==1){
          for (int i = 0; i < 6; i++) {
            menu_2[i] = map['$i'];
          }
          kcal_2 = map['칼로리'];

        }
        else{
          for (int i = 0; i < 6; i++) {
            menu_3[i] = map['$i'];
          }
          kcal_3 = map['칼로리'];
        }
      }
      );
    }
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

    double menu_fontsize_1 = MediaQuery.of(context).size.height / 35;
    double menu_fontsize_2 = MediaQuery.of(context).size.height / 50;



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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('오늘의 학식 메뉴',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                  ),),
                DropdownButton(
                  value: selectedDropdown,
                  items: dropdownList.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedDropdown = value!;
                      if(selectedDropdown == '이번주 메뉴'){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => school_food_screen()),
                        );
                      }
                      else if(selectedDropdown == '지난 메뉴'){
                        launchUrl(url_menu,
                            mode: LaunchMode.externalApplication);
                      }
                      else if(selectedDropdown == '다음 주 메뉴'){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => school_food_screen_next()),
                        );
                      }
                    });
                  },
                ),
              ],
            ),
            TimerBuilder.periodic(
                Duration(seconds: 1), builder: (context){
              return Text('(${getSystemTime1()} : ${daysFormat.format(now1)})',
                style: TextStyle(
                    fontSize: 15
                ),);
            }
            ),
            SingleChildScrollView(
              padding: EdgeInsets.all(20),
              scrollDirection: Axis.horizontal,
              child: Stack(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(20),
                        width: 200,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.lightGreen[300],
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TimerBuilder.periodic(Duration(milliseconds: 100), builder: (context){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('조식',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: menu_fontsize_1
                                        ),),
                                      Text(!_isdayoff ? "07:30~09:00" : "08:00~09:00",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: menu_fontsize_2
                                        ),),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(kcal_1+" Kcal",
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(menu_1[0],
                                    style: TextStyle(
                                        fontSize: menu_fontsize_2,
                                        color: Colors.red,
                                      fontWeight: FontWeight.bold
                                    ),),
                                  for(int i=1; i<6; i++)
                                    Text(menu_1[i],
                                      style: TextStyle(
                                          fontSize: menu_fontsize_2
                                      ),
                                    ),
                                  SizedBox(
                                    height: 30,
                                  )
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
                        padding: EdgeInsets.all(20),
                        width: 200,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.amber[200],
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TimerBuilder.periodic(Duration(milliseconds: 100), builder: (context){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('중식',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: menu_fontsize_1
                                        ),),
                                      Text(!_isdayoff ? "11:30~13:30" : "12:00~13:00",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: menu_fontsize_2
                                        ),),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(kcal_2+" Kcal",
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(menu_2[0],
                                    style: TextStyle(
                                        fontSize: menu_fontsize_2,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  for(int i=1; i<6; i++)
                                    Text(menu_2[i],
                                      style: TextStyle(
                                          fontSize: menu_fontsize_2
                                      ),
                                    ),
                                  SizedBox(
                                    height: 30,
                                  )
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
                        padding: EdgeInsets.all(20),
                        width: 200,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.blueAccent[100],
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TimerBuilder.periodic(Duration(milliseconds: 100), builder: (context){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('석식',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: menu_fontsize_1
                                        ),),
                                      Text(!_isdayoff ? "17:00~18:30" : "17:00~18:00",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: menu_fontsize_2
                                        ),),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(kcal_3+" Kcal",
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text('${menu_3[0]}',
                                    style: TextStyle(
                                        fontSize: menu_fontsize_2,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  for(int i=1; i<6; i++)
                                    Text(menu_3[i],
                                      style: TextStyle(
                                          fontSize: menu_fontsize_2
                                      ),
                                    ),
                                  SizedBox(
                                    height: 30,
                                  )
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
                          launchUrl(url1,
                              mode: LaunchMode.externalApplication
                          );
                        },
                        icon: Icon(
                            Icons.home,
                            size: 30,
                            color: Colors.redAccent)
                    ),
                    Text("학교 홈"),

                    IconButton(
                        onPressed:(){
                          launchUrl(url4,
                              mode: LaunchMode.externalApplication);
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
                          launchUrl(url2,
                              mode: LaunchMode.externalApplication);
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
                          launchUrl(url5,
                              mode: LaunchMode.externalApplication);
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
                          launchUrl(url3,
                              mode: LaunchMode.externalApplication
                          );
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
                          launchUrl(url6,
                              mode: LaunchMode.externalApplication);
                        },
                        icon: Icon(
                          Icons.wechat,
                          size: 30,
                          color: Colors.grey,
                        )
                    ),
                    Text("총학생회"),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      )
    );
  }
}