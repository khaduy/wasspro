import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

Future<List<ThongKeData>> fetchThongKe() async {
  var response = await http.get(Uri.parse(
      'http://113.161.206.49/ttns/api/api/LoTrinhKhachHangThu?macn=09&nvid=357&token=301f2b1d9b9781b7ef18cb7a355079f9'));
  var response1 =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
  if (response.statusCode == 200) {
    List jsonResponse0 = await jsonDecode(response.body);
    List jsonResponse1 = await jsonDecode(response1.body);

    return jsonResponse0.map((data) => ThongKeData.fromJson(data)).toList();
  } else {
    print('res: ${response.body}');
    throw Exception('Failed');
  }
}
class ThongKeData {
  final String maTL;

  ThongKeData({
    this.maTL,
  });

  factory ThongKeData.fromJson(Map<String, dynamic> json) {
    return ThongKeData(
      maTL: json["tenLT"],
    );
  }
}
