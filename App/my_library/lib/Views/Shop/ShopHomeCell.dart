import 'package:flutter/material.dart';
import 'package:my_library/Controllers/Shop/ShopBookDetailPage.dart';

class ShopHomeCellData {

}

// 商店首页Cell
class ShopHomeCell extends StatelessWidget {

  Widget CoverArea() {

    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
        child:
        //Image.network("https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg13.360buyimg.com%2FpopWaterMark%2Fjfs%2Ft505%2F112%2F896234250%2F483302%2Ff7f2d82d%2F5498e4caNcb1cbe47.jpg&refer=http%3A%2F%2Fimg13.360buyimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1624344552&t=8bb260f722a0ca7d5abd6a1f924c38d0"),
        Image.network("https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2645805879,3182406483&fm=224&gp=0.jpg", fit: BoxFit.cover,),
        //Image.asset('assets/images/txr.jpg', fit: BoxFit.fitWidth,),
      ),
    );

    return Container(
      //height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4))
      ),
      //margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Image.asset('assets/images/txr.jpg', fit: BoxFit.fitWidth),
    );
  }

  // 内容部分
  Widget PublishContentArea() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Text("Python基础教程", maxLines: 2,),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "￥", style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500)),
                    TextSpan(text: "23", style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.w700)),
                    TextSpan(text: ".33", style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              child: Text(" 全新 ", style: TextStyle(fontSize: 9, color: Colors.red),),
            ),
          )
        ],
      ),
    );
  }

  // 用户信息部分
  Widget UserInfoArea() {
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
            //padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
            child: CircleAvatar(
              radius: 8,
              //backgroundImage: AssetImage('assets/images/txr.jpg'),
              child: Icon(Icons.person, size: 10,),
            ),
          ),

          Padding(
            padding: EdgeInsets.zero,
            child: Text("测试用户", style: TextStyle(fontSize: 12, color: Colors.black54),),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: impleement build
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShopBookDetailPage()));
      },
      child: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4)),
          // border: Border.all(width: 1)
          // gradient: LinearGradient(colors: [Colors.white, Colors.black12]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CoverArea(),
            PublishContentArea(),
            UserInfoArea(),
          ],
        ),
      ),
    );
  }
}