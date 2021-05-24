import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_library/Functions/Utils.dart';
import 'package:permission_handler/permission_handler.dart';

// 本地数据存储辅助类(使用 Shared_Preferences)
class LocalStorage {

  // 初始化
  Future<bool> initLocalStorage() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.reload();

    // 设置版本信息
    prefs.setString("Version", "Alpha 0.2");
    prefs.setString("UpdateDate", "2021.05.21");

    // 设置登录状态
    if (!prefs.containsKey("isLogin")) {
      return prefs.setBool("isLogin", false);
    } else {
      return true;
    }
  }

  // 获取初始化状态
  Future<void> getInitializationString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.reload();

    print("Check Version: " + prefs.getString("Version"));
    print("Check UpdateDate: " + prefs.getString("UpdateDate"));
    return;
  }

  // 用户登录
  Future<bool> userLogin({String userName, String userPasswd, String userEmail, String userPhone}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("UserName", userName);
      prefs.setString("Email", userEmail);
      prefs.setString("Phone", userPhone);
      prefs.setString("Password", userPasswd);
    return prefs.setBool("isLogin", true);
  }

  // 用户登出
  Future<bool> userLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("UserName");
    prefs.remove("Password");
    prefs.remove("Email");
    prefs.remove("Phone");
    return prefs.setBool("isLogin", false);
  }

  // 判断用户是否登录
  Future<bool> isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogin");
  }

  // 获取用户名
  Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.getBool("isLogin")) {
      return null;
    }

    return prefs.getString("UserName");
  }

  // 判断输入密码和存储的加密密码是否相同
  Future<bool> isPasswdCorrect(String userPasswd) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.getBool("isLogin")) {
      return false;
    }

    return (EncryptPassword(userPasswd) == prefs.getString("Password"));
  }

  // 获取邮箱
  Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.getBool("isLogin")) {
      return null;
    }

    return prefs.getString("Email");
  }

  // 获取手机号
  Future<String> getUserPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.getBool("isLogin")) {
      return null;
    }

    return prefs.getString("Phone");
  }

  // 登录判断是否正确
  Future<int> Validate(String userName, String userPasswd) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (userName != prefs.getString("UserName")) {
      // 用户不存在
      return -1;
    } else {
      if (userPasswd != prefs.getString("Password")) {
        // 密码不正确
        return 0;
      }
    }

    // 登录成功
    return 1;

  }

  // 存储新用户
  Future<bool> SaveUser(String userName, String userPasswd) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 如果用户已存在,返回false
    if (prefs.containsKey(userName) == true) {
      return false;
    }
    // 返回注册用户存储结果
    Future<bool> result = prefs.setString(userName, userPasswd);
    return result;
  }

  // 清空所有内容
  Future<bool> clearAllUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Future<bool> result = prefs.clear();
    return result;
  }


}