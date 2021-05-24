import 'package:flutter/material.dart';
import 'package:my_library/Controllers/Home/HomePage.dart';
import 'package:tform/tform.dart';

import 'package:my_library/Functions/Utils.dart';

String this_ISBN = "";

class AddBookPage extends StatefulWidget {

  AddBookPage({String ISBN}) {
    this_ISBN = ISBN;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddBookPageState();
  }
}

class AddBookPageState extends State<AddBookPage> {
  @override
  void initState() {
    // TODO: implement initState
    print(_formKey.currentState);
    super.initState();
  }

  // 表单通过GlobalKey获取,遍历表单组件获取值得内容
  final GlobalKey _formKey = GlobalKey<TFormState>();

  // 无ISBN按钮
  var ISBNButtonShape = RoundedRectangleBorder(
      side: BorderSide(
        color: Colors.white,
      )
  );
  Color ISBNButtonColor = Colors.blue;
  var ISBNButtonText = Text("有ISBN", style: TextStyle(color: Colors.white),);
  bool hasISBN = false;

  // 借出状态按钮
  var LentButtonShape = RoundedRectangleBorder(
      side: BorderSide(
          color: Colors.white
      )
  );
  Color LentButtonColor = Colors.blue;
  var LentButtonText = Text("未借出", style: TextStyle(color: Colors.white),);
  bool isLent = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text("新增书籍")
      ),
      body: TForm.builder(
        key: _formKey,
        rows: buildFormRows(),
        divider: Divider(
          height: 1,
        ),
      ),

      // 提交表单,遍历组件获取值
      floatingActionButton: FloatingActionButton(
        child: Text("完成\n录入"),
        onPressed: () {
          var state = _formKey.currentState as TFormState;
          print(state.rows.length);
          //print(state.rows.iterator);
          for (var row in state.rows) {
            print(row.value);
          }
        },
      ),
    );
  }

  List<TFormRow> buildFormRows() {
    return [
      TFormRow.customCell(
        widget: Container(
            color: Colors.grey[100],
            height: 36,
            width: double.infinity,
            alignment: Alignment.bottomLeft,
            child: Text("基本内容"),
            padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
        ),
        tag: "基本内容",
      ),

      TFormRow.input(
        requireStar: true,
        title: "书名",
        placeholder: "请输入书名",
        value: "",
        //onChanged: (row) => print(row.value),
      ),

      TFormRow.input(
        enabled: true,
        requireStar: false,
        title: "ISBN",
        placeholder: "请输入ISBN号",
        value: this_ISBN,
        suffixWidget: (context, row) {

          FlatButton noISBN = FlatButton(
            child: ISBNButtonText,
            shape: ISBNButtonShape,
            color: ISBNButtonColor,
            onPressed: () {
              setState(() {
                row.enabled = !row.enabled;
                hasISBN = row.enabled;

                if (row.enabled) {
                  ISBNButtonText = Text("有ISBN", style: TextStyle(color: Colors.white),);

                  ISBNButtonColor = Colors.blue;
                  ISBNButtonShape = RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.white,
                      )
                  );
                  row.placeholder = "请输入ISBN号";
                  row.value = "";

                } else {
                  ISBNButtonText = Text("无ISBN",);
                  ISBNButtonColor = null;
                  ISBNButtonShape = RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.black
                      )
                  );
                  row.placeholder = "该书无ISBN号";
                  row.value = "该书无ISBN码";
                }

              });
            },
          );
          return noISBN;
        },
      ),

      TFormRow.customCell(
        widget: Container(
            color: Colors.grey[100],
            height: 36,
            width: double.infinity,
            alignment: Alignment.bottomLeft,
            child: Text("书籍管理"),
            padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
        ),

      ),

      TFormRow.selector(
        title: "书柜",
        placeholder: "请选择所在书柜",
        options: [
          TFormOptionModel(value: "书房"),
          TFormOptionModel(value: "客厅"),
          TFormOptionModel(value: "卧室"),
          TFormOptionModel(value: "柜子")
        ],
        //value: "专科"
      ),

      TFormRow.input(
        enabled: true,
        requireStar: false,
        title: "备注",
        placeholder: "请输入备注",
        value: "",
      ),

      TFormRow.input(
        enabled: false,
        requireStar: false,
        title: "借给",
        placeholder: "请输入借出人的信息",
        value: "",
        tag: "借给人",
        suffixWidget: (context, row) {

          FlatButton noISBN = FlatButton(
            child: LentButtonText,
            shape: LentButtonShape,
            color: LentButtonColor,
            onPressed: () {
              setState(() {
                row.enabled = !row.enabled;
                isLent = row.enabled;

                if (row.enabled) {
                  LentButtonText = Text("已借出");
                  LentButtonColor = null;
                  LentButtonShape = RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.black
                      )
                  );
                  row.placeholder = "请输入借出人姓名";
                  row.value = "";

                } else {
                  LentButtonText = Text("未借出", style: TextStyle(color: Colors.white),);
                  LentButtonColor = Colors.blue;
                  LentButtonShape = RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.white,
                      )
                  );
                  row.placeholder = "该书未借出";
                  row.value = "该书未借出";
                }

              });
            },
          );
          return noISBN;
        },
      ),

      TFormRow.customCell(
        widget: Container(
            color: Colors.grey[100],
            height: 36,
            width: double.infinity,
            alignment: Alignment.bottomLeft,
            child: Text("购买信息"),
            padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
        ),
      ),

      TFormRow.input(
        enabled: true,
        requireStar: false,
        title: "购买渠道",
        textAlign: TextAlign.right,
        placeholder: "输入购买渠道(淘宝/京东/书店/...)",
        value: "",
      ),

      TFormRow.customSelector(
        title: "购买日期",
        placeholder: "请选择购买日期",
        onTap: (context, row) async {
          return showPickerDate(context);
        },
        fieldConfig: TFormFieldConfig(
          selectorIcon: SizedBox.shrink(),
        ),
      ),

      TFormRow.input(
        enabled: true,
        requireStar: false,
        title: "买入价格",
        textAlign: TextAlign.right,
        placeholder: "请输入价格",
        value: "",
        suffixWidget: (context, row) {
          return Text("元");
        }
      ),

      TFormRow.customCell(
        widget: Container(
            color: Colors.grey[100],
            height: 36,
            width: double.infinity,
            alignment: Alignment.bottomLeft,
            child: Text("详细信息"),
            padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
        ),
      ),

      TFormRow.input(
        enabled: true,
        requireStar: false,
        title: "作者",
        textAlign: TextAlign.right,
        placeholder: "作者姓名",
        value: "",
      ),

      TFormRow.input(
        enabled: true,
        requireStar: false,
        title: "译者",
        textAlign: TextAlign.right,
        placeholder: "译者姓名",
        value: "",
      ),

      TFormRow.input(
        enabled: true,
        requireStar: false,
        title: "出版社",
        textAlign: TextAlign.right,
        placeholder: "出版社信息",
        value: "",
      ),

      TFormRow.customSelector(
        title: "出版日期",
        placeholder: "请选择出版日期(年-月)",
        onTap: (context, row) async {
          return showPickerDateOnlyYearAndMonth(context);
        },
        fieldConfig: TFormFieldConfig(
          selectorIcon: SizedBox.shrink(),
        ),
      ),


      TFormRow.input(
        enabled: true,
        requireStar: false,
        title: "总页数",
        textAlign: TextAlign.right,
        placeholder: "请输入该书的总页数",
        value: "",
      ),

      TFormRow.customCell(
        widget: Container(
            color: Colors.grey[100],
            height: 36,
            width: double.infinity,
            alignment: Alignment.bottomLeft,
            child: Text("简介信息"),
            padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
        ),
      ),


      TFormRow.input(
        enabled: true,
        requireStar: false,
        title: "内容简介",
        placeholder: "",
        value: "",
      ),

      TFormRow.input(
        enabled: true,
        requireStar: false,
        title: "作者简介",
        placeholder: "",
        value: "",
      ),

    ];
  }
}