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
        title: Text('MY'),
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
            Text('춘천교대 학식 알리미',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Dev : 윤리 22 천우성',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('오픈소스(소스코드 공개) - Flutter(Dart)',
              style: TextStyle(
                  fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('GitHub : https://github.com/tjddncjs0909/tjddncjs0909',
              style: TextStyle(
                  fontSize: 15,
              ),
            ),
            OutlinedButton(
              child: Text('링크',
                style: TextStyle(
                    fontSize: 20,
                  color: Colors.black87
                ),),
              onPressed: (){
                launchUrl(url1);
              },
            ),
            SizedBox(
              height: 20,
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
            Text('해당 앱은 춘천교대 학생들의 편의를 위해 비영리 목적으로 만들어진 앱이며, '
                '오픈 소스를 통한 2차 창작을 허용하지만,'
                '영리 목적으로 사용하지 않기를 권장합니다.',
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
