// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_conditional_assignment

import 'package:cnue_food_app/Screen/major_calling_info.dart';
import 'package:cnue_food_app/Screen/my_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MajorInfoScreen extends StatefulWidget {
  const MajorInfoScreen({Key? key,
    required this.majorname,
    required this.link,
    required this.major_num}) : super(key: key);

  final String majorname;
  final String link;
  final int major_num;

  @override
  State<MajorInfoScreen> createState() => _MajorInfoScreenState();
}

class _MajorInfoScreenState extends State<MajorInfoScreen> {

  final db = FirebaseFirestore.instance;

  static int info_num = 20;

  static List<String> name = [
    "","","","","","","","","","","","","","",
    "","","","","","","","","","","","","","",
  ];
  static List<String> room = [
    "","","","","","","","","","","","","","",
    "","","","","","","","","","","","","","",
  ];
  static List<String> email = [
    "","","","","","","","","","","","","","",
    "","","","","","","","","","","","","","",
  ];
  static List<String> lecture = [
    "","","","","","","","","","","","","","","","","","","","","","","","",""
    ,"","","","","","","","","","","","","","","","","","","","","","","","",
  ];
  static List<dynamic> prof_info=[
    "","","","","","","","","","","","","","",
  ];

  prof_info_form(String name, String pos, String mail){
    return Card(
      child: ListTile(
        title: Text(name,
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(pos),
            Text(mail),
          ],
        ),
        trailing: IconButton(
            onPressed: (){
              Clipboard.setData(ClipboardData(text: mail));
              showToast();
            },
            icon: Icon(Icons.copy)),
        isThreeLine: true,
      ),
    );
  }

  Refreshing()async{
    if(widget.major_num + 1 < 10){
      await db.collection('0${widget.major_num + 1}_${widget.majorname}').doc('0')
          .get().then((DocumentSnapshot ds){
        Map<String, dynamic> map = ds.data() as Map<String, dynamic>;
        info_num = map['총 인원'];
      }
      );
      for(int i=0; i<info_num; i++){
        await db.collection('0${widget.major_num + 1}_${widget.majorname}').doc('${i}')
            .get().then((DocumentSnapshot ds){
          Map<String, dynamic> map = ds.data() as Map<String, dynamic>;
          name[i] = map['name'];
          email[i] = map['email'];
          room[i] = map['room'];
          prof_info[i] = prof_info_form(name[i], room[i], email[i]);
        }
        );
      }
    }
    else if(widget.major_num + 1 < 13){
      await db.collection('${widget.major_num + 1}_${widget.majorname}').doc('0')
          .get().then((DocumentSnapshot ds){
        Map<String, dynamic> map = ds.data() as Map<String, dynamic>;
        info_num = map['총 인원'];
      }
      );
      print(info_num);
      for(int i=0; i<info_num; i++){
        await db.collection('${widget.major_num + 1}_${widget.majorname}').doc('${i}')
            .get().then((DocumentSnapshot ds){
          Map<String, dynamic> map = ds.data() as Map<String, dynamic>;
          name[i] = map['name'];
          email[i] = map['email'];
          room[i] = map['room'];
          prof_info[i] = prof_info_form(name[i], room[i], email[i]);
        }
        );
      }
    }
    else if(widget.majorname == "원어민 / 강사"){
      await db.collection('강사+타학교').doc('lecturer_001')
          .get().then((DocumentSnapshot ds){
        Map<String, dynamic> map = ds.data() as Map<String, dynamic>;
        info_num = map['총 숫자'];
      }
      );
      print(info_num);
      for(int i=0; i<=info_num; i++){
        if(i<9){
          await db.collection('강사+타학교').doc('lecturer_00${i+1}')
              .get().then((DocumentSnapshot ds){
            Map<String, dynamic> map = ds.data() as Map<String, dynamic>;
            name[i] = map['name'];
            email[i] = map['email'];
            lecture[i] = map['lecture'];
            prof_info[i] = prof_info_form(name[i], lecture[i], email[i]);
          }
          );
        }
        else if(i<99){
          await db.collection('강사+타학교').doc('lecturer_0${i+1}')
              .get().then((DocumentSnapshot ds){
            Map<String, dynamic> map = ds.data() as Map<String, dynamic>;
            name[i] = map['name'];
            email[i] = map['email'];
            lecture[i] = map['lecture'];
            prof_info[i] = prof_info_form(name[i], lecture[i], email[i]);
          }
          );
        }
        else{
          await db.collection('강사+타학교').doc('lecturer_${i+1}')
              .get().then((DocumentSnapshot ds){
            Map<String, dynamic> map = ds.data() as Map<String, dynamic>;
            name[i] = map['name'];
            email[i] = map['email'];
            lecture[i] = map['lecture'];
            prof_info[i] = prof_info_form(name[i], lecture[i], email[i]);
          }
          );
        }
      }
    }
  }



  void showToast(){
    Fluttertoast.showToast(
        msg: "이메일이 복사되었습니다.",
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Refreshing();
  }

  @override
  Widget build(BuildContext context1) {

    const List<String> major_position = [
      "홍익관 4층",
      "홍익관 315호",
      "석우관 208호",
      "집현관 2층",
      "홍익관 207호",
      "과학관 108호",
      "실과관 108호",
      "음악관 101호",
      "미술관 1층",
      "체육관 1층",
      "집현관 3층",
      "전산관 1층",
    ];

    const List<String> telnum_link = [
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

    List<String> prof_info_url = [
      "https://www.cnue.ac.kr/ethics/prof/prof-dev.do", // 윤리
      "https://www.cnue.ac.kr/korean/prof/prof-dev.do", // 국어
      "https://www.cnue.ac.kr/social/prof/prof-dev.do", // 사회
      "https://www.cnue.ac.kr/education/prof/prof-dev.do", // 교육
      "https://www.cnue.ac.kr/mathmatics/prof/prof-dev.do", // 수학
      "https://www.cnue.ac.kr/science/prof/prof-dev.do", // 과학
      "https://www.cnue.ac.kr/practical/prof/prof-dev.do", // 실과
      "https://www.cnue.ac.kr/music/prof/prof-dev.do", // 음악
      "https://www.cnue.ac.kr/art/prof/prof-dev.do", // 미술
      "https://www.cnue.ac.kr/physical/prof/prof-dev.do", // 체육
      "https://www.cnue.ac.kr/english/prof/prof-dev.do", // 영어
      "https://www.cnue.ac.kr/computer/prof/prof-dev.do", // 컴퓨터
    ];

    const List<String> telnum = [
      "033-260-6400", // 윤리 0
      "033-260-6410", // 국어 1
      "033-260-6420", // 사회 2
      "033-260-6430", // 교육 3
      "033-260-6450", // 수학 4
      "033-260-6460", // 과학 5
      "033-260-6470", // 실과 6
      "033-260-6480", // 음악 7
      "033-260-6490", // 미술 8
      "033-260-6500", // 체육 9
      "033-260-6520", // 영어 10
      "033-260-6530", // 컴퓨터 11
    ];


    return Scaffold(
      appBar: AppBar(
        title: Text('MY CNUE',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),),
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: (){
                print(info_num);
              },
              icon: Icon(Icons.settings,
                color: Colors.black,)),
          IconButton(
              onPressed: (){
                print(prof_info[0]);
                Refreshing();
              },
              color: Colors.black,
              icon: Icon(Icons.refresh_rounded)),
        ],

        elevation: 0.0,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Text(widget.majorname,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
              ),),
            SizedBox(
              height: 20,
            ),
            if(widget.majorname != "원어민 / 강사")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('<학과 사무실>',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context1).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.lime[300],
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
                        Text("위치 : ${major_position[widget.major_num]}",
                          style: TextStyle(
                              fontSize: 20
                          ),),
                        Row(
                          children: [
                            Text("운영시간 : ",
                              style: TextStyle(
                                  fontSize: 15
                              ),),
                            Text("09:00∼18:00 (평일)",
                              style: TextStyle(
                                  fontSize: 15
                              ),),
                          ],
                        ),
                        Text("점심시간 : 12:00∼13:00 (주말 및 공휴일 휴무)",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),),
                        Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text("Tel",
                                    style: TextStyle(
                                        fontSize: 20
                                    ),),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("${telnum[widget.major_num]}",
                                    style: TextStyle(
                                        fontSize: 20
                                    ),),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      launchUrl(Uri.parse(telnum_link[widget.major_num]));
                                    },
                                    icon: Icon(Icons.call,
                                      color: Colors.blue,
                                      size: 40,
                                    ),
                                  )
                                ],
                              ),
                              VerticalDivider(
                                thickness: 2,
                                width: 2,
                                color: Colors.grey,
                              ),
                              Column(
                                children: [
                                  Text("Fax",
                                    style: TextStyle(
                                        fontSize: 20
                                    ),),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("${telnum[widget.major_num]}",
                                    style: TextStyle(
                                        fontSize: 20
                                    ),),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Icon(Icons.fax,
                                    color: Colors.black,
                                    size: 40,),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("* 아이콘 클릭 시 통화 연결됩니다 *",
                          style: TextStyle(
                              fontSize: 15
                          ),),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("<교수진>",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                if(widget.majorname != "원어민 / 강사")
                TextButton(
                    onPressed: (){
                      launchUrl(Uri.parse(prof_info_url[widget.major_num]));
                      print(email[0]);
                    },
                    child: Text("자세히보기 →")),
              ],
            ),
            Text("1. 아이콘 클릭 시 이메일이 자동 복사 됩니다.",
              style: TextStyle(
                  fontSize: 15
              ),),
            Text('2. 비어있거나 잘못된 정보는 제보 해주시면 즉시 반영 하겠습니다.',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TimerBuilder.periodic(
                Duration(seconds: 1), builder: (context){
              return Column(
                children: [
                  for(int i=0; i<info_num; i++)
                    prof_info[i],
                ],
              );
            }
            ),
          ],
        ),
      ),
    );
  }
}