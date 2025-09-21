import 'package:flutter/material.dart';
import 'Pages/HomePage.dart';
import 'constObjects.dart';
import 'package:get/get.dart';


Colorss color = Colorss();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hasat Defteri',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

