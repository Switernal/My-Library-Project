import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_library/Controllers/Drawer/BookShelf/BookShelfDetailPage.dart';
import 'package:my_library/Controllers/Drawer/BookShelf/BookShelfEditPage.dart';

// 书架管理界面的一个Cell
class BookShelfManageCell extends StatelessWidget {

  BookShelfData shelfData;

  dynamic deleteAction;

  dynamic editAction;

  BookShelfManageCell({Key key, this.shelfData, this.deleteAction, this.editAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // 点击控件
    return GestureDetector(
      // 单击事件
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context)
           => BookShelfDetailPage(shelfName: this.shelfData.shelfName))),
      // Slidable做顶层控件,可以滑出菜单
      child: Slidable(
        // 使用Drawer滑动菜单风格
        actionPane: SlidableDrawerActionPane(),
        // 如果设置dismissal,必须设置key
        key: UniqueKey(),
        // 滑动删除动画
        dismissal: SlidableDismissal(
            child: SlidableDrawerDismissal(),
            onWillDismiss: (actionType) {
              if (actionType == SlideActionType.secondary) {
                deleteAction();
              } else {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                    BookShelfEditPage(
                      shelfName: this.shelfData.shelfName,
                      mode: Mode.EditShelf,
                      refreshBookShelf: editAction,
                    )
                  )
                );
              }
            },
        ),

        actionExtentRatio: 0.25,

        // 包裹了一个Container,卡片控件
        child: Container(
          // 只设定height, width自动适应
            height: 80,
            // 外边距
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            // 内边距
            padding: EdgeInsets.only(left: 20, right: 15, top: 20, bottom: 20),
            // 装饰
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.lightBlue, Colors.blue],
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  spreadRadius: 4,
                  color: Color.fromARGB(20, 0, 0, 0),
                ),
              ],
            ),
            // 并排组件
            child: Row(
              // 垂直方向在中心
              crossAxisAlignment: CrossAxisAlignment.center,
              // 两端对其
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // 宽度自适应
                Expanded(child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      this.shelfData.shelfName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "数量: " + this.shelfData.numbersOfBooks.toString() + " 本",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(200, 255, 255, 255),
                      ),
                    ),
                  ],
                ),),
                // 右侧箭头图标
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 0),
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                )

              ],

            )
        ),
        actions: [  //滑动后的菜单
          // 编辑按钮
          IconSlideAction(
            caption: '编辑',
            color: Colors.blue,
            icon: Icons.edit,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                  BookShelfEditPage(
                    shelfName: this.shelfData.shelfName,
                    mode: Mode.EditShelf,
                    refreshBookShelf: editAction,
                  )
                )
              );
            },
          ),

        ],
        // 删除按钮
        secondaryActions: [
          IconSlideAction(
            caption: '删除',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              deleteAction();
            },

          ),
        ],
      ),

      /*
      Container(
          height: 80,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          padding: EdgeInsets.only(left: 20, right: 15, top: 20, bottom: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.lightBlue, Colors.blue],
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                spreadRadius: 4,
                color: Color.fromARGB(20, 0, 0, 0),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    this.shelfData.shelfName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "数量: " + this.shelfData.numbersOfBooks.toString() + " 本",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(200, 255, 255, 255),
                    ),
                  ),
                ],
              ),),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 0),
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              )

            ],

          )
      ),

      */
    );
  }
}

// 书架信息
class BookShelfData {

  String shelfName;
  int numbersOfBooks;

  BookShelfData({this.shelfName, this.numbersOfBooks});

}


// class CreditCard extends StatelessWidget {
//   final CreditCardViewModel data;
//
//   const CreditCard({Key key, this.data}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 180,
//       margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
//       padding: EdgeInsets.only(left: 20, top: 20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: this.data.cardColors,
//         ),
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             blurRadius: 6,
//             spreadRadius: 4,
//             color: Color.fromARGB(20, 0, 0, 0),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: <Widget>[
//           Positioned(
//             right: -100,
//             bottom: -100,
//             child: Image.asset(
//               this.data.bankLogoUrl,
//               width: 250,
//               height: 250,
//               color: Colors.white10,
//             ),
//           ),
//           Positioned(
//             left: 0,
//             top: 0,
//             right: 0,
//             bottom: 0,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     CircleAvatar(
//                       radius: 25,
//                       backgroundColor: Colors.white,
//                       child: Image.asset(
//                         this.data.bankLogoUrl,
//                         width: 36,
//                         height: 36,
//                         fit: BoxFit.scaleDown,
//                       ),
//                     ),
//                     Padding(padding: EdgeInsets.only(left: 15)),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           this.data.bankName,
//                           style: TextStyle(
//                             fontSize: 19,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         Text(
//                           this.data.cardType,
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Color.fromARGB(200, 255, 255, 255),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 65, top: 20),
//                   child: Text(
//                     this.data.cardNumber,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontFamily: 'Farrington',
//                       letterSpacing: 3,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 65, top: 15),
//                   child: Text(
//                     this.data.validDate,
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class CreditCardViewModel {
//   /// 银行
//   final String bankName;
//
//   /// 银行Logo
//   final String bankLogoUrl;
//
//   /// 卡类型
//   final String cardType;
//
//   /// 卡号
//   final String cardNumber;
//
//   /// 卡片颜色
//   final List<Color> cardColors;
//
//   /// 有效期
//   final String validDate;
//
//   const CreditCardViewModel({
//     this.bankName,
//     this.bankLogoUrl,
//     this.cardType,
//     this.cardNumber,
//     this.cardColors,
//     this.validDate,
//   });
// }