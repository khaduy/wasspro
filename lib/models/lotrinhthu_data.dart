import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class LoTrinhThuData {
  num soluongthu;
  num tongtienthu;
  String tenLT;
  String maLT;
  String maCN;
  num loTrinhID;
  num chiNhanhID;
  num nhanVienID;
  num soluongdongbo;
  num tongtiendongbo;

  LoTrinhThuData(
      {this.soluongthu,
      this.tongtienthu,
      this.tenLT,
      this.maLT,
      this.maCN,
      this.loTrinhID,
      this.chiNhanhID,
      this.nhanVienID,
      this.soluongdongbo,
      this.tongtiendongbo});

  factory LoTrinhThuData.fromJson(Map<String, dynamic> json) {
    return LoTrinhThuData(
      soluongthu: json['soluongthu'],
      tongtienthu: json['tongtienthu'],
      tenLT: json['tenLT'],
      maLT: json['maLT'],
      maCN: json['maCN'],
      loTrinhID: json['LoTrinhID'],
      chiNhanhID: json['ChiNhanhID'],
      nhanVienID: json['NhanVienID'],
      soluongdongbo: json['soluongdongbo'],
      tongtiendongbo: json['tongtiendongbo'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['soluongthu'] = this.soluongthu;
    data['tongtienthu'] = this.tongtienthu;
    data['tenLT'] = this.tenLT;
    data['maLT'] = this.maLT;
    data['maCN'] = this.maCN;
    data['LoTrinhID'] = this.loTrinhID;
    data['ChiNhanhID'] = this.chiNhanhID;
    data['NhanVienID'] = this.nhanVienID;
    data['soluongdongbo'] = this.soluongdongbo;
    data['tongtiendongbo'] = this.tongtiendongbo;
    return data;
  }
}
