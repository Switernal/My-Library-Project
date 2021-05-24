import 'package:flutter/material.dart';
import 'package:my_library/Functions/Widgets/Anim_Search_Widget.dart';

// 文本输入控制器
TextEditingController searchTextController = TextEditingController();
// 查询文本
String searchText = "";

class SearchMyBookPage extends StatefulWidget  {
  SearchMyBookPage(String value) {
    searchText = value;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchMyBookPageState();
  }
}

class SearchMyBookPageState extends State<SearchMyBookPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    // searchTextController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    searchTextController.text = searchText;
    searchTextController.addListener(() {
      searchText = searchTextController.text;
    });

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("搜索结果"),
        actions: [
          // 搜索按钮
          AnimSearchBar(
            width: 320,
            textController: searchTextController,
            prefixIcon: Icon(Icons.search, color: Colors.black,),
            suffixIcon: Icon(Icons.close, color: Colors.black),
            closeSearchOnSuffixTap: true,
            helpText: "查找书籍...",
            autoFocus: false,
            animationDurationInMilli: 250,
            this_toggle: 1,
            searchAction: (value) {
              print(value);
            },
            onSuffixTap: () {
              setState(() {
                //searchTextController.clear();
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
    );
  }
}