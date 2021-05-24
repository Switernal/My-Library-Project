import 'package:flutter/material.dart';
import 'package:my_library/Views/BookShelf/BookCard.dart';
import 'package:suggestion_search_bar/suggestion_search_bar.dart';


// TODO: 书架Page
class BookShelfPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookShelfState();
  }
}


// TODO: 书架State
class BookShelfState extends State<BookShelfPage> {
  // TODO: 初始化State
  @override
  void initState() {
    super.initState();
  }


  // TODO: build构造方法
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 10,
      //physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 0,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        return BookCard(data: BookCardViewModel(
            title: "云雀叫了一整天",
            playsCount: 100,
            coverImgUrl: 'https://img3.doubanio.com/view/subject/l/public/s25948080.jpg',
            needVip: false
        ));
      },);

  }
}