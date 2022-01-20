// @dart=2.9

import 'package:agenda_digital/pages/home.page.dart';
import 'package:agenda_digital/pages/login.page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Presença',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {'/': (context) => LoginPage(), '/home': (context) => HomePage()},
    );
  }
}
