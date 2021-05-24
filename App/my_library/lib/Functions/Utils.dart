import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

import 'dart:convert';
import 'package:flutter/services.dart';


void showToast(String text, BuildContext context) {
  FToast fToast = FToast()..init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.black87,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    ),
  );
  fToast.showToast(
    child: toast,
    gravity: ToastGravity.CENTER,
    toastDuration: Duration(seconds: 2),
  );
}

Future<String> showPicker(List options, BuildContext context) async {
  String result;
  await Picker(
      height: 220,
      itemExtent: 38,
      adapter: PickerDataAdapter<String>(pickerdata: options),
      onConfirm: (Picker picker, List value) {
        result = options[value.first];
      }).showModal(context);
  return result ?? "";
}

Future<String> showPickerDate(BuildContext context) async {
  String result;
  await Picker(
      height: 220,
      itemExtent: 38,
      adapter: DateTimePickerAdapter(),
      onConfirm: (Picker picker, List value) {
        result = formatDate((picker.adapter as DateTimePickerAdapter).value,
            [yyyy, '-', mm, '-', dd]);
        print((picker.adapter as DateTimePickerAdapter).value.toString());
      }).showModal(context);
  return result ?? "";
}

Future<String> showPickerDateOnlyYearAndMonth(BuildContext context) async {
  String result;
  await Picker(
      height: 220,
      itemExtent: 38,
      adapter: DateTimePickerAdapter(),
      onConfirm: (Picker picker, List value) {
        result = formatDate((picker.adapter as DateTimePickerAdapter).value,
            [yyyy, '-', mm]);
        print((picker.adapter as DateTimePickerAdapter).value.toString());
      }).showModal(context);
  return result ?? "";
}

// 生成 md5
String md5_generator(var data) {
  var content = new Utf8Encoder().convert(data);
  var digest = md5.convert(content);
  // 这里其实就是 digest.toString()
  return hex.encode(digest.bytes);
}

// 生成 SHA256
String sha256_generator(var data) {
  var content = new Utf8Encoder().convert(data);
  var digest = sha256.convert(content);
  // 这里其实就是 digest.toString()
  return hex.encode(digest.bytes);
}

// 生成 SHA256
String sha512_generator(var data) {
  var content = new Utf8Encoder().convert(data);
  var digest = sha512.convert(content);
  // 这里其实就是 digest.toString()
  return hex.encode(digest.bytes);
}

// 对密码进行加密
String EncryptPassword(String password) {
  password = password + "\u0066\u0077\u0073\u0062";
  var passwd1 = sha256_generator(password);
  var passwd2 = sha512_generator(passwd1);
  var passwd3 = md5_generator(passwd2);
  return passwd3;
}

// 显示对话框
void showMessageDialog(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text('提示'),
        content: new Text(message),
        actions: <Widget>[
          new FlatButton(
            child: new Text("好"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

dynamic textToJson(String text) {
  return json.decode(text);
}