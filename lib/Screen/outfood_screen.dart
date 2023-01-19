// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class OutFoodScreen extends StatefulWidget {
  const OutFoodScreen({Key? key}) : super(key: key);

  @override
  State<OutFoodScreen> createState() => _OutFoodScreenState();
}

class _OutFoodScreenState extends State<OutFoodScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Developing~',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}
