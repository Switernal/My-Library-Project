// System
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_library/Controllers/Home/AddBookPage.dart';

// Pages
import 'SearchMyBookPage.dart'; // 搜索页
import 'package:my_library/Controllers/Home/BookShelfPage.dart'; // 书架
import 'package:my_library/Controllers/Drawer/DrawerPage.dart';  // 抽屉
//import 'package:my_library/Pages/AddBookPage.dart'; // 添加书籍

// Packages
import 'package:flutter_search_bar/flutter_search_bar.dart';
//import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:my_library/Controllers/Shop/ShopPage.dart';
import 'package:permission_handler/permission_handler.dart';

// Functions
import 'package:my_library/Functions/LocalStorage.dart';
import 'package:my_library/Functions/Widgets/Anim_Search_Widget.dart';


// 读到的ISBN码
String ISBN = "";

// 录入图书方式
enum AddBookWays {
  Scanner,
  Human
}

// Tabbar 控制器
TabController _mainTabController;
List mainTabsLabel = ["书房", "客厅书柜", "纸箱", "地下室", "书柜"];
List tabPages = [];

class MyLibrary extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyLibraryState();
  }
}

class MyLibraryState extends State<MyLibrary> {

  //当前显示页面的
  int currentIndex = 0;
  //点击导航项是要显示的页面
  final bottomPages = [MyLibraryHomePage(), ShopPage()];



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: bottomPages[currentIndex],

      // TODO: 左侧抽屉
      drawer: MainDrawer(), // 创建一个新的抽屉对象

      // TODO: 底部导航栏(不规则)
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: <Widget>[
            buildBotomItem(currentIndex, 0, Icons.menu_book, "我的藏书"),
            buildBotomItem(currentIndex, 1, Icons.store_mall_directory, "二手书店"),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),

      ),

      // TODO: 中间浮动按钮
      // 如果当前页面为1, 为二手书店, 则按钮动作为新增页面
      // 如果当前页面为0, 为个人藏书状态, 按钮动作为新增藏书
      floatingActionButton:
        currentIndex == 1
        ?
        FloatingActionButton(
            child: Icon(Icons.add),
            tooltip: "新增藏书",
            onPressed: () {
              print("发布新书");
            }
        )
        :
        FloatingActionButton(
        child: PopupMenuButton<AddBookWays>(
          onSelected: (AddBookWays result) {
            setState(() {
              print(result);
              if (result == AddBookWays.Scanner) {
                // 扫描条码
                scanBarcodeNormal();
              }
              if (result == AddBookWays.Human) {
                // 手动录入
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return AddBookPage();
                } ));
              }
            });
          },

          icon: Icon(Icons.add),
          tooltip: "新增藏书",
          itemBuilder: (BuildContext context) => <PopupMenuEntry<AddBookWays>>[
            const PopupMenuItem<AddBookWays>(
              value: AddBookWays.Scanner,
              child: Text("扫描条码"),
            ),
            const PopupMenuItem<AddBookWays>(
              value: AddBookWays.Human,
              child: Text('手动录入'),
            ),

          ],
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  print(context);
                  return AddBookPage();
                },
              )
          );
        },
        tooltip: '新增藏书',
        //child: Icon(Icons.add),
      ),

      // TODO: 浮动按钮位置
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // TODO: 扫描条码
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // 返回给ISBN字符串
    setState(() {
      ISBN = barcodeScanRes;
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddBookPage(ISBN: ISBN,)));
    });
  }


  // TODO: 构建新的底部导航按钮
  /**
   * @param selectIndex 当前选中的页面
   * @param index 每个条目对应的角标
   * @param iconData 每个条目对就的图标
   * @param title 每个条目对应的标题
   */

  buildBotomItem(int selectIndex, int index, IconData iconData, String title) {
    //未选中状态的样式
    TextStyle textStyle = TextStyle(fontSize: 12.0,color: Colors.grey);
    MaterialColor iconColor = Colors.grey;
    double iconSize=20;
    EdgeInsetsGeometry padding =  EdgeInsets.only(top: 8.0);

    if(selectIndex==index){
      //选中状态的文字样式
      textStyle = TextStyle(fontSize: 13.0,color: Colors.blue);
      //选中状态的按钮样式
      iconColor = Colors.blue;
      iconSize=25;
      padding =  EdgeInsets.only(top: 6.0);
    }
    Widget padItem = SizedBox();
    if (iconData != null) {
      padItem = Padding(
        padding: padding,
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: <Widget>[
                Icon(
                  iconData,
                  color: iconColor,
                  size: iconSize,
                ),
                Text(
                  title,
                  style: textStyle,
                )
              ],
            ),
          ),
        ),
      );
    }
    Widget item = Expanded(
      flex: 1,
      child: new GestureDetector(
        onTap: () {
          if (index != currentIndex) {
            setState(() {
              currentIndex = index;
            });
          }
        },
        child: SizedBox(
          height: 52,
          child: padItem,
        ),
      ),
    );
    return item;
  }
}

// TODO: MyLibrary App
class MyLibraryHomePage extends StatefulWidget {
  // 构造State
  @override
  State<StatefulWidget> createState() {
    return MyLibraryHomePageState();
  }
}

// TODO: MyLibrary App State状态
class MyLibraryHomePageState extends State<MyLibraryHomePage> with SingleTickerProviderStateMixin {


  // 搜索组件
  SearchBar searchBar;
  // TexEditing控制器
  TextEditingController searchTextController = TextEditingController();

  @override
  // TODO: State 初始化
  void initState() {
    super.initState();
    // 初始化TabBar控制器
    _mainTabController = TabController(length: mainTabsLabel.length, vsync: this);
  }

  @override 
  void dispose() {
    searchTextController = null;
    super.dispose();
  }

  // TODO: 构建build方法
  @override
  Widget build(BuildContext context) {

    // return MaterialApp(
    //   debugShowCheckedModeBanner: true,
    //   home:
    // );

    return Scaffold(
      // TODO: 顶部bar
      appBar: AppBar(
        // 顶部title
        title: Text("我的藏书",textAlign: TextAlign.center,),
        centerTitle: true,
        // 打开抽屉按钮
        leading: IconButton(
          icon: Icon(Icons.dehaze),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        // 顶部导航栏
        bottom: TabBar(
          // 允许滑动
          isScrollable: true,
          // tabbar 控制器
          controller: _mainTabController,
          // 页面
          tabs: mainTabsLabel.map((e) => Tab(text: e,)).toList(),
        ),
        actions: [
          // 搜索按钮
          AnimSearchBar(
            width: 300,
            textController: searchTextController,
            prefixIcon: Icon(Icons.search, color: Colors.black,),
            suffixIcon: Icon(Icons.close, color: Colors.black),
            closeSearchOnSuffixTap: true,
            helpText: "查找我的藏书...",
            autoFocus: false,
            animationDurationInMilli: 250,
            searchAction: (value) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchMyBookPage(value))),
            onSuffixTap: () {
              setState(() {
                searchTextController.clear();
              });
            },

          ),
          // 填充右侧空白
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(''),
          )
        ],
      ),
      //searchBar.build(context),


      // TODO: 页面主体
      body: TabBarView(
          controller: _mainTabController, // 指定控制器
          children: //mainTabsLabel.map((e) => Tab(text: e,)).toList(), // 页面组件
          [BookShelfPage(), BookShelfPage(), BookShelfPage(), BookShelfPage(), BookShelfPage()]
      ),

    );
  }
}


