import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

class DangNhapData {
  double? nhanVienID;
  String? maNV;
  String hoTenNV;
  String? ngaySinh;
  bool? gioiTinh;
  String? quocTich;
  String? soCMND;
  String? ngayCap;
  String? noiCap;
  String? diaChi;
  String? hoKhau;
  String? mST;
  String? sDT;
  double? chiNhanhID;
  String? phongBanID;
  String? keToan;
  String? admin;
  String? hDXD;
  String? extra1;
  String? extra2;
  String? extra3;
  String? maNd;
  String? password;
  String? token;
  String? tenCN;
  String? sDTCN;
  String? dCCN;
  String? expired;
  String? tenCTY;
  String? dCCTY;
  String? sDTCTY;
  String? maCN;
  String? mACAddress;
  String? modelName;

  DangNhapData(
    {
    required this.nhanVienID,
    required this.maNV,
    required this.hoTenNV,
    required this.ngaySinh,
    required this.gioiTinh,
    required this.quocTich,
    required this.soCMND,
    required this.ngayCap,
    required this.noiCap,
    required this.diaChi,
    required this.hoKhau,
    required this.mST,
    required this.sDT,
    required this.chiNhanhID,
    required this.phongBanID,
    required this.keToan,
    required this.admin,
    required this.hDXD,
    required this.extra1,
    required this.extra2,
    required this.extra3,
    required this.maNd,
    required this.password,
    required this.token,
    required this.tenCN,
    required this.sDTCN,
    required this.dCCN,
    required this.expired,
    required this.tenCTY,
    required this.dCCTY,
    required this.sDTCTY,
    required this.maCN,
    required this.mACAddress,
    required this.modelName,
  }
  );

  factory DangNhapData.fromJson(Map<String, dynamic> json) {
    return DangNhapData(
      nhanVienID: json['NhanVienID'],
      maNV: json['MaNV'],
      hoTenNV: json['HoTenNV'],
      ngaySinh: json['NgaySinh'],
      gioiTinh: json['GioiTinh'],
      quocTich: json['QuocTich'],
      soCMND: json['SoCMND'],
      ngayCap: json['NgayCap'],
      noiCap: json['NoiCap'],
      diaChi: json['DiaChi'],
      hoKhau: json['HoKhau'],
      mST: json['MST'],
      sDT: json['SDT'],
      chiNhanhID: json['ChiNhanhID'],
      phongBanID: json['PhongBanID'],
      keToan: json['KeToan'],
      admin: json['Admin'],
      hDXD: json['HDXD'],
      extra1: json['Extra1'],
      extra2: json['Extra2'],
      extra3: json['Extra3'],
      maNd: json['ma_nd'],
      password: json['Password'],
      token: json['token'],
      tenCN: json['tenCN'],
      sDTCN: json['SDT_CN'],
      dCCN: json['DC_CN'],
      expired: json['expired'],
      tenCTY: json['tenCTY'],
      dCCTY: json['DC_CTY'],
      sDTCTY: json['SDT_CTY'],
      maCN: json['maCN'],
      mACAddress: json['MAC_Address'],
      modelName: json['ModelName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NhanVienID'] = this.nhanVienID;
    data['MaNV'] = this.maNV;
    data['HoTenNV'] = this.hoTenNV;
    data['NgaySinh'] = this.ngaySinh;
    data['GioiTinh'] = this.gioiTinh;
    data['QuocTich'] = this.quocTich;
    data['SoCMND'] = this.soCMND;
    data['NgayCap'] = this.ngayCap;
    data['NoiCap'] = this.noiCap;
    data['DiaChi'] = this.diaChi;
    data['HoKhau'] = this.hoKhau;
    data['MST'] = this.mST;
    data['SDT'] = this.sDT;
    data['ChiNhanhID'] = this.chiNhanhID;
    data['PhongBanID'] = this.phongBanID;
    data['KeToan'] = this.keToan;
    data['Admin'] = this.admin;
    data['HDXD'] = this.hDXD;
    data['Extra1'] = this.extra1;
    data['Extra2'] = this.extra2;
    data['Extra3'] = this.extra3;
    data['ma_nd'] = this.maNd;
    data['Password'] = this.password;
    data['token'] = this.token;
    data['tenCN'] = this.tenCN;
    data['SDT_CN'] = this.sDTCN;
    data['DC_CN'] = this.dCCN;
    data['expired'] = this.expired;
    data['tenCTY'] = this.tenCTY;
    data['DC_CTY'] = this.dCCTY;
    data['SDT_CTY'] = this.sDTCTY;
    data['maCN'] = this.maCN;
    data['MAC_Address'] = this.mACAddress;
    data['ModelName'] = this.modelName;
    return data;
  }
}
