import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

class DangNhapData {
  double nhanVienID;
  String maNV;
  String hoTenNV;
  String ngaySinh;
  bool gioiTinh;
  String quocTich;
  String soCMND;
  String ngayCap;
  String noiCap;
  String diaChi;
  String hoKhau;
  String mST;
  String sDT;
  double chiNhanhID;
  String phongBanID;
  String keToan;
  String admin;
  String hDXD;
  String extra1;
  String extra2;
  String extra3;
  String maNd;
  String password;
  String token;
  String tenCN;
  String sDTCN;
  String dCCN;
  String expired;
  String tenCTY;
  String dCCTY;
  String sDTCTY;
  String maCN;
  String mACAddress;
  String modelName;

  DangNhapData(
    {
    this.nhanVienID,
    this.maNV,
    this.hoTenNV,
    this.ngaySinh,
    this.gioiTinh,
    this.quocTich,
    this.soCMND,
    this.ngayCap,
    this.noiCap,
    this.diaChi,
    this.hoKhau,
    this.mST,
    this.sDT,
    this.chiNhanhID,
    this.phongBanID,
    this.keToan,
    this.admin,
    this.hDXD,
    this.extra1,
    this.extra2,
    this.extra3,
    this.maNd,
    this.password,
    this.token,
    this.tenCN,
    this.sDTCN,
    this.dCCN,
    this.expired,
    this.tenCTY,
    this.dCCTY,
    this.sDTCTY,
    this.maCN,
    this.mACAddress,
    this.modelName,
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
