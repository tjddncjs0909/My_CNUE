// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cnue_food_app/Data/network.dart';
import 'package:cnue_food_app/Screen/my_screen.dart';
import 'package:cnue_food_app/Screen/outfood_screen.dart';
import 'package:cnue_food_app/Screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'my_location.dart';
import 'package:cnue_food_app/Screen/schoolfood_screen.dart';

const apikey = '1fe9c028a43953322ca5e91c8be23ec1';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  // 탭을 이동할 때 쓸 변수!
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    WeatherScreen(),
    school_food_screen(),
    OutFoodScreen(),
    MyScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 하단 앱바
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: '학식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: '외부식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'MY',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
