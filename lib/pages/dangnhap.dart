import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:wasspro/pages/thongke.dart';
import 'package:wasspro/models/dangnhap_data.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DangNhap extends StatefulWidget {
  @override
  _DangNhapState createState() => _DangNhapState();
}

class _DangNhapState extends State<DangNhap> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var onPress;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bgwasspro.png"),
                    fit: BoxFit.cover)),
          ),
          Container(
            child: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textSection(),
                buttonSection(),
              ],
            )),
          ),
        ],
      ),
    );
  }

  signIn(String username, String pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('http://api.vnptcantho.com.vn/pntest/api/DangNhap'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "Key": "3b851f9fb412e97ec9992295ab9c3215",
        "Token": "a29c79a210968550fe54fe8d86fd27dd",
        "MaND": username,
        "Pass": pass
      }),
    );
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        var respJson = await jsonDecode(response.body)["data"];
        String respString = await jsonEncode(respJson);
        sharedPreferences.setString("dangnhap", respString);
        sharedPreferences.setString("lotrinhthu", "khong co");
        sharedPreferences.setString("lotrinhthudata", "khong co");
        sharedPreferences.setString("lotrinhghi", "khong co");
        sharedPreferences.setString("lotrinhghidata", "khong co");
        sharedPreferences.setString("lotrinhkh", "khong co");
        sharedPreferences.setString("lotrinhkhdata", "khong co");
        Navigator.pushNamedAndRemoveUntil(
            context, '/thongke', (route) => false);
      } else {
        return showDialog<void>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Thông báo'),
            content:
                const Text('Vui lòng kiểm tra lại tên đăng nhập hoặc mật khẩu'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'Ok'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      throw Exception('Failed.');
    }
  }

  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60),
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: usernameController,
            decoration: const InputDecoration(
                hintText: 'nhập tên đăng nhập',
                labelText: 'Tên đăng nhập',
                border: OutlineInputBorder()),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: passwordController,
            obscureText: true, // che mat khau
            decoration: const InputDecoration(
                hintText: 'nhập mật khẩu',
                labelText: 'Mật khẩu',
                border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }

  Container buttonSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60),
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        child: const Text('Đăng nhập'),
        onPressed: () async {
          signIn(usernameController.text, passwordController.text);
        },
      ),
    );
  }
}
