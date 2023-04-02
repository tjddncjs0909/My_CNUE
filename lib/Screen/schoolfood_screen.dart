// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class school_food_screen extends StatefulWidget {
  const school_food_screen({Key? key}) : super(key: key);

  @override
  State<school_food_screen> createState() => _school_food_screenState();
}

class _school_food_screenState extends State<school_food_screen> {

  double menu_font_size = 15;

  double menu_fontsize_1 = 20;
  double menu_fontsize_2 = 15;

  // 월요일
  String Month_mon = "";
  String Day_mon = "";
  List<String> menu_mon_1 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> menu_mon_2 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> menu_mon_3 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> kcal_mon = ["", "", "",];

  // 화요일
  String Month_tue = "";
  String Day_tue = "";
  List<String> menu_tue_1 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> menu_tue_2 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> menu_tue_3 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> kcal_tue = ["", "", "",];

  //수요일
  String Month_wed= "";
  String Day_wed = "";
  List<String> menu_wed_1 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> menu_wed_2 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> menu_wed_3 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> kcal_wed = ["", "", "",];

  //목요일
  String Month_thu= "";
  String Day_thu = "";
  List<String> menu_thu_1 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> menu_thu_2 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> menu_thu_3 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> kcal_thu = ["", "", "",];

  //금요일
  String Month_fri= "";
  String Day_fri = "";
  List<String> menu_fri_1 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> menu_fri_2 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> menu_fri_3 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> kcal_fri = ["", "", "",];

  //토요일
  String Month_sat= "";
  String Day_sat = "";
  List<String> menu_sat_1 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> menu_sat_2 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> menu_sat_3 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> kcal_sat = ["", "", "",];


  //일요일
  String Month_sun= "";
  String Day_sun = "";
  List<String> menu_sun_1 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> menu_sun_2 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> menu_sun_3 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> kcal_sun = ["", "", "",];


  String selected_week = "월요일";
  String selected_Month = "";
  String seleted_day = "";
  List<String> selected_menu_1 = [
    "","","","","","",
  ];
  List<String> selected_menu_2 = [
    "","","","","","",
  ];
  List<String> selected_menu_3 = [
    "","","","","","",
  ];
  List<String> selected_kcal= ["", "", "",];


  final db = FirebaseFirestore.instance;

  Refreshing() {


  }

  late DateFormat daysFormat;

  var now1 = DateTime.now();
  bool _isdayoff  = false;

  
  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("HH:mm:ss ").format(now);
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

  @override
  void initState() {
    super.initState();

    // time calling
    initializeDateFormatting();
    daysFormat = DateFormat.EEEE('ko');

    // calling menu information
    Refreshing();
  }

  final Uri url1 = Uri.parse('https://www.cnue.ac.kr/life/info/food.do');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('MY CNUE',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: (){
                  Refreshing();
                  showToast();
                },
                icon: Icon(Icons.refresh),
              color: Colors.black,),
            IconButton(
                onPressed: (){
                },
                icon: Icon(Icons.settings),
              color: Colors.black,),
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
                    fontSize: 35,
                  ),
                )
              ],
            ),
            TimerBuilder.periodic(Duration(milliseconds: 100), builder: (context){
              return Text('($Month_mon월 $Day_mon일 ~ $Month_sun월 $Day_sun일)',
                style: TextStyle(
                  fontSize: 20,
                ),
              );
            }
            ),

            SizedBox(
              height: 5,
            ),
            Text('* 일요일 20시 ~ 24시에 업데이트 됩니다. *',
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
                TimerBuilder.periodic(Duration(seconds: 1), builder: (context){
                  return Text('${daysFormat.format(now1)} ${getSystemTime()}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
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
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20,
            ),
            TimerBuilder.periodic(Duration(milliseconds: 100), builder: (context){
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$selected_Month월 $seleted_day일',
                      style: TextStyle(
                        fontSize: 20,
                      ),),
                    Text(selected_week,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),),
                  ]
              );
            }),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
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
                                  Text("07:30~09:00",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: menu_fontsize_2
                                    ),),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(" Kcal",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(selected_menu_1[0],
                                style: TextStyle(
                                    fontSize: menu_fontsize_2,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold
                                ),),
                              for(int i=1; i<6; i++)
                                Text(selected_menu_1[i],
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
                                  Text("07:30~09:00",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: menu_fontsize_2
                                    ),),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(" Kcal",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(selected_menu_2[0],
                                style: TextStyle(
                                    fontSize: menu_fontsize_2,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold
                                ),),
                              for(int i=1; i<6; i++)
                                Text(selected_menu_2[i],
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
                  Container(
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(20),
                    width: 200,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blueAccent[100],
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
                                  Text("17:00~18:00",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: menu_fontsize_2
                                    ),),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("1336 Kcal",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(selected_menu_3[0],
                                style: TextStyle(
                                    fontSize: menu_fontsize_2,
                                    color: Colors.red
                                ),),
                              for(int i=1; i<6; i++)
                                Text(selected_menu_3[i],
                                  style: TextStyle(
                                    fontSize: menu_fontsize_2,
                                  ),),
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
            ),
          ],
        ),
      ),
    );
  }
}
