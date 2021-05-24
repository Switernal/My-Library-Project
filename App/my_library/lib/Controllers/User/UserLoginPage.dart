import 'package:flutter/material.dart';
import 'package:my_library/Controllers/User/UserSignUpPage.dart';

import 'package:my_library/Functions/Utils.dart';
import 'package:my_library/Functions/Network/UserRequest.dart';
import 'package:my_library/Models/UserModel.dart';

bool _isChecked = false;
var _checkIcon = Icons.check_box_outline_blank;

dynamic refresh_drawer;

class UserLoginPage extends StatefulWidget {

  UserLoginPage({dynamic refresher}) {
    refresh_drawer = refresher;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserLoginPageState();
  }
}

class UserLoginPageState extends State<UserLoginPage> {

  final _formKey = new GlobalKey<FormState>();

  String _phone;
  String _password;
  bool _isChecked = true;
  bool _isLoading;
  IconData _checkIcon = Icons.check_box;

  void _changeFormToLogin() {
    _formKey.currentState.reset();
  }

  void _onLogin() {
    final form = _formKey.currentState;
    form.save();

    if (_phone == '') {
      _showMessageDialog('账号不可为空');
      return;
    } else if (!RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$').hasMatch(_phone)) {
      _showMessageDialog("请输入正确的手机号!");
      return;
    }
    
    if (_password == '') {
      _showMessageDialog('密码不可为空');
      return;
    }


    // 先对密码加密
    _password = EncryptPassword(_password);
    User.userLogin(_phone, _password).then((value) {
      switch (value) {
        case -1:
          _showMessageDialog("用户不存在");
          return;
          break;
        case 0:
          _showMessageDialog("登录失败, 密码错误");
          return;
          break;
        case 1:
          refresh_drawer();
          Navigator.of(context).pop();
          break;
        default:
          _showMessageDialog("其他错误");
      }
    });

  }


  // 显示对话框
  void _showMessageDialog(String message) {
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


  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.phone,
        autofocus: false,
        style: TextStyle(fontSize: 15),
        decoration: new InputDecoration(
            border: InputBorder.none,
            hintText: '请输入手机号',
            icon: new Icon(
              Icons.phone_android,
              color: Colors.grey,
            )),
        onSaved: (value) => _phone = value.trim(),
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 7.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        style: TextStyle(fontSize: 15),
        decoration: new InputDecoration(
            border: InputBorder.none,
            hintText: '请输入密码',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("登录",textAlign: TextAlign.center,)),
        body: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 30),
              height: 180,
              child:
                //Image(image: AssetImage('assets/images/login_cartoon.png')
                Center(child:Text("一千零一夜", style: TextStyle(fontSize: 30),))
            ),
            Form(
              key: _formKey,
              child: Container(
                height: 122,
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      _showEmailInput(),
                      Divider(
                        height: 0.5,
                        indent: 16.0,
                        color: Colors.grey[300],
                      ),
                      _showPasswordInput(),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 70,
              padding: const EdgeInsets.fromLTRB(35, 30, 35, 0),
              child: OutlineButton(
                child: Text('登录'),
                textColor: Colors.orange,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                borderSide: BorderSide(color: Colors.orange, width: 1),
                onPressed: () {
                  _onLogin();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              child: FlatButton(
                child: Text("新用户注册"),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UserSignUpPage() ));
                },
              )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                ],
              ),
            )
          ],
        ));
  }
}

