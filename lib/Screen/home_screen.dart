// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, sort_child_properties_last, curly_braces_in_flow_control_structures

import 'dart:math';

import 'package:cnue_food_app/Screen/schoolfood_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final Uri url2 = Uri.parse(
      "https://www.cnue.ac.kr/cnue/info/schedule.do?mode=list&cYear=2023&allYn=Y");
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

  int _counter = 0;
  int max_num = 30;

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
      max_num = (prefs.getInt('max_num') ?? 30);
    });
  }

  //클릭하면 counter를 증가시킵니다.
  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0) + 1;
      prefs.setInt('counter', _counter);
    });
  }

  _decrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if((prefs.getInt('counter') ?? 0) >= 1){
        _counter = (prefs.getInt('counter') ?? 0) - 1;
        prefs.setInt('counter', _counter);
      }
    });
  }
  _resetCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = 0;
      prefs.setInt('counter', _counter);
    });
  }

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
    "컴퓨터교육과"
  ];

  static const List<String> prof_info_url = [
    "https://www.cnue.ac.kr/ethics/index.do", // 윤리
    "https://www.cnue.ac.kr/korean/index.do", // 국어
    "https://www.cnue.ac.kr/social/index.do", // 사회
    "https://www.cnue.ac.kr/education/index.do", // 교육
    "https://www.cnue.ac.kr/mathmatics/index.do", // 수학
    "https://www.cnue.ac.kr/science/index.do", // 과학
    "https://www.cnue.ac.kr/practical/index.do", // 실과
    "https://www.cnue.ac.kr/music/index.do", // 음악
    "https://www.cnue.ac.kr/art/index.do", // 미술
    "https://www.cnue.ac.kr/physical/index.do", // 체육
    "https://www.cnue.ac.kr/english/index.do", // 영어
    "https://www.cnue.ac.kr/computer/index.do", // 컴퓨터
  ];

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
  bool _isdayoff = false;
  int? _isselectedicon;

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
  List<String> kcal_mon = [
    "",
    "",
    "",
  ];

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
  List<String> kcal_tue = [
    "",
    "",
    "",
  ];

  //수요일
  String Month_wed = "";
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
  List<String> kcal_wed = [
    "",
    "",
    "",
  ];

  //목요일
  String Month_thu = "";
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
  List<String> kcal_thu = [
    "",
    "",
    "",
  ];

  //금요일
  String Month_fri = "";
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
  List<String> kcal_fri = [
    "",
    "",
    "",
  ];

  //토요일
  String Month_sat = "";
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
  List<String> kcal_sat = [
    "",
    "",
    "",
  ];

  //일요일
  String Month_sun = "";
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
  List<String> kcal_sun = [
    "",
    "",
    "",
  ];

  String selected_week = "월요일";
  String selected_Month = "";
  String seleted_day = "";
  List<String> selected_menu_1 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> selected_menu_2 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> selected_menu_3 = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<String> selected_kcal = [
    "",
    "",
    "",
  ];

  double tel_font_size = 14;

  final List<String> list1 = ["1_조식", "2_중식", "3_석식"];

  List<String> dropdownList1 = ['자세히 보기', '지난 메뉴', '다음 주 메뉴'];
  String selectedDropdown1 = '자세히 보기';

  List<String> dropdownList2 = ['30식 선택자', '50식 선택자', '70식 선택자','0회 리셋'];
  String selectedDropdown2 = '30식 선택자';

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    // time calling
    initializeDateFormatting();
    daysFormat = DateFormat.EEEE('ko');
    selected_week = daysFormat.format(now1);
    Refreshing();
    Refreshing_dayinfo();
    Refreshing_menu(selected_week);
    _loadCounter();
  }

  Refreshing(){
    if (daysFormat.format(now1) == "월요일") {
      num = 1;
    }
    else if (daysFormat.format(now1) == "화요일") {
      num = 2;
    }
    else if (daysFormat.format(now1) == "수요일") {
      num = 3;
    }
    else if (daysFormat.format(now1) == "목요일") {
      num = 4;
    }
    else if (daysFormat.format(now1) == "금요일") {
      num = 5;
    }
    else if (daysFormat.format(now1) == "토요일") {
      num = 6;
    }
    else if (daysFormat.format(now1) == "일요일") {
      num = 7;
    }
    db.collection('1_월요일').doc('1_조식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;

      for (int i = 0; i < 6; i++) {
        menu_mon_1[i] = map['$i'];
      }
      Month_mon = map['mon'];
      Day_mon = map['day'];
      kcal_mon[0] = map['칼로리'];
    });
    db.collection('1_월요일').doc('2_중식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;

      for (int i = 0; i < 6; i++) {
        menu_mon_2[i] = map['$i'];
      }
      kcal_mon[1] = map['칼로리'];
    });
    db.collection('1_월요일').doc('3_석식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;

      for (int i = 0; i < 6; i++) {
        menu_mon_3[i] = map['$i'];
      }
      kcal_mon[2] = map['칼로리'];
    });
    db.collection('2_화요일').doc('1_조식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;

      for (int i = 0; i < 6; i++) {
        menu_tue_1[i] = map['$i'];
      }
      Month_tue = map['mon'];
      Day_tue = map['day'];
      kcal_tue[0] = map['칼로리'];
    });
    db.collection('2_화요일').doc('2_중식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;
      for (int i = 0; i < 6; i++) {
        menu_tue_2[i] = map['$i'];
      }
      kcal_tue[1] = map['칼로리'];
    });
    db.collection('2_화요일').doc('3_석식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;
      for (int i = 0; i < 6; i++) {
        menu_tue_3[i] = map['$i'];
      }
      kcal_tue[2] = map['칼로리'];
    });
    db.collection('3_수요일').doc('1_조식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;
      for (int i = 0; i < 6; i++) {
        menu_wed_1[i] = map['$i'];
      }
      Month_wed = map['mon'];
      Day_wed = map['day'];
      kcal_wed[0] = map['칼로리'];
    });
    db.collection('3_수요일').doc('2_중식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;
      for (int i = 0; i < 6; i++) {
        menu_wed_2[i] = map['$i'];
      }
      kcal_wed[1] = map['칼로리'];
    });
    db.collection('3_수요일').doc('3_석식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;
      for (int i = 0; i < 6; i++) {
        menu_wed_3[i] = map['$i'];
      }
      kcal_wed[2] = map['칼로리'];
    });
    db.collection('4_목요일').doc('1_조식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;
      for (int i = 0; i < 6; i++) {
        menu_thu_1[i] = map['$i'];
      }
      kcal_thu[0] = map['칼로리'];
      Month_thu = map['mon'];
      Day_thu = map['day'];
    });
    db.collection('4_목요일').doc('2_중식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;

      for (int i = 0; i < 6; i++) {
        menu_thu_2[i] = map['$i'];
      }
      kcal_thu[1] = map['칼로리'];
    });
    db.collection('4_목요일').doc('3_석식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;

      for (int i = 0; i < 6; i++) {
        menu_thu_3[i] = map['$i'];
      }
      kcal_thu[2] = map['칼로리'];
    });
    db.collection('5_금요일').doc('1_조식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;

      for (int i = 0; i < 6; i++) {
        menu_fri_1[i] = map['$i'];
      }
      Month_fri = map['mon'];
      Day_fri = map['day'];
      kcal_fri[0] = map['칼로리'];
    });
    db.collection('5_금요일').doc('2_중식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;

      for (int i = 0; i < 6; i++) {
        menu_fri_2[i] = map['$i'];
      }
      kcal_fri[1] = map['칼로리'];
    });
    db.collection('5_금요일').doc('3_석식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;

      for (int i = 0; i < 6; i++) {
        menu_fri_3[i] = map['$i'];
      }
      kcal_fri[2] = map['칼로리'];
    });
    db.collection('6_토요일').doc('1_조식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;

      for (int i = 0; i < 6; i++) {
        menu_sat_1[i] = map['$i'];
      }
      Month_sat = map['mon'];
      Day_sat = map['day'];
      kcal_sat[0] = map['칼로리'];
    });
    db.collection('6_토요일').doc('2_중식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;

      for (int i = 0; i < 6; i++) {
        menu_sat_2[i] = map['$i'];
      }
      kcal_sat[1] = map['칼로리'];
    });
    db.collection('6_토요일').doc('3_석식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;

      for (int i = 0; i < 6; i++) {
        menu_sat_3[i] = map['$i'];
      }
      kcal_sat[2] = map['칼로리'];
    });
    db.collection('7_일요일').doc('1_조식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;

      for (int i = 0; i < 6; i++) {
        menu_sun_1[i] = map['$i'];
      }
      Month_sun = map['mon'];
      Day_sun = map['day'];
      kcal_sun[0] = map['칼로리'];
    });
    db.collection('7_일요일').doc('2_중식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;

      for (int i = 0; i < 6; i++) {
        menu_sun_2[i] = map['$i'];
      }
      kcal_sun[1] = map['칼로리'];
    });
    db.collection('7_일요일').doc('3_석식').get().then((DocumentSnapshot ds) {
      Map<String, dynamic> map = ds.data() as Map<String, dynamic>;

      for (int i = 0; i < 6; i++) {
        menu_sun_3[i] = map['$i'];
      }
      kcal_sun[2] = map['칼로리'];
    });
  }
  Refreshing_dayinfo() {
    if (selected_week == "월요일") {
      selected_Month = Month_mon;
      seleted_day = Day_mon;
      for (int i = 0; i < 3; i++) {
        selected_kcal[i] = kcal_mon[i];
      }
    }
    else if (selected_week == "화요일") {
      selected_Month = Month_tue;
      seleted_day = Day_tue;
      for (int i = 0; i < 3; i++) {
        selected_kcal[i] = kcal_tue[i];
      }
    }
    else if (selected_week == "수요일") {
      selected_Month = Month_wed;
      seleted_day = Day_wed;
      for (int i = 0; i < 3; i++) {
        selected_kcal[i] = kcal_wed[i];
      }
    }
    else if (selected_week == "목요일") {
      selected_Month = Month_thu;
      seleted_day = Day_thu;
      for (int i = 0; i < 3; i++) {
        selected_kcal[i] = kcal_thu[i];
      }
    }
    else if (selected_week == "금요일") {
      selected_Month = Month_fri;
      seleted_day = Day_fri;
      for (int i = 0; i < 3; i++) {
        selected_kcal[i] = kcal_fri[i];
      }
    }
    else if (selected_week == "토요일") {
      selected_Month = Month_sat;
      seleted_day = Day_sat;
      for (int i = 0; i < 3; i++) {
        selected_kcal[i] = kcal_sat[i];
      }
    }
    else if (selected_week == "일요일") {
      selected_Month = Month_sun;
      seleted_day = Day_sun;
      for (int i = 0; i < 3; i++) {
        selected_kcal[i] = kcal_sun[i];
      }
    }
  }
  Refreshing_menu(String seleted_week_0){
    if (selected_week == "월요일") {
      for (int i = 0; i < 6; i++) {
        selected_menu_1[i] = menu_mon_1[i];
        selected_menu_2[i] = menu_mon_2[i];
        selected_menu_3[i] = menu_mon_3[i];
      }
      _isdayoff = false;
      _isselectedicon = 1;
    }
    else if (selected_week == "화요일") {
      for (int i = 0; i < 6; i++) {
        selected_menu_1[i] = menu_tue_1[i];
        selected_menu_2[i] = menu_tue_2[i];
        selected_menu_3[i] = menu_tue_3[i];
      }
      _isdayoff = false;
      _isselectedicon = 2;
    }
    else if (selected_week == "수요일") {
      for (int i = 0; i < 6; i++) {
        selected_menu_1[i] = menu_wed_1[i];
        selected_menu_2[i] = menu_wed_2[i];
        selected_menu_3[i] = menu_wed_3[i];
      }
      _isdayoff = false;
      _isselectedicon = 3;
    }
    else if (selected_week == "목요일") {
      for (int i = 0; i < 6; i++) {
        selected_menu_1[i] = menu_thu_1[i];
        selected_menu_2[i] = menu_thu_2[i];
        selected_menu_3[i] = menu_thu_3[i];
      }
      _isdayoff = false;
      _isselectedicon = 4;
    }
    else if (selected_week == "금요일") {
      for (int i = 0; i < 6; i++) {
        selected_menu_1[i] = menu_fri_1[i];
        selected_menu_2[i] = menu_fri_2[i];
        selected_menu_3[i] = menu_fri_3[i];
      }
      _isdayoff = false;
      _isselectedicon = 5;
    }
    else if (selected_week == "토요일") {
      for (int i = 0; i < 6; i++) {
        selected_menu_1[i] = menu_sat_1[i];
        selected_menu_2[i] = menu_sat_2[i];
        selected_menu_3[i] = menu_sat_3[i];
      }
      _isdayoff = true;
      _isselectedicon = 6;
    }
    else if (selected_week == "일요일") {
      for (int i = 0; i < 6; i++) {
        selected_menu_1[i] = menu_sun_1[i];
        selected_menu_2[i] = menu_sun_2[i];
        selected_menu_3[i] = menu_sun_3[i];
      }
      _isdayoff = true;
      _isselectedicon = 7;
    }
  }

  Future<void>Refreshing_total()async{
    await _getFutureBool4();
    await _getFutureBool1();
    await _getFutureBool2(selected_week);
  }

  Future<dynamic> _getFutureBool4() {
    return Future.delayed(Duration(milliseconds: 500))
        .then((onValue) => Refreshing());
  }
  Future<dynamic> _getFutureBool1() {
    return Future.delayed(Duration(milliseconds: 500))
        .then((onValue) => Refreshing_dayinfo());
  }
  Future<dynamic> _getFutureBool2(seleted_week) {
    return Future.delayed(Duration(milliseconds: 500))
        .then((onValue) => Refreshing_menu(seleted_week));
  }

  void showToast() {
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

    TextEditingController val1 = TextEditingController();

    return Scaffold(
        appBar: AppBar(
            title: Text(
              'MY CNUE',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            elevation: 0.0,
            backgroundColor: Colors.white10,
            actions: [
              IconButton(
                  onPressed: () {
                    daysFormat = DateFormat.EEEE('ko');
                    Refreshing();
                    selected_week = daysFormat.format(now1);
                    Refreshing_total();
                    showToast();
                  },
                  color: Colors.black,
                  icon: Icon(Icons.refresh_rounded)),
              IconButton(
                  onPressed: () {},
                  color: Colors.black,
                  icon: Icon(Icons.settings)),
            ]),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(10),
            children: [
              Container(
                  width: 250,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue[100],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                        Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '금주의 학식 메뉴',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0)),
                                          //Dialog Main Title
                                          title: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("기숙사 식당 단가"),
                                            ],
                                          ),
                                          //
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text("일반 이용자 : "),
                                                  Text(
                                                    "5000원",
                                                    style: TextStyle(color: Colors.red),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text("#급식 선택제(기숙사생)#"),
                                              Row(
                                                children: [
                                                  Text("30식 선택자 : "),
                                                  Text(
                                                    "4700원",
                                                    style: TextStyle(color: Colors.red),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("50식 선택자 : "),
                                                  Text(
                                                    "4100원",
                                                    style: TextStyle(color: Colors.red),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("70식 선택자 : "),
                                                  Text(
                                                    "3700원",
                                                    style: TextStyle(color: Colors.red),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text("#6월 제공 식수(급식 선택제)#"),
                                              Row(
                                                children: [Text("30식 선택자 : "), Text("21식")],
                                              ),
                                              Row(
                                                children: [Text("50식 선택자 : "), Text("35식")],
                                              ),
                                              Row(
                                                children: [Text("70식 선택자 : "), Text("49식")],
                                              ),
                                            ],
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text("확인"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                icon: Icon(Icons.info),
                                color: Colors.black,
                              ),
                              DropdownButton(
                                value: selectedDropdown1,
                                items: dropdownList1.map((String item) {
                                  return DropdownMenuItem<String>(
                                    child: Text(item),
                                    value: item,
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedDropdown1 = value!;
                                    if (selectedDropdown1 == '지난 메뉴') {
                                      launchUrl(url_menu,
                                          mode: LaunchMode.externalApplication);
                                    } else if (selectedDropdown1 == '다음 주 메뉴') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                school_food_screen_next()),
                                      );
                                    }
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.orange[200],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '#업데이트 시기#',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '이번주 메뉴 : 일요일 20시~24시',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              '다음주 메뉴 : 화요일 ~ 수요일',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected_week = "월요일";
                                  Refreshing_dayinfo();
                                  Refreshing_menu(selected_week);
                                  _isselectedicon = 1;
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width / 5,
                                  height : MediaQuery.of(context).size.height / 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: _isselectedicon == 1
                                        ? Colors.red[300]
                                        : Colors.grey,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset:
                                        Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    border: Border.all(
                                        color: daysFormat.format(now1) == "월요일" ? Colors.black : Colors.transparent,
                                        width: 3),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [Text("월요일")],
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected_week = "화요일";
                                  Refreshing_dayinfo();
                                  Refreshing_menu(selected_week);
                                  _isselectedicon = 2;
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width / 5,
                                  height : MediaQuery.of(context).size.height / 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: _isselectedicon == 2
                                        ? Colors.orange
                                        : Colors.grey,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset:
                                        Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    border: Border.all(
                                        color: daysFormat.format(now1) == "화요일" ? Colors.black : Colors.transparent,
                                        width: 3),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [Text("화요일")],
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected_week = "수요일";
                                  Refreshing_dayinfo();
                                  Refreshing_menu(selected_week);
                                  _isselectedicon = 3;
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width / 5,
                                  height : MediaQuery.of(context).size.height / 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: _isselectedicon == 3
                                        ? Colors.yellow
                                        : Colors.grey,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset:
                                        Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    border: Border.all(
                                        color: daysFormat.format(now1) == "수요일" ? Colors.black : Colors.transparent,
                                        width: 3),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [Text("수요일")],
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected_week = "목요일";
                                  Refreshing_dayinfo();
                                  Refreshing_menu(selected_week);
                                  _isselectedicon = 4;
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width / 5,
                                  height : MediaQuery.of(context).size.height / 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: _isselectedicon == 4
                                        ? Colors.lightGreen
                                        : Colors.grey,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset:
                                        Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    border: Border.all(
                                        color: daysFormat.format(now1) == "목요일" ? Colors.black : Colors.transparent,
                                        width: 3),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("목요일")
                                    ],
                                  )),
                            ),
                          ],
                        );
                      }),
                      SizedBox(
                        height: 10,
                      ),
                      TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected_week = "금요일";
                                  Refreshing_dayinfo();
                                  Refreshing_menu(selected_week);
                                  _isselectedicon = 5;
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width / 4,
                                  height : MediaQuery.of(context).size.height / 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color:
                                    _isselectedicon == 5 ? Colors.blue : Colors.grey,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset:
                                        Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    border: Border.all(
                                        color: daysFormat.format(now1) == "금요일" ? Colors.black : Colors.transparent,
                                        width: 3),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [Text("금요일")],
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected_week = "토요일";
                                  Refreshing_dayinfo();
                                  Refreshing_menu(selected_week);
                                  _isselectedicon = 6;
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width / 4,
                                  height : MediaQuery.of(context).size.height / 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: _isselectedicon == 6
                                        ? Colors.indigo[200]
                                        : Colors.grey,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset:
                                        Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    border: Border.all(
                                        color: daysFormat.format(now1) == "토요일" ? Colors.black : Colors.transparent,
                                        width: 3),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [Text("토요일")],
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected_week = "일요일";
                                  Refreshing_dayinfo();
                                  Refreshing_menu(selected_week);
                                  _isselectedicon = 7;
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width / 4,
                                  height : MediaQuery.of(context).size.height / 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: _isselectedicon == 7
                                        ? Colors.purple[200]
                                        : Colors.grey,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset:
                                        Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    border: Border.all(
                                        color: daysFormat.format(now1) == "일요일" ? Colors.black : Colors.transparent,
                                        width: 3),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [Text("일요일")],
                                  )),
                            ),
                          ],
                        );
                      }),
                      SizedBox(
                        height: 20,
                      ),
                      FutureBuilder(
                          future: Refreshing_total(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Error: ${snapshot.error}',
                                  style: TextStyle(fontSize: 15),
                                ),
                              );
                            }
                            else{
                              return SizedBox(
                                height: 0,
                              );
                            }
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TimerBuilder.periodic(Duration(milliseconds: 100),
                              builder: (context) {
                                return Text('$selected_Month월 $seleted_day일($selected_week)',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                );
                              }),
                        ],
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
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.lightGreen[300],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset:
                                        Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TimerBuilder.periodic(Duration(milliseconds: 100),
                                          builder: (context) {
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      '조식',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: menu_fontsize_1),
                                                    ),
                                                    SizedBox(
                                                      width: 50,
                                                    ),
                                                    Text(
                                                      !_isdayoff
                                                          ? "07:30~09:00"
                                                          : "08:00~09:00",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: menu_fontsize_2),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "${selected_kcal[0]}Kcal",
                                                      style: TextStyle(
                                                        decoration:
                                                        TextDecoration.underline,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  selected_menu_1[0],
                                                  style: TextStyle(
                                                      fontSize: menu_fontsize_2,
                                                      color: Colors.red,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                for (int i = 1; i < 6; i++)
                                                  Text(
                                                    selected_menu_1[i],
                                                    style: TextStyle(
                                                        fontSize: menu_fontsize_2),
                                                  ),
                                                SizedBox(
                                                  height: 30,
                                                )
                                              ],
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  margin: EdgeInsets.all(0),
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.amber[200],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset:
                                        Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TimerBuilder.periodic(Duration(milliseconds: 100),
                                          builder: (context) {
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      '중식',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: menu_fontsize_1),
                                                    ),
                                                    SizedBox(
                                                      width: 50,
                                                    ),
                                                    Text(
                                                      !_isdayoff
                                                          ? "11:30~13:30"
                                                          : "12:00~13:00",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: menu_fontsize_2),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "${selected_kcal[1]}Kcal",
                                                      style: TextStyle(
                                                        decoration:
                                                        TextDecoration.underline,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  selected_menu_2[0],
                                                  style: TextStyle(
                                                      fontSize: menu_fontsize_2,
                                                      color: Colors.red,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                for (int i = 1; i < 6; i++)
                                                  Text(
                                                    selected_menu_2[i],
                                                    style: TextStyle(
                                                        fontSize: menu_fontsize_2),
                                                  ),
                                                SizedBox(
                                                  height: 30,
                                                )
                                              ],
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  margin: EdgeInsets.all(0),
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.blueAccent[100],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset:
                                        Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TimerBuilder.periodic(Duration(milliseconds: 100),
                                          builder: (context) {
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      '석식',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: menu_fontsize_1),
                                                    ),
                                                    SizedBox(
                                                      width: 50,
                                                    ),
                                                    Text(
                                                      !_isdayoff
                                                          ? "17:00~18:30"
                                                          : "17:00~18:00",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: menu_fontsize_2),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "${selected_kcal[2]}Kcal",
                                                      style: TextStyle(
                                                        decoration:
                                                        TextDecoration.underline,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  selected_menu_3[0],
                                                  style: TextStyle(
                                                      fontSize: menu_fontsize_2,
                                                      color: Colors.red,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                for (int i = 1; i < 6; i++)
                                                  Text(
                                                    selected_menu_3[i],
                                                    style: TextStyle(
                                                        fontSize: menu_fontsize_2),
                                                  ),
                                                SizedBox(
                                                  height: 30,
                                                )
                                              ],
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '사용자 식수 관리',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '(스스로 남은 학식을 관리해보세요!)',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        DropdownButton(
                          value: selectedDropdown2,
                          items: dropdownList2.map((String item) {
                            return DropdownMenuItem<String>(
                              child: Text(item),
                              value: item,
                            );
                          }).toList(),
                          onChanged: (String? value)async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            setState((){
                              selectedDropdown2 = value!;
                              if (selectedDropdown2 == '0회 리셋') {
                                _resetCounter();
                              }
                              else if (selectedDropdown2 == '30식 선택자') {
                                if(selected_Month == "6"){
                                  max_num = 21;
                                }
                                max_num = 30;
                                prefs.setInt('max_num', max_num);
                              }
                              else if (selectedDropdown2 == '50식 선택자') {
                                if(selected_Month == "6"){
                                  max_num = 35;
                                }
                                max_num = 50;
                                prefs.setInt('max_num', max_num);
                              }
                              else{
                                if(selected_Month == "6"){
                                  max_num = 49;
                                }
                                max_num = 70;
                                prefs.setInt('max_num', max_num);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 250,
                            height: 40,
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue[200],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset:
                                  Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("금월 사용 횟수 : ",
                                      style: TextStyle(
                                          fontSize: 18
                                      ),
                                    ),
                                    Text("$_counter 회",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )),
                        GestureDetector(
                          child: IconButton(
                              onPressed: ()async{
                                _incrementCounter();
                              },
                              icon: Icon(Icons.add)
                          ),
                        ),
                        GestureDetector(
                          child: IconButton(
                              onPressed: ()async{
                                _decrementCounter();
                              },
                              icon: Icon(Icons.remove)
                          ),
                        ),
                      ],
                    ),
                    Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.purple[200],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                              Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [if((4700 * (max_num - _counter) < 1000) && (4700 * (max_num - _counter) > 0))
                            if(max_num == 30)
                              Text("${4700 * (max_num - _counter) / 1000}원"
                                  "(${max_num - _counter}식) 남았습니다.",
                                style: TextStyle(
                                    fontSize: 18
                                ),)
                            else if(max_num == 50)
                              Text("${4100 * (max_num - _counter) / 1000}원"
                                  "(${max_num - _counter}식) 남았습니다.",
                                style: TextStyle(
                                    fontSize: 18
                                ),)
                            else
                              Text("${3700 * (max_num - _counter) / 1000}원"
                                  "(${max_num - _counter}식) 남았습니다.",
                                style: TextStyle(
                                    fontSize: 18
                                ),)
                          else if((4700 * (max_num - _counter) <= 0))
                              Text("모두 사용하였습니다.")
                            else
                              if(max_num == 30)
                                Text("${(4700 * (max_num - _counter) / 1000).floor()},"
                                    "${((4700 * (max_num - _counter) % 1000)/100).floor()}00원 "
                                    "(${max_num - _counter}식)남았습니다.",
                                  style: TextStyle(
                                      fontSize: 18
                                  ),)
                              else if(max_num == 50)
                                Text("${(4100 * (max_num - _counter) / 1000).floor()},"
                                    "${((4700 * (max_num - _counter) % 1000)/100).floor()}00원"
                                    "(${max_num - _counter}식)남았습니다.",
                                  style: TextStyle(
                                      fontSize: 18
                                  ),)
                              else
                                Text("${(3700 * (max_num - _counter) / 1000).floor()},"
                                    "${((4700 * (max_num - _counter) % 1000)/100).floor()}00원"
                                    "(${max_num - _counter}식)남았습니다.",
                                  style: TextStyle(
                                      fontSize: 18
                                  ),)
                            ,
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Container(
                width: 250,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.lightGreen[100],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset:
                      Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CNUE 소식',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  launchUrl(url1,
                                      mode: LaunchMode.externalApplication);
                                },
                                icon: Icon(Icons.home,
                                    size: 30, color: Colors.redAccent)),
                            Text("학교 홈"),
                            IconButton(
                                onPressed: () {
                                  launchUrl(url4,
                                      mode: LaunchMode.externalApplication);
                                },
                                icon: Icon(
                                  Icons.home_work,
                                  size: 30,
                                  color: Colors.blueAccent,
                                )),
                            Text("생활관"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  launchUrl(url2,
                                      mode: LaunchMode.externalApplication);
                                },
                                icon: Icon(
                                  Icons.calendar_month,
                                  size: 30,
                                  color: Colors.yellow,
                                )),
                            Text("학사 일정"),
                            IconButton(
                                onPressed: () {
                                  showDialog(context: context, builder:(BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0)),

                                      title: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("학과 홈페이지"),
                                            ],
                                          )
                                        ],
                                      ),
                                      content: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            for(int i=0; i<12; i++)
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(majornum[i],
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),),
                                                  IconButton(
                                                    onPressed: (){
                                                      launchUrl(Uri.parse(prof_info_url[i]),
                                                          mode: LaunchMode.externalApplication);
                                                    },
                                                    icon: Icon(Icons.arrow_forward,
                                                      color: Colors.blue,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text("닫기"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                                },
                                icon: Icon(
                                  Icons.work_history,
                                  size: 30,
                                  color: Colors.purple,
                                )),
                            Text("학과 홈페이지"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(context: context, builder:(BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0)),

                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("학교 공지사항"),
                                          ],
                                        )
                                      ],
                                    ),
                                    content: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("대학공지",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),),
                                              IconButton(
                                                onPressed: (){
                                                  launchUrl(Uri.parse("https://www.cnue.ac.kr/cnue/news/notice01.do"),
                                                      mode: LaunchMode.externalApplication);
                                                },
                                                icon: Icon(Icons.arrow_forward,
                                                  color: Colors.blue,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text("- 등록금 납부 관련 공지",
                                            style: TextStyle(
                                                color: Colors.grey
                                            ),),
                                          Text("- 입학식 및 학위수여식 공지",
                                            style: TextStyle(
                                                color: Colors.grey
                                            ),),
                                          Text("- 교내 냉난방 시설 관련 공지",
                                            style: TextStyle(
                                                color: Colors.grey
                                            ),),
                                          Text("- 각종 의견 공청회 및 학칙 관련 공지",
                                            style: TextStyle(
                                                color: Colors.grey
                                            ),),

                                          SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("학사공지",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),),
                                              IconButton(
                                                onPressed: (){
                                                  launchUrl(Uri.parse("https://www.cnue.ac.kr/cnue/news/notice02.do"),
                                                      mode: LaunchMode.externalApplication);
                                                },
                                                icon: Icon(Icons.arrow_forward,
                                                  color: Colors.blue,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text("- 연간 학사 일정 관련 공지",
                                            style: TextStyle(
                                                color: Colors.grey
                                            ),),
                                          Text("- 참관/수업/종합 실습 관련 공지",
                                            style: TextStyle(
                                                color: Colors.grey
                                            ),),
                                          Text("- 수강 신청/변경/취소 관련 공지",
                                            style: TextStyle(
                                                color: Colors.grey
                                            ),),
                                          Text("- 전과/재입학 관련 공지",
                                            style: TextStyle(
                                                color: Colors.grey
                                            ),),
                                          Text("- 성적 및 강의평가 관련 공지 ",
                                            style: TextStyle(
                                                color: Colors.grey
                                            ),),
                                          SizedBox(
                                            height: 30,
                                          ),


                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("학생공지",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),),
                                              IconButton(
                                                onPressed: (){
                                                  launchUrl(Uri.parse("https://www.cnue.ac.kr/cnue/news/notice03.do"),
                                                      mode: LaunchMode.externalApplication);
                                                },
                                                icon: Icon(Icons.arrow_forward,
                                                  color: Colors.blue,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text("- 각종 공모전 및 대외활동 공지",
                                            style: TextStyle(
                                                color: Colors.grey
                                            ),),
                                          Text("- 교내외 장학금 관련 공지",
                                            style: TextStyle(
                                                color: Colors.grey
                                            ),),
                                          Text("- 교내 시설(강의동 및 체력단련실) 사용 안내",
                                            style: TextStyle(
                                                color: Colors.grey
                                            ),),
                                          Text("- 예비군 일정 안내",
                                            style: TextStyle(
                                                color: Colors.grey
                                            ),),
                                          SizedBox(
                                            height: 30,
                                          ),




                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("닫기"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                              },
                              icon: Icon(
                                Icons.speaker_notes,
                                size: 30,
                                color: Colors.green,
                              ),
                            ),
                            Text("학교 공지사항"),

                            IconButton(
                                onPressed: () {
                                  launchUrl(url6,
                                      mode: LaunchMode.externalApplication);
                                },
                                icon: Icon(
                                  Icons.wechat,
                                  size: 30,
                                  color: Colors.grey,
                                )),
                            Text("총학생회"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                )),
            ],
          ),
        )
    );
  }
}
