import 'package:flutter/material.dart';
import 'package:marat_return/pages/Home.dart';
import 'package:marat_return/pages/main_screen.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
      initialRoute: '/',
      routes:{
        '/':(context) => MainScreen(),
        '/todo':(context) => Home(),
      },
    ));
