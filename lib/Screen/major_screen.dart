// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cnue_food_app/Screen/major_calling_info.dart';
import 'package:cnue_food_app/Screen/my_screen.dart';
import 'package:flutter/material.dart';

class MajorScreen extends StatefulWidget {
  const MajorScreen({Key? key}) : super(key: key);

  @override
  State<MajorScreen> createState() => _MajorScreenState();
}

class _MajorScreenState extends State<MajorScreen> {

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
  static const List<String> telnum_vis = [
    "033-260-6400", // 윤리 0
    "033-260-6410", // 국어 1
    "033-260-6420", // 사회 2
    "033-260-6430", // 교육 3
    "033-260-6450", // 수학 4
    "033-26-06460", // 과학 5
    "033-260-6470", // 실과 6
    "033-260-6480", // 음악 7
    "033-260-6490", // 미술 8
    "033-260-6500", // 체육 9
    "033-260-6520", // 영어 10
    "033-260-6530", // 컴퓨터 11
  ];

  static const List<String> majornum = [
    "윤리교육과",
    "국어교육과",
    "사회과교육과",
    "교육학과",
    "수학교육과",
    "과학교육과",
    "실과교육과",
    "음악교육과",
    "미술교육과",
    "체육교육과",
    "영어교육과",
    "컴퓨터교육과",
    "원어민 / 강사"
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

  @override
  Widget build(BuildContext context) {
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
              },
              icon: Icon(Icons.settings,
                color: Colors.black,)),
        ],
        elevation: 0.0,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Text('학내 연락처',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text("<학과> - ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                Text("각 학과 사무실 및 교수 연락처",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),),
              ],
            ),
            for(int i=0; i<6; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // 윤리교육과
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        width: (MediaQuery.of(context).size.width - 100) / 2,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[200],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(majornum[i]),
                            IconButton(
                                onPressed:(){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => MajorInfoScreen(
                                          link: prof_info_url[i],
                                          majorname: majornum[i],
                                          major_num: i
                                      )
                                  ),
                                  );
                                },
                                icon: Icon(
                                    Icons.arrow_forward,
                                    size: 20,
                                    color: Colors.blueAccent)
                            ),
                          ],
                        )
                    ),
                  ),
                  // 실과교육과
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        width: (MediaQuery.of(context).size.width - 100) / 2,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[200],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(majornum[i+6]),
                            IconButton(
                                onPressed:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                      MajorInfoScreen(
                                        majorname: majornum[i+6],
                                        link: prof_info_url[i+6],
                                        major_num: i+6,
                                      )
                                  )
                                  );
                                },
                                icon: Icon(
                                    Icons.arrow_forward,
                                    size: 20,
                                    color: Colors.blueAccent)
                            ),
                          ],
                        )
                    ),
                  ),
                ],
              ),
            GestureDetector(
              child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  width: (MediaQuery.of(context).size.width - 100) / 2,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("원어민 / 강사"),
                      IconButton(
                          onPressed:(){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    MajorInfoScreen(
                                      majorname: majornum[12],
                                      link: "",
                                      major_num: 12,
                                    )),
                            );
                          },
                          icon: Icon(
                              Icons.arrow_forward,
                              size: 20,
                              color: Colors.blueAccent)
                      ),
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
