import 'package:flutter/material.dart';

// Pages
import 'package:my_library/Controllers/User/UserLoginPage.dart';
import 'package:my_library/Controllers/Drawer/BookShelf/BookShelfManagePageNew.dart';
import 'package:my_library/Controllers/Drawer/BookStatisticsPage.dart';
import 'package:my_library/Controllers/Drawer/MyOrdersPage.dart';
import 'package:my_library/Controllers/User/UserHomePage.dart';

// Package
import 'package:my_library/Functions/LocalStorage.dart';
import 'package:url_launcher/url_launcher.dart';

// Functions
import 'package:my_library/Models/UserModel.dart';

bool isLogin = false;
String userName = "点击此处登录";
String userDescription = "登录后使用更多功能";

// 主界面Drawer
class MainDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainDrawerState();
  }
}

class MainDrawerState extends State<MainDrawer> {

  void launchWebsite() async {
    var _url = "https://mylibrary.switernal.com";
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch url';
  }

  void refreshLoginStatus() {
    setState(() {
      LocalStorage().isLogin().then((value) {

        isLogin = value;
        if (value == true) {
          LocalStorage().getUserName().then((value) => userName = value);
          LocalStorage().getUserEmail().then((value) => userDescription = value);
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Drawer initState!");
    // 刷新用户动态
    refreshLoginStatus();
  }

  @override
  Widget build(BuildContext context) {

    print("Drawer Build!");

    return Drawer(
      // 脚手架
      child: Scaffold(
        // 顶部栏
        appBar: AppBar(
          elevation: 0,// 隐藏阴影
          automaticallyImplyLeading: false, // 隐藏左侧按钮
        ),
        //bottomNavigationBar: ,
        body: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text(userDescription),
              accountName: Text(userName),
              currentAccountPicture: CircleAvatar(
                //backgroundImage: AssetImage('assets/images/txr.jpg'),
                child: Icon(Icons.person, size: 40,),
              ),
              arrowColor: Colors.transparent, // 右侧三角设为透明色
              // 点击用户名事件
              onDetailsPressed: () {

                User.getUserLoginStatus().then((value) {
                  if (value == true) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserHomePage()));
                  } else {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserLoginPage(refresher: refreshLoginStatus,)));
                  }
                });

              },
            ),
            ListTile(
              title: Text('书架管理'),
              //subtitle: Text('管理你的书架',maxLines: 2,overflow: TextOverflow.ellipsis,),
              leading: Icon(Icons.amp_stories, color: Colors.blue, size: 30,),// CircleAvatar(child: Text("1")),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => BookShelfManagePage()));},
            ),
            Divider(),//分割线
            ListTile(
              title: Text('书籍统计'),
              //subtitle: Text('ListSubtitle2',maxLines: 2,overflow: TextOverflow.ellipsis,),
              leading: Icon(Icons.bar_chart, color: Colors.blue, size: 30,),// CircleAvatar(child: Text("2")),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => BookStatisticPage()));},
            ),
            Divider(),//分割线
            ListTile(
              title: Text('我的订单'),
              //subtitle: Text('ListSubtitle3',maxLines: 2,overflow: TextOverflow.ellipsis,),
              leading: Icon(Icons.assignment_outlined, color: Colors.blue, size: 30,),// CircleAvatar(child: Text("3")),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrdersPage()));},
            ),
            Divider(),//分割线
            new AboutListTile(
              icon: Icon(Icons.info_outline, color: Colors.blue, size: 30,), //new CircleAvatar(child: Text("4")),
              child: new Text("关于"),
              applicationName: "一千零一夜",
              applicationVersion: "Java课程设计",
              applicationIcon: Icon(Icons.menu_book_outlined, size: 55.0, color: Colors.blue,),//new Image.asset(
              //   'assets/images/txr.jpg',
              //   width: 55.0,
              //   height: 55.0,
              // ),
              //applicationLegalese: "个人图书管理&二手书交易",
              aboutBoxChildren: <Widget>[

                ListTile(
                  title: Text('开发者'),
                  subtitle: Text('李清昀 201983290048\n朱梓源 201983290041',maxLines: 2,overflow: TextOverflow.ellipsis,),
                  leading: Icon(Icons.person, color: Colors.blue, size: 30,),// CircleAvatar(child: Text("1")),
                  onTap: (){showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text('开发者信息'),
                        content: new Text("南京信息工程大学\n计算机与软件学院\n\n19计科1班 李清昀 201983290048\n19计科2班 朱梓源 201983290041"),
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
                  );;},
                ),


                ListTile(
                  title: Text('版本'),
                  subtitle: Text('Alpha 0.2',maxLines: 2,overflow: TextOverflow.ellipsis,),
                  leading: Icon(Icons.assessment_outlined, color: Colors.green, size: 30,),// CircleAvatar(child: Text("1")),
                  onTap: (){ //Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          title: new Text('当前版本'),
                          content: new Text("Alpha 0.2"),
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
                  },
                ),



                ListTile(
                  title: Text('更新日期'),
                  subtitle: Text('2021.05.21',maxLines: 2,overflow: TextOverflow.ellipsis,),
                  leading: Icon(Icons.date_range, color: Colors.orange, size: 30,),// CircleAvatar(child: Text("1")),
                  onTap: (){showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text('更新记录'),
                        content: RichText(
                            text: TextSpan(text: '项目创建日期 : 2021.04.09\n', style: TextStyle(color: Colors.black, fontSize: 13),
                                children: <TextSpan>[
                                  TextSpan(text: 'Alpha 0.1 ', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                                  TextSpan(text: ": 2021.04.23\n"),
                                  TextSpan(text: 'Alpha 0.2 ', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                                  TextSpan(text: ": 2021.05.21\n"),
                                ]
                            )
                        ),

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
                  );},
                ),

                ListTile(
                  title: Text('功能'),
                  subtitle: Text('个人图书管理与二手书交易',maxLines: 2,overflow: TextOverflow.ellipsis,),
                  leading: Icon(Icons.assistant_photo_sharp, color: Colors.purple, size: 30,),// CircleAvatar(child: Text("1")),
                  onTap: (){ showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text('App 功能'),
                        content: new Text("个人图书管理和二手书交易平台, 轻松管理您的私人书藏"),
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
                  );},
                ),

                ListTile(
                  title: Text('版本更新'),
                  subtitle: Text('当前已是最新版本',maxLines: 2,overflow: TextOverflow.ellipsis,),
                  leading: Icon(Icons.cloud_upload, color: Colors.deepOrange, size: 30,),// CircleAvatar(child: Text("1")),
                  onTap: (){showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text('已是最新版本!'),
                        content: new Text("当前版本: Alpha 0.2"),
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
                  );},
                ),

                ListTile(
                  title: Text('官方网站'),
                  subtitle: Text('mylibrary.switernal.com',maxLines: 2,overflow: TextOverflow.ellipsis,),
                  leading: Icon(Icons.open_in_browser, color: Colors.black54, size: 30,),// CircleAvatar(child: Text("1")),
                  onTap: (){
                    launchWebsite();
                  },
                ),
                // new Text("开发者: 李清昀 朱梓源\n"),
                // new Text("开发日期: 2020.04.23")
              ],
            ),
            Divider(),//分割线
          ],
        ),
      ),
    );
  }
}

/*
     ListTile(
              title: Text('ListTile1'),
              subtitle: Text('ListSubtitle1',maxLines: 2,overflow: TextOverflow.ellipsis,),
              leading: CircleAvatar(child: Text("1")),
              onTap: (){Navigator.pop(context);},
            ),
* */