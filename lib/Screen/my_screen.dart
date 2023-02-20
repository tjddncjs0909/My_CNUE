// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {

  final Uri url1 = Uri.parse('https://github.com/tjddncjs0909/tjddncjs0909');

  @override
  Widget build(BuildContext context) {
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
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Text('My CNUE',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('(학교 생활 도우미)',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 10,
            ),
            Text('문의',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text('(디자인 및 기능 제안, 오류 제보 등)',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('E-Mail : tjddncjs0909@naver.com',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                OutlinedButton(
                  onPressed:(){
                    launchUrl(Uri.parse("https://github.com/tjddncjs0909/tjddncjs0909"),
                        mode: LaunchMode.externalApplication);
                  },
                  child: Text('Github',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(':   소스코드 공개, 앱 공지사항',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            SizedBox(
              height: 20,
            ),
            Text('* 저작권 안내 *',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.red
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('해당 앱은 춘천교대 재학생이 학생들의 편의를 위해 비영리 목적으로 만든 앱입니다.'
                ' 해당 앱을 통한 개인적인 비영리 목적의 활용 및 2차 창작은 얼마든지 허용됩니다.',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      )
    );
  }
}
