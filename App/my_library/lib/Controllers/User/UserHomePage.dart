import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserHomePageState();
  }
}

class UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("个人空间"),),
      body: Text('欢迎回来'),
    );
  }
}