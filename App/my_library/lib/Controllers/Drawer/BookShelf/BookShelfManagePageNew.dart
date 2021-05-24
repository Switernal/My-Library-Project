import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_library/Controllers/Drawer/BookShelf/BookShelfEditPage.dart';
import 'package:my_library/Views/BookShelf/BookShelfManageCell.dart';


Map<String, int> shelfNames = {"书房" : 10, "客厅" : 20, "书架" : 30, "卧室" : 40, "储物间" : 40};
var BarEditButton = Icon(Icons.edit, color: Colors.white,);
bool isShowEditButton = false;
double rightPadding = 0.0;

class BookShelfManagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BookShelfManagePageState();
  }
}

class BookShelfManagePageState extends State<BookShelfManagePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("书架管理"),
        actions: [
          // 右上角的编辑按钮(在这个文件里无效,另一个文件里可以)
          IconButton(
              icon: BarEditButton,
              onPressed: () {
                setState(() {
                  isShowEditButton = !isShowEditButton;
                  if (isShowEditButton) {
                    BarEditButton = Icon(Icons.check, color: Colors.white,);
                    rightPadding = 10.0;
                  } else {
                    BarEditButton = Icon(Icons.edit, color: Colors.white,);
                    rightPadding = 0.0;
                  }
                });
              }
          )
        ],
      ),
      // 添加书柜按钮
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
              BookShelfEditPage(
                  mode: Mode.AddShelf,
                  refreshBookShelf: (String newShelfName) {

                      if (shelfNames.containsKey(newShelfName) == false) {
                        setState(() {
                          shelfNames[newShelfName] = 0;
                        });
                        return null;
                      } else {
                        return "书柜名已存在";
                    }
                  },

              )));
        },
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 8),
        itemCount: shelfNames.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Expanded(
                child: BookShelfManageCell(
                  shelfData: BookShelfData(
                      shelfName: shelfNames.keys.toList()[index],
                      numbersOfBooks: shelfNames[shelfNames.keys.toList()[index]],
                  ),
                  // 传入删除操作
                  deleteAction: () => setState(() {
                    shelfNames.remove(shelfNames.keys.toList()[index]);
                  }),
                  // 传入修改操作
                  editAction: (String newShelfName) {
                      if (!shelfNames.containsKey(newShelfName)) {
                        String tmp = shelfNames.keys.toList()[index];
                        setState(() {
                          shelfNames[newShelfName] = shelfNames[tmp];
                          shelfNames.remove(tmp);
                        });
                        return null;
                      } else {
                        return "书柜名已存在";
                      }
                  },
                ),
              ),

            ],
          );
        },
      ),

          /*
      Row(
        children: [
          Expanded(child: BookShelfManageCell(
            shelfData: BookShelfData(
                shelfName: "书房",
                numbersOfBooks: 200
            ),
          ),)
        ],
      )
      */
           
      // CreditCard(data: CreditCardViewModel(bankName: "招商", bankLogoUrl: "url", cardType: "信用卡", cardNumber: "201983900048", cardColors: [Colors.blue, Colors.green], validDate: "2021-05"),),
    );
  }
}