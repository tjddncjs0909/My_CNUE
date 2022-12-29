import 'package:container_widget_reminding_20/HomeScreen.dart';
import 'package:container_widget_reminding_20/School_Menu.dart';
import 'package:container_widget_reminding_20/MY.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
// 탭을 이동할 때 쓸 변수!
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 40, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    School_Menu(),
    ScreenC(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: '학식메뉴',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'MY',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // 아랫줄을 쓰지 않아도 탭이 4개 미만인 경우 기본으로 설정된다.
        // type: BottomNavigationBarType.fixed,

        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
      ),
    );
  }
}
