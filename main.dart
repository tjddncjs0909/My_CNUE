
import 'package:cnue_food_app/Screen/my_screen.dart';
import 'package:cnue_food_app/Screen/outfood_screen.dart';
import 'package:cnue_food_app/Screen/schoolfood_screen.dart';
import 'package:cnue_food_app/Screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'firebase_options.dart';

const apikey = '비공개';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
      clientId: 'nhzb9jix8b'
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
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
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 40, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    WeatherScreen(),
    school_food_screen(),
    OutFoodScreen(),
    MyScreen(),
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
            label: '제휴 식당',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'MY',
          )
        ],
        selectedItemColor: Colors.amber[800],
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
        unselectedLabelStyle: TextStyle(fontSize: 15),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
