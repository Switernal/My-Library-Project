import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tform/tform.dart';

import 'package:my_library/Functions/Widgets/verifitionc_code_button.dart';
import 'package:my_library/Functions/Utils.dart';

import 'package:my_library/Functions/Network/UserRequest.dart';
import 'dart:convert';


bool isPhoneNumberValid = false;
bool _isChecked = true;
var _checkIcon = Icons.check_box_outline_blank;
String firstPasswd = null;

// 表单中的值
List values = [];
// 表单中的错误信息
List errors = [];
// 用户信息
Map<String, String> newUserInfo = {"username" : null, "email" : null, "phone" : null, "password" : null};

class UserSignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserSignUpPageState();
  }
}

class UserSignUpPageState extends State<UserSignUpPage> {
  @override
  void initState() {
    // TODO: implement initState
    print(_formKey.currentState);
    super.initState();
  }

  // 表单通过GlobalKey获取,遍历表单组件获取值得内容
  final GlobalKey _formKey = GlobalKey<TFormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text("注册用户")
      ),
      body: TForm.builder(
        key: _formKey,
        rows: buildFormRows(),
        divider: Divider(
          height: 1,
        ),
      ),

      // 提交表单,遍历组件获取值
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          values.clear();

          var state = _formKey.currentState as TFormState;
          for (var row in state.rows) {
            values.add(row.value);
          }
          // 移除最后一项(自定义cell)
          values.removeLast();

          print(values);

          // 检查错误
          errors = state.validate();

          if (errors.isNotEmpty) {
            showToast(errors.first, context);
            return null;
          } else {
            if (values[3] != "3972") {
              showToast("验证码不正确", context);
              return null;
            }
            if (values[4] != values[5]) {
              showToast("两次输入密码不一致", context);
              return null;
            }
            if (values[1] != "" && !RegExp(r'^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$').hasMatch(values[1])) {
              showToast("请输入正确的邮箱", context);
              return null;
            }
          }

          // 设置map
          newUserInfo["username"] = values[0];
          newUserInfo["email"] = values[1];
          newUserInfo["phone"] = values[2];
          newUserInfo["password"] = EncryptPassword(values[4]); // 密码进行3重加密

          print(newUserInfo);

          UserRequest().Register(newUserInfo);
        }, // onPressed
      ),
    );
  }

  List<TFormRow> buildFormRows() {
    return [

      TFormRow.input(
        requireStar: true,
        title: "用户名",
        placeholder: "请输入用户名",
        value: "",
        clearButtonMode: OverlayVisibilityMode.editing,
        //onChanged: (row) => print(row.value),
        validator: (row) => row.value != "",
      ),

      TFormRow.input(
        requireStar: true,
        require: true,
        title: "邮箱",
        placeholder: "请输入邮箱",
        value: "",
        clearButtonMode: OverlayVisibilityMode.editing,
        //onChanged: (row) => print(row.value),
      ),

      TFormRow.input(
        keyboardType: TextInputType.number,
        title: "手机号",
        placeholder: "请输入手机号",
        maxLength: 11,
        requireMsg: "请输入正确的手机号",
        requireStar: true,
        clearButtonMode: OverlayVisibilityMode.editing,
        //textAlign: TextAlign.right,
        validator: (row) {
          return RegExp(
              r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$')
              .hasMatch(row.value);
        },
        onChanged: (row) {
          isPhoneNumberValid = RegExp(
                r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$')
                .hasMatch(row.value);
        },
        tag: "手机号",
      ),

      TFormRow.input(
        title: "验证码",
        placeholder: "请输入验证码",
        requireStar: true,
        clearButtonMode: OverlayVisibilityMode.editing,
        validator: (row) => row.value != "",
        suffixWidget: (context, row) {
          var button = VerifitionCodeButton(
            title: "获取验证码",
            seconds: 60,
            onPressed: () {
              if (isPhoneNumberValid) {
                showToast("验证码已发送", context);
              } else {
                showToast("手机号不正确", context);
              }
            },
          );
          button.isPhoneNumberValid = isPhoneNumberValid;
          return button;
        },
      ),

      TFormRow.input(
        requireStar: true,
        title: "密码",
        value: "",
        obscureText: true,
        state: false,
        placeholder: "请输入密码",
        clearButtonMode: OverlayVisibilityMode.editing,
        validator: (row) => row.value != "",
        suffixWidget: (context, row) {
          return GestureDetector(
            onTap: () {
              row.state = !row.state;
              row.obscureText = !row.obscureText;
              TForm.of(context).reload();
            },
            child: Icon(
              row.state ? Icons.visibility_off : Icons.visibility,
              size: 20,
            ),

          );
        },
        onChanged: (row) => firstPasswd = row.value,
      ),

      TFormRow.input(
        requireStar: true,
        title: "再次输入密码",
        value: "",
        obscureText: true,
        state: false,
        placeholder: "请再次输入密码",
        clearButtonMode: OverlayVisibilityMode.editing,
        validator: (row) => row.value != "",
        suffixWidget: (context, row) {
          return GestureDetector(
            onTap: () {
              row.state = !row.state;
              row.obscureText = !row.obscureText;
              TForm.of(context).reload();
            },
            child: Icon(
              row.state ? Icons.visibility_off : Icons.visibility,
              size: 20,
            ),

          );
        },
      ),

      TFormRow.customCell(
        widget: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(_checkIcon),
                  color: Colors.orange,
                  onPressed: () {
                    setState(() {
                      _isChecked = !_isChecked;
                      if (_isChecked) {
                        _checkIcon = Icons.check_box;
                      } else {
                        _checkIcon = Icons.check_box_outline_blank;
                      }
                    });
                  }),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('我已详细阅读并同意',style: TextStyle(color: Colors.black, fontSize: 13)),
                  TextButton(onPressed: null, child: Text("《隐私政策》", style: TextStyle(color: Colors.blue, fontSize: 13))),
                  Text('和',style: TextStyle(color: Colors.black, fontSize: 13)),
                  TextButton(onPressed: null, child: Text("《用户协议》", style: TextStyle(color: Colors.blue, fontSize: 13))),
                ],
              ),
            ],
          ),
        )
      ),
      /*
      TFormRow.customSelector(
        title: "婚姻状况",
        placeholder: "请选择",
        state: [
          ["未婚", "已婚"],
          [
            TFormRow.input(
                title: "配偶姓名", placeholder: "请输入配偶姓名", requireStar: true),
            TFormRow.input(
                title: "配偶电话", placeholder: "请输入配偶电话", requireStar: true)
          ]
        ],
        onTap: (context, row) async {
          String value = await showPicker(row.state[0], context);
          if (row.value != value) {
            if (value == "已婚") {
              TForm.of(context).insert(row, row.state[1]);
            } else {
              TForm.of(context).delete(row.state[1]);
            }
          }
          return value;
        },
      ),
      TFormRow.selector(
        title: "学历",
        placeholder: "请选择",
        options: [
          TFormOptionModel(value: "专科"),
          TFormOptionModel(value: "本科"),
          TFormOptionModel(value: "硕士"),
          TFormOptionModel(value: "博士")
        ],
        //value: "专科"
      ),
      TFormRow.multipleSelector(
        title: "家庭成员",
        placeholder: "请选择",
        options: [
          TFormOptionModel(value: "父亲", selected: false),
          TFormOptionModel(value: "母亲", selected: false),
          TFormOptionModel(value: "儿子", selected: false),
          TFormOptionModel(value: "女儿", selected: false)
        ],

      ),
      TFormRow.customSelector(
        title: "出生年月",
        placeholder: "请选择",
        onTap: (context, row) async {
          return showPickerDate(context);
        },
        fieldConfig: TFormFieldConfig(
          selectorIcon: SizedBox.shrink(),
        ),
      ),
      TFormRow.customCell(
        widget: Container(
            color: Colors.grey[200],
            height: 48,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text("------ 我是自定义的Cell ------")),
      ),

      Expanded(
                    child: RichText(
                        text: TextSpan(text: '我已经详细阅读并同意',
                            style: TextStyle(color: Colors.black, fontSize: 13),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '《隐私政策》', style: TextStyle(color: Colors
                                  .blue, decoration: TextDecoration.underline)),
                              TextSpan(text: '和'),
                              TextSpan(
                                  text: '《用户协议》', style: TextStyle(color: Colors
                                  .blue, decoration: TextDecoration.underline))
                            ])),
                  )
      */


    ];
  }
}