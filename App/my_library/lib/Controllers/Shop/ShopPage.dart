import 'package:flutter/material.dart';

import 'package:my_library/Functions/Widgets/Anim_Search_Widget.dart';

// Controllers
import 'package:my_library/Controllers/Home/SearchMyBookPage.dart';

// Views
import 'package:my_library/Views/Shop/ShopHomeCell.dart';

// Packages
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


// 文本输入控制器
TextEditingController searchTextController = TextEditingController();

class ShopPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShopPageState();
  }
}

class ShopPageState extends State<ShopPage> {

  // 滚动监视器
  ScrollController _scrollController = new ScrollController();

  Future<void> refreshData() async {

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:
        AppBar(
          title: Text("二手书店"),
          centerTitle: true,
          // 打开抽屉按钮
          leading: IconButton(
            icon: Icon(Icons.dehaze),
            onPressed: () => Scaffold.of(context).openDrawer(),

          ),
          actions: [
            // 搜索按钮
            AnimSearchBar(
              width: 300,
              textController: searchTextController,
              prefixIcon: Icon(Icons.search, color: Colors.black,),
              suffixIcon: Icon(Icons.close, color: Colors.black),
              closeSearchOnSuffixTap: true,
              helpText: "查找二手书...",
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

        // body: StaggeredGridView.countBuilder(
        //   crossAxisCount: 4,
        //   itemCount: 8,
        //   itemBuilder: (BuildContext context, int index) => new Container(
        //       color: Colors.green,
        //       child: new Center(
        //         child: new CircleAvatar(
        //           backgroundColor: Colors.white,
        //           child: new Text('$index'),
        //         ),
        //       )),
        //   staggeredTileBuilder: (int index) =>
        //   new StaggeredTile.count(2, 2),
        //   mainAxisSpacing: 4.0,
        //   crossAxisSpacing: 4.0,
        // ),

        body: Container(
          color: Colors.white10,
          child: RefreshIndicator(
            onRefresh: refreshData,
            child: StaggeredGridView.countBuilder(
              //controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              shrinkWrap: true,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              crossAxisCount: 4,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ShopHomeCell();
              },
              staggeredTileBuilder: (index) => StaggeredTile.fit(2),

            ),
          ),
        ),

        // body: GridView.builder(
        //   shrinkWrap: true,
        //   itemCount: 9,
        //   //physics: NeverScrollableScrollPhysics(),
        //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     mainAxisSpacing: 5,
        //     crossAxisSpacing: 5,
        //     childAspectRatio: 0.7,
        //   ),
        //   itemBuilder: (context, index) {
        //     return ShopHomeCell();
        //   },
        // ),

    );
  }
}