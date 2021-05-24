import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:my_library/Functions/Utils.dart';

// 网络请求功能封装类

// TODO: 服务器的主机
String WebURL = "https://mylibrary.cn.utools.club/";


class UserRequest {
  Future<String> Register(Map userInfo) async {
    // 1.拼接URL
    final username = "username=" + userInfo["username"];
    final password = "password=" + userInfo["password"];
    final email = "email=" + userInfo["email"];
    final phone = "phone=" + userInfo["phone"];
    final url = "${WebURL}/user/register?" + username + "&" + password + "&" + email + "&" + phone;

    // 2.发送请求
    final response = await Dio().get(url);

    // 3.解析response
    var result = response.toString();
    print("注册结果: " + result);

    // 4. 返回
    return result;
  }

  Future<dynamic> Login(phone, password) async {

    print("login");

    // 1.拼接URL
    password = "password=" + password;
    phone = "phone=" + phone;
    final url = "${WebURL}/user/login?" + password + "&" + phone;

    // 2.发送请求
    final response = await Dio().get(url);

    // 3.解析response
    var result = response.toString();
    print("登录结果: " + result);

    var jsonResult = textToJson(result);

    // 4. 返回
    return jsonResult;
  }
}


/*
// TODO: 网络请求
class NetworkRequest {

  // TODO: 主页请求学院列表
  // 获取班级列表
  Future<Map<String, int>> getCollegesList() async {
    // 1.拼接URL
    final url = "http://${WebURL}:8000/get_colleges";

    // 2.发送请求
    final response = await Dio().get(url);

    // 3.解析json
    var jsonResult = json.decode(response.toString());

    print(jsonResult);

    // 4. json转换成列表
    // 必须初始化！！！
    Map<String, int> colleges = {};

    for (var oneCollege in jsonResult["Colleges"]) {
      colleges[oneCollege["col_name"]] = oneCollege["col_id"];
    }

    print("getCollegesList");

    return colleges;
  }

  // TODO: 主页请求年级列表
  // 获取班级列表
  Future<Map<String, int>> getGradesList() async {
    // 1.拼接URL
    final url = "http://${WebURL}:8000/get_grades";

    // 2.发送请求
    final response = await Dio().get(url);

    // 3.解析json
    var jsonResult = json.decode(response.toString());

    print(jsonResult);

    // 4. json转换成列表
    // 必须初始化！！！
    Map<String, int> grades = {};

    for (var oneGrade in jsonResult["Grades"]) {
      grades[oneGrade["gra_name"]] = oneGrade["gra_id"];
    }

    print("getGradesList");

    return grades;
  }


  // TODO: 主页请求专业列表
  // 获取班级列表
  Future<Map<String, int>> getMajorsList(int collegeID, int gradeID) async {
    // 1.拼接URL
    final url = "http://${WebURL}:8000/get_majors?college_id=${collegeID}";

    // 2.发送请求
    final response = await Dio().get(url);

    // 3.解析json
    var jsonResult = json.decode(response.toString());

    print(jsonResult);

    // 4. json转换成列表
    // 必须初始化！！！
    Map<String, int> majors = {};

    for (var oneMajor in jsonResult["Majors"]) {
      majors[oneMajor["major_name"]] = oneMajor["major_id"];
    }

    print("getGradesList");

    return majors;
  }

  // TODO: 主页请求班级
  // 获取班级列表
  Future<Map<String, int>> getClassesList({int collegeId, int gradeId, int majorId}) async {
    // 1.拼接URL
    final url = "http://${WebURL}:8000/get_class?college_id=${collegeId}&grade_id=${gradeId}&major_id=${majorId}";

    // 2.发送请求
    final response = await Dio().get(url);

    // 3.解析json
    var jsonResult = json.decode(response.toString());

    print(jsonResult);

    // 4. json转换成列表
    // 必须初始化！！！
    Map<String, int> classes = {};

    for (var oneClass in jsonResult["Classes"]) {
      classes[oneClass["class_name"]] = oneClass["class_id"];
    }

    print("getClasses");

    return classes;
  }

  // 测试用函数
  Future testNetwork() async {
    // 1.拼接URL
    final url = "http://${WebURL}:8000/get_scores";

    // 2.发送请求
    final response = await Dio().get(url);

    // 3.解析json
    var jsonResult = json.decode(response.toString());

    print(jsonResult);
  }

// TODO: 班级页面请求学生列表
  // 从网络获取json
  // 参数：班级名称
  // 返回值：学生列表
  Future<List<Student>> getStudentsList({int collegeId, int gradeId, int majorId, int classId}) async {
    // 1.拼接URL
    final url = "http://${WebURL}:8000/get_stus?college_id=${collegeId}&grade_id=${gradeId}&major_id=${majorId}&class_id=${classId}";

    // 2.发送请求
    final response = await Dio().get(url);//, queryParameters: {"college_id": collegeId, "grade_id": gradeId, "major_id": majorId, "class_id": classId,});
    // final response = await Dio().get(url);

    // 3.解析json
    var jsonResult = json.decode(response.toString());

    //print(jsonResult);

    // 4. json转换成列表
    // 必须初始化！！！
    List<Student> students = [];

    for (var oneStudent in jsonResult["Students"]) {
      print(oneStudent);
      students.add(
          Student(oneStudent)
      );
    }

    print(students);

    // 5. 返回列表
    return students;
  }

  // TODO: 上传图片
  // 参数：（图片路径，学号）
  // 返回值：response
  Future<Response> uploadImage(String imagePath, String stu_number, BuildContext context) async {
    // 1.拼接URL
    final url = "http://${WebURL}:8000/photo";

    print(imagePath);

    // 2.准备上传数据
    FormData formData = FormData.fromMap({
      "stu_num": stu_number,
      "img": await MultipartFile.fromFile(imagePath,filename: "${stu_number}.jpg"),
    });

    // 3. 发送Post请求
    var dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
        onError: (DioError error) {
          print("拦截了错误");
          return error;
        }
    ));


    // 尝试请求
    try {
      var response = await dio.post(url, data: formData);
      print(response);
      // 4. 返回请求结果
      return response;

    } on DioError catch (e) {
      //设置错误对话框
      AlertDialog errorAlert = AlertDialog(
        title: Text("识别失败"),
        content: Text("上传的答题卡不合格, 请重新拍照"),
        actions: [
          FlatButton(
            child: Text("确定"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );

      //显示错误对话框
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return errorAlert;
        },
      );
    }

  }
}
*/