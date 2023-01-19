// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  
  final Uri url1 = Uri.parse("https://www.naver.com/"); // 네이버

  // 시간 데이터
  var date = DateTime.now();
  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("a HH:mm ").format(now);
  }

  //UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('홈',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          //아이콘 1(setting)
          IconButton(
              onPressed: (){
              },
              icon: Icon(Icons.settings)),
        ]
      ),

      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              leading: Text(
                '앱 업데이트 공지',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              padding: const EdgeInsets.all(10),
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[400],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('2022/12/28 19:27',
                    style: TextStyle(
                      fontSize: 15,
                    ),),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text('공지사항1')
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              padding: const EdgeInsets.all(10),
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[400],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('2023/01/04 21:48',
                    style: TextStyle(
                      fontSize: 15,
                    ),),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text('공지사항2')
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              padding: const EdgeInsets.all(10),
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[400],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('2023/01/09 21:56',
                    style: TextStyle(
                      fontSize: 15,
                    ),),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text('공지사항3')
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              padding: const EdgeInsets.all(10),
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[400],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('2023/01/12 13:21',
                    style: TextStyle(
                      fontSize: 15,
                    ),),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text('공지사항4')
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}