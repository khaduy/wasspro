import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<LoTrinhGhi>> fetchLoTrinhGhi() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var login = await jsonDecode(prefs.getString("dangnhap"));
  if (prefs.getString("lotrinhghi") == "khong co") {
    final response = await http.post(
      Uri.parse('http://api.vnptcantho.com.vn/pntest/api/getLoTrinhGhi'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "Key": "3b851f9fb412e97ec9992295ab9c3215",
        "Token": "a29c79a210968550fe54fe8d86fd27dd",
        "NhanVienID": login['NhanVienID'].toInt().toString(),
        "ChiNhanhID": login['ChiNhanhID'].toInt().toString(),
        "UserToken": login['token'].toString(),
      }),
    );
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        List respJson = await jsonDecode(response.body)["data"];
        var respString = await jsonEncode(respJson);
        prefs.setString("lotrinhghi", respString);
        return respJson.map((data) => LoTrinhGhi.fromJson(data)).toList();
      } else {
        print("error");
        return [];
      }
    } else {
      throw Exception('Failed.');
    }
  } else {
    List jsonResponse0 = await jsonDecode(prefs.getString("lotrinhghi") ?? "");
    return jsonResponse0.map((data) => LoTrinhGhi.fromJson(data)).toList();
  }

  // if (prefs.getString("lotrinhghi") == "khong co") {
  //   var response = await http.get(Uri.parse(
  //       'http://api.vnptcantho.com.vn/wp-qnh/api/LoTrinhKhachHangGhi?chinhanhid=9&nvid=48&token=765edf44ac1a6730cc0f38b42fcb1926'));
  //   if (response.statusCode == 200) {
  //     if (response.body != null) {
  //       prefs.setString("lotrinhghi", response.body);
  //       List jsonResponse = await jsonDecode(response.body);
  //       return jsonResponse.map((data) => LoTrinhGhi.fromJson(data)).toList();
  //     } else {
  //       return [];
  //     }
  //   } else {
  //     print('res: ${response.body}');
  //     throw Exception('Failed');
  //   }
  // } else {
  //   List jsonResponse0 = await jsonDecode(prefs.getString("lotrinhghi") ?? "");
  //   return jsonResponse0.map((data) => LoTrinhGhi.fromJson(data)).toList();
  // }
}

class LoTrinhGhi {
  num soluongghi;
  num daghi;
  num dathu;
  String tenLT;
  String maLT;
  String maCN;
  num nhanVienID;
  num loTrinhID;
  num chiNhanhID;

  LoTrinhGhi(
      {this.soluongghi,
      this.daghi,
      this.dathu,
      this.tenLT,
      this.maLT,
      this.maCN,
      this.nhanVienID,
      this.loTrinhID,
      this.chiNhanhID});

  factory LoTrinhGhi.fromJson(Map<String, dynamic> json) {
    return LoTrinhGhi(
      soluongghi: json["soluongghi"],
      daghi: json["daghi"],
      dathu: json["dathu"],
      tenLT: json["tenLT"],
      maLT: json["maLT"],
      maCN: json["maCN"],
      nhanVienID: json["NhanVienID"],
      loTrinhID: json["LoTrinhID"],
      chiNhanhID: json["ChiNhanhID"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['soluongghi'] = this.soluongghi;
    data['daghi'] = this.daghi;
    data['dathu'] = this.dathu;
    data['tenLT'] = this.tenLT;
    data['maLT'] = this.maLT;
    data['maCN'] = this.maCN;
    data['NhanVienID'] = this.nhanVienID;
    data['LoTrinhID'] = this.loTrinhID;
    data['ChiNhanhID'] = this.chiNhanhID;
    return data;
  }
}
