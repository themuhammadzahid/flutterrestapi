import 'package:flutter/material.dart';
import 'package:projects/get/home_screen.dart';

import 'get/UserList.dart';
import 'get/get_photos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserList(),
    );
  }
}
