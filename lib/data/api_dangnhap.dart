import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

Future<ApiDangNhap> fetchDangNhap() async {
  final response = await http.get(Uri.parse(
      'http://113.161.206.49/WebserviceChuanHoa/api/DangNhap?mand=anbinh.nv01&pass=123456'));
  // print('check: ${response.body}');
  // if (response.body == 'null') {
  //   return ApiDangNhap.checknull(jsonDecode('{"token": "khongco"}'));
  // } else
  if (response.statusCode == 200) {
    // print('apidangnhap: ${ApiDangNhap.fromJson(jsonDecode(response.body))}');
    var data = jsonDecode(response.body);
    var firstObj = (data['data'] as List<dynamic>).first;
    return ApiDangNhap.fromJson(firstObj);
    // return ApiDangNhap.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Dang Nhap');
  }
}

class ApiDangNhap {
  // double? nhanVienID;
  // String? maNV;
  // String hoTenNV;
  // String? ngaySinh;
  // bool? gioiTinh;
  // String? quocTich;
  // String? soCMND;
  // String? ngayCap;
  // String? noiCap;
  // String? diaChi;
  // String? hoKhau;
  // String? mST;
  // String? sDT;
  // double? chiNhanhID;
  // String? phongBanID;
  // String? keToan;
  // String? admin;
  // String? hDXD;
  // String? extra1;
  // String? extra2;
  // String? extra3;
  // String? maNd;
  // String? password;
  // String? token;
  // String? tenCN;
  // String? sDTCN;
  // String? dCCN;
  // String? expired;
  // String? tenCTY;
  // String? dCCTY;
  // String? sDTCTY;
  // String? maCN;
  // String? mACAddress;
  // String? modelName;
  // String? check;
  final String token;

  ApiDangNhap({required this.token});
  // {required this.nhanVienID,
  // required this.maNV,
  // required this.hoTenNV,
  // required this.ngaySinh,
  // required this.gioiTinh,
  // required this.quocTich,
  // required this.soCMND,
  // required this.ngayCap,
  // required this.noiCap,
  // required this.diaChi,
  // required this.hoKhau,
  // required this.mST,
  // required this.sDT,
  // required this.chiNhanhID,
  // required this.phongBanID,
  // required this.keToan,
  // required this.admin,
  // required this.hDXD,
  // required this.extra1,
  // required this.extra2,
  // required this.extra3,
  // required this.maNd,
  // required this.password,
  // required this.token,
  // required this.tenCN,
  // required this.sDTCN,
  // required this.dCCN,
  // required this.expired,
  // required this.tenCTY,
  // required this.dCCTY,
  // required this.sDTCTY,
  // required this.maCN,
  // required this.mACAddress,
  // required this.modelName,
  // this.checknull});

  factory ApiDangNhap.fromJson(Map<String, dynamic> json) {
    return ApiDangNhap(token: json['token']
        // nhanVienID: json['NhanVienID'],
        // maNV: json['MaNV'],
        // hoTenNV: json['HoTenNV'],
        // ngaySinh: json['NgaySinh'],
        // gioiTinh: json['GioiTinh'],
        // quocTich: json['QuocTich'],
        // soCMND: json['SoCMND'],
        // ngayCap: json['NgayCap'],
        // noiCap: json['NoiCap'],
        // diaChi: json['DiaChi'],
        // hoKhau: json['HoKhau'],
        // mST: json['MST'],
        // sDT: json['SDT'],
        // chiNhanhID: json['ChiNhanhID'],
        // phongBanID: json['PhongBanID'],
        // keToan: json['KeToan'],
        // admin: json['Admin'],
        // hDXD: json['HDXD'],
        // extra1: json['Extra1'],
        // extra2: json['Extra2'],
        // extra3: json['Extra3'],
        // maNd: json['ma_nd'],
        // password: json['Password'],
        // token: json['token'],
        // tenCN: json['tenCN'],
        // sDTCN: json['SDT_CN'],
        // dCCN: json['DC_CN'],
        // expired: json['expired'],
        // tenCTY: json['tenCTY'],
        // dCCTY: json['DC_CTY'],
        // sDTCTY: json['SDT_CTY'],
        // maCN: json['maCN'],
        // mACAddress: json['MAC_Address'],
        // modelName: json['ModelName'],
        );
  }

  factory ApiDangNhap.checknull(Map<String, dynamic> json) {
    return ApiDangNhap(token: json['token']);
  }
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['NhanVienID'] = this.nhanVienID;
  //   data['MaNV'] = this.maNV;
  //   data['HoTenNV'] = this.hoTenNV;
  //   data['NgaySinh'] = this.ngaySinh;
  //   data['GioiTinh'] = this.gioiTinh;
  //   data['QuocTich'] = this.quocTich;
  //   data['SoCMND'] = this.soCMND;
  //   data['NgayCap'] = this.ngayCap;
  //   data['NoiCap'] = this.noiCap;
  //   data['DiaChi'] = this.diaChi;
  //   data['HoKhau'] = this.hoKhau;
  //   data['MST'] = this.mST;
  //   data['SDT'] = this.sDT;
  //   data['ChiNhanhID'] = this.chiNhanhID;
  //   data['PhongBanID'] = this.phongBanID;
  //   data['KeToan'] = this.keToan;
  //   data['Admin'] = this.admin;
  //   data['HDXD'] = this.hDXD;
  //   data['Extra1'] = this.extra1;
  //   data['Extra2'] = this.extra2;
  //   data['Extra3'] = this.extra3;
  //   data['ma_nd'] = this.maNd;
  //   data['Password'] = this.password;
  //   data['token'] = this.token;
  //   data['tenCN'] = this.tenCN;
  //   data['SDT_CN'] = this.sDTCN;
  //   data['DC_CN'] = this.dCCN;
  //   data['expired'] = this.expired;
  //   data['tenCTY'] = this.tenCTY;
  //   data['DC_CTY'] = this.dCCTY;
  //   data['SDT_CTY'] = this.sDTCTY;
  //   data['maCN'] = this.maCN;
  //   data['MAC_Address'] = this.mACAddress;
  //   data['ModelName'] = this.modelName;
  //   return data;
  // }
}
