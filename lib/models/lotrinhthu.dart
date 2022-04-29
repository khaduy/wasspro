import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<LoTrinhThu>> fetchHoaDon() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.getString("lotrinhthu") == "khong co") {
    final response = await http.post(
      Uri.parse('http://api.vnptcantho.com.vn/pntest/api/getLoTrinhThu'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "k": "a29c79a210968550fe54fe8d86fd27dd",
        "tk": "a29c79a210968550fe54fe8d86fd27dd",
        "nvid": '48',
        "chinhanhid": "9",
        "token": "765edf44ac1a6730cc0f38b42fcb1926"
      }),
    );
    if (response.statusCode == 200) {
      print(response.request);
      if (jsonDecode(response.body)["message"] == "Success") {
        List respJson = await jsonDecode(response.body)["data"];
        var respString = await jsonEncode(respJson);
        prefs.setString("lotrinhthu", respString);
        return respJson.map((data) => LoTrinhThu.fromJson(data)).toList();
      } else {
        print("error");
        return [];
      }
    } else {
      throw Exception('Failed.');
    }
  } else {
    List jsonResponse0 = await jsonDecode(prefs.getString("lotrinhthu") ?? "");
    return jsonResponse0.map((data) => LoTrinhThu.fromJson(data)).toList();
  }

  // if (prefs.getString("lotrinhthu") == "khong co") {
  //   var response = await http.get(Uri.parse(
  //       'http://api.vnptcantho.com.vn/wp-qnh/api/LoTrinhKhachHangThu?chinhanhid=9&nvid=48&token=765edf44ac1a6730cc0f38b42fcb1926'));
  //   if (response.statusCode == 200) {
  //     if (response.body != null) {
  //       prefs.setString("lotrinhthu", response.body);
  //       List jsonResponse0 = await jsonDecode(response.body);
  //       return jsonResponse0.map((data) => LoTrinhThu.fromJson(data)).toList();
  //     } else {
  //       return [];
  //     }
  //   } else {
  //     print('res: ${response.body}');
  //     throw Exception('Failed');
  //   }
  // } else {
  //   List jsonResponse0 = await jsonDecode(prefs.getString("lotrinhthu") ?? "");
  //   return jsonResponse0.map((data) => LoTrinhThu.fromJson(data)).toList();
  // }
}

class LoTrinhThu {
  final num soluongthu;
  final num tongtienthu;
  final String tenLT;
  final String maLT;
  final String maCN;
  final num nhanVienID;
  final num loTrinhID;
  final num chiNhanhID;
  final num soluongdongbo;
  final num tongtiendongbo;

  LoTrinhThu(
      {required this.soluongthu,
      required this.tongtienthu,
      required this.tenLT,
      required this.maLT,
      required this.maCN,
      required this.nhanVienID,
      required this.loTrinhID,
      required this.chiNhanhID,
      required this.soluongdongbo,
      required this.tongtiendongbo});

  factory LoTrinhThu.fromJson(Map<String, dynamic> json) {
    return LoTrinhThu(
      soluongthu: json["soluongthu"] ?? 0,
      tongtienthu: json["tongtienthu"] ?? 0,
      tenLT: json["tenLT"] ?? "",
      maLT: json["maLT"] ?? "",
      maCN: json["maCN"] ?? "",
      nhanVienID: json["NhanVienID"] ?? 0,
      loTrinhID: json["LoTrinhID"] ?? 0,
      chiNhanhID: json["ChiNhanhID"] ?? 0,
      soluongdongbo: json["soluongdongbo"] ?? 0,
      tongtiendongbo: json["tongtiendongbo"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['soluongthu'] = this.soluongthu;
    data['tongtienthu'] = this.tongtienthu;
    data['tenLT'] = this.tenLT;
    data['maLT'] = this.maLT;
    data['maCN'] = this.maCN;
    data['NhanVienID'] = this.nhanVienID;
    data['LoTrinhID'] = this.loTrinhID;
    data['ChiNhanhID'] = this.chiNhanhID;
    data['soluongdongbo'] = this.soluongdongbo;
    data['tongtiendongbo'] = this.tongtiendongbo;
    return data;
  }
}