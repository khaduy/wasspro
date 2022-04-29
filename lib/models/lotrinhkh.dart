import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<LoTrinhKH>> fetchLoTrinhKH() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString("lotrinhkh") == "khong co") {
    final response = await http.post(
      Uri.parse('http://api.vnptcantho.com.vn/pntest/api/getLoTrinhKhachHang'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "k": "a29c79a210968550fe54fe8d86fd27dd",
        "tk": "a29c79a210968550fe54fe8d86fd27dd",
        "nvid": '48',
      }),
    );

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        List respJson = await jsonDecode(response.body)["data"];
        var respString = await jsonEncode(respJson);
        prefs.setString("lotrinhkh", respString);
        return respJson.map((data) => LoTrinhKH.fromJson(data)).toList();
      } else {
        return [];
      }
    } else {
      print('res: ${response.body}');
      throw Exception('Failed');
    }
  } else {
    List jsonResponse0 = await jsonDecode(prefs.getString("lotrinhkh") ?? "");
    return jsonResponse0.map((data) => LoTrinhKH.fromJson(data)).toList();
  }
}

Future<List<LoTrinhKH>> fetchLoTrinhKH1() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('object ${prefs.getString("lotrinhkh")}');
  var response = await http.get(Uri.parse(
      'http://api.vnptcantho.com.vn/wp-qnh/api/LoTrinhKhachHang?nvid=46&token=765edf44ac1a6730cc0f38b42fcb1926'));
  if (response.statusCode == 200) {
    if (response.body != 'null') {
      prefs.setString("lotrinhkh", response.body);
      List jsonResponse = await jsonDecode(response.body);
      return jsonResponse.map((data) => LoTrinhKH.fromJson(data)).toList();
    } else {
      return [];
    }
  } else {
    print('res: ${response.body}');
    throw Exception('Failed');
  }
}

class LoTrinhKH {
  num soluongKH;
  String tenlt;
  String maLT;
  num loTrinhID;

  LoTrinhKH(
      {required this.soluongKH,
      required this.tenlt,
      required this.maLT,
      required this.loTrinhID});

  factory LoTrinhKH.fromJson(Map<String, dynamic> json) {
    return LoTrinhKH(
      soluongKH: json["soluongKH"],
      tenlt: json["tenlt"],
      maLT: json["MaLT"],
      loTrinhID: json["LoTrinhID"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['soluongKH'] = this.soluongKH;
    data['tenlt'] = this.tenlt;
    data['MaLT'] = this.maLT;
    data['LoTrinhID'] = this.loTrinhID;
    return data;
  }
}
