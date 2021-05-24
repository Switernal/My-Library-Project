import 'dart:async';
import 'package:flutter/material.dart';
import 'Controllers/Home/HomePage.dart';

// Packages
import 'package:url_launcher/url_launcher.dart';

// Functions
import 'package:my_library/Functions/LocalStorage.dart';

TabController _mainTabController;
List mainTabs = ["在柜书籍", "借出书籍"];

// 初始化Shared_Preferences
Future<void> Shared_Preferences_Initialize() async {
  await LocalStorage().initLocalStorage().then((value) => value ? print("Shared_preferences 初始化成功") : print("Shared_Preferences 初始化失败"));
  await LocalStorage().getInitializationString();
}

// TODO: 主程序入口
void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: true,
        home: MyLibrary(),
      )
  );

  // 初始化Shared_Preferences
  Shared_Preferences_Initialize();
}


// class chh extends StatelessWidget {
//
//   void launchWebsite() async {
//     var _url = "https://private.switernal.com";
//     await canLaunch(_url) ? await launch(_url) : throw 'Could not launch url';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     launchWebsite();
//     return Scaffold();
//   }
// }