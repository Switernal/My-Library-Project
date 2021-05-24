import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:flutter/foundation.dart';
import 'package:my_library/Functions/Utils.dart';
import 'package:my_library/Functions/LocalStorage.dart';
import 'package:my_library/Functions/Network/UserRequest.dart';

class User {
  String userName;
  String password;
  String email;
  String phone;

  User({this.userName, this.email, this.phone, this.password = ""});

  // 判断系统中用户登录状态
  static Future<bool> getUserLoginStatus() {
    return LocalStorage().isLogin();
  }

  // 设置系统用户登录
  static Future<bool> setUserLogin(User user) async {
    return await LocalStorage().userLogin(userName: user.userName, userEmail: user.email, userPhone: user.phone, userPasswd: user.password);
  }

  // 获取系统中用户信息
  static Future<User> getUserInfo() async {
    var username;
    var email;
    var phone;
    var password;

    await LocalStorage().getUserName().then((value) => username = value);
    await LocalStorage().getUserEmail().then((value) => email = value);
    await LocalStorage().getUserPhone().then((value) => phone = value);

    User systemUser = User(userName: username, email: email, phone: phone);

    return systemUser;
  }

  // 判断用户密码是否正确
  static Future<bool> isUserPasswordCorrect() {

  }

  // user转换成json
  String toJson(User user) {

  }

  // 用户登录方法
  static Future<int> userLogin(String phone, String password) async {
    var result = -1;
    await UserRequest().Login(phone, password).then((value) {
      result = value["status"];
      if (result == 1) {
        setUserLogin(jsonToUser(value));
      }
    });

    return result;
  }

  // json转User
  static User jsonToUser(dynamic jsonText) {
    var username = jsonText["username"];
    var password = jsonText["password"];
    var email = jsonText["email"];
    var phone = jsonText["phone"];

    return User(userName: username, password: password, email: email, phone: phone);
  }
}