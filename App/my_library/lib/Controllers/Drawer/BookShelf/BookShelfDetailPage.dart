import 'package:flutter/material.dart';

class BookShelfDetailPage extends StatefulWidget {
  String shelfName;
  BookShelfDetailPage({this.shelfName});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return BookShelfDetailPageState(this.shelfName);
  }
}

class BookShelfDetailPageState extends State<BookShelfDetailPage> {
  String shelfName;
  BookShelfDetailPageState(this.shelfName);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(this.shelfName),),
    );
  }
}