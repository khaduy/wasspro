import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DSKHThu {
  String hoTenKH;
  String madanhbo;
  String diachi;
  num khachHangID;
  num doiTuongID;
  num soNK;
  String tenLT;
  num tongtien0VAT;
  num tienvat;
  double tongtien;
  num soHD;
  String mauHD;
  String kyHieuHD;
  String ngayPhatHanh;
  num nhanVienID;
  String maLT;
  num loTrinhID;
  String kyGhiID;
  String tenKyghi;
  num hoaDonID;
  num sTTGhi;
  num sTTThu;
  String maCN;
  num chiNhanhID;
  String products;
  num chisocu;
  num chisomoi;
  num m3tieuthu;
  num giaBVMT;
  num tienBVMT;
  num tienVATBVMT;
  num tienNThai;
  num tienVATNThai;
  num tienThueDH;
  num tienVATThueDH;
  num tienTruyThu;
  String ngayghi;
  num chisotanggiam;
  num nhomDTID;
  String maDT;
  String search;
  String sDT;

  DSKHThu(
      {required this.hoTenKH,
      required this.madanhbo,
      required this.diachi,
      required this.khachHangID,
      required this.doiTuongID,
      required this.soNK,
      required this.tenLT,
      required this.tongtien0VAT,
      required this.tienvat,
      required this.tongtien,
      required this.soHD,
      required this.mauHD,
      required this.kyHieuHD,
      required this.ngayPhatHanh,
      required this.nhanVienID,
      required this.maLT,
      required this.loTrinhID,
      required this.kyGhiID,
      required this.tenKyghi,
      required this.hoaDonID,
      required this.sTTGhi,
      required this.sTTThu,
      required this.maCN,
      required this.chiNhanhID,
      required this.products,
      required this.chisocu,
      required this.chisomoi,
      required this.m3tieuthu,
      required this.giaBVMT,
      required this.tienBVMT,
      required this.tienVATBVMT,
      required this.tienNThai,
      required this.tienVATNThai,
      required this.tienThueDH,
      required this.tienVATThueDH,
      required this.tienTruyThu,
      required this.ngayghi,
      required this.chisotanggiam,
      required this.nhomDTID,
      required this.maDT,
      required this.search,
      required this.sDT});

  factory DSKHThu.fromJson(Map<String, dynamic> json) {
    return DSKHThu(
      hoTenKH: json['HoTenKH'] ?? "",
      madanhbo: json['madanhbo'] ?? "",
      diachi: json['diachi'] ?? "",
      khachHangID: json['KhachHangID'] ?? 0,
      doiTuongID: json['DoiTuongID'] ?? 0,
      soNK: json['soNK'] ?? 0,
      tenLT: json['tenLT'] ?? "",
      tongtien0VAT: json['tongtien0VAT'] ?? 0,
      tienvat: json['tienvat'] ?? 0,
      tongtien: json['tongtien'] ?? 0,
      soHD: json['SoHD'] ?? 0,
      mauHD: json['MauHD'] ?? "",
      kyHieuHD: json['KyHieuHD'] ?? "",
      ngayPhatHanh: json['NgayPhatHanh'] ?? "",
      nhanVienID: json['NhanVienID'] ?? 0,
      maLT: json['MaLT'] ?? "",
      loTrinhID: json['LoTrinhID'] ?? 0,
      kyGhiID: json['KyGhiID'] ?? "",
      tenKyghi: json['ten_kyghi'] ?? "",
      hoaDonID: json['HoaDonID'] ?? 0,
      sTTGhi: json['STTGhi'] ?? 0,
      sTTThu: json['STTThu'] ?? 0,
      maCN: json['MaCN'] ?? "",
      chiNhanhID: json['ChiNhanhID'] ?? 0,
      products: json['products'] ?? "",
      chisocu: json['chisocu'] ?? 0,
      chisomoi: json['chisomoi'] ?? 0,
      m3tieuthu: json['m3tieuthu'] ?? 0,
      giaBVMT: json['giaBVMT'] ?? 0,
      tienBVMT: json['TienBVMT'] ?? 0,
      tienVATBVMT: json['TienVAT_BVMT'] ?? 0,
      tienNThai: json['TienNThai'] ?? 0,
      tienVATNThai: json['TienVAT_NThai'] ?? 0,
      tienThueDH: json['TienThueDH'] ?? 0,
      tienVATThueDH: json['TienVAT_ThueDH'] ?? 0,
      tienTruyThu: json['TienTruyThu'] ?? 0,
      ngayghi: json['ngayghi'] ?? "",
      chisotanggiam: json['chisotanggiam'] ?? 0,
      nhomDTID: json['NhomDTID'] ?? 0,
      maDT: json['MaDT'] ?? "",
      search: json['search'] ?? "",
      sDT: json['SDT'] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HoTenKH'] = this.hoTenKH;
    data['madanhbo'] = this.madanhbo;
    data['diachi'] = this.diachi;
    data['KhachHangID'] = this.khachHangID;
    data['DoiTuongID'] = this.doiTuongID;
    data['soNK'] = this.soNK;
    data['tenLT'] = this.tenLT;
    data['tongtien0VAT'] = this.tongtien0VAT;
    data['tienvat'] = this.tienvat;
    data['tongtien'] = this.tongtien;
    data['SoHD'] = this.soHD;
    data['MauHD'] = this.mauHD;
    data['KyHieuHD'] = this.kyHieuHD;
    data['NgayPhatHanh'] = this.ngayPhatHanh;
    data['NhanVienID'] = this.nhanVienID;
    data['MaLT'] = this.maLT;
    data['LoTrinhID'] = this.loTrinhID;
    data['KyGhiID'] = this.kyGhiID;
    data['ten_kyghi'] = this.tenKyghi;
    data['HoaDonID'] = this.hoaDonID;
    data['STTGhi'] = this.sTTGhi;
    data['STTThu'] = this.sTTThu;
    data['MaCN'] = this.maCN;
    data['ChiNhanhID'] = this.chiNhanhID;
    data['products'] = this.products;
    data['chisocu'] = this.chisocu;
    data['chisomoi'] = this.chisomoi;
    data['m3tieuthu'] = this.m3tieuthu;
    data['giaBVMT'] = this.giaBVMT;
    data['TienBVMT'] = this.tienBVMT;
    data['TienVAT_BVMT'] = this.tienVATBVMT;
    data['TienNThai'] = this.tienNThai;
    data['TienVAT_NThai'] = this.tienVATNThai;
    data['TienThueDH'] = this.tienThueDH;
    data['TienVAT_ThueDH'] = this.tienVATThueDH;
    data['TienTruyThu'] = this.tienTruyThu;
    data['ngayghi'] = this.ngayghi;
    data['chisotanggiam'] = this.chisotanggiam;
    data['NhomDTID'] = this.nhomDTID;
    data['MaDT'] = this.maDT;
    data['search'] = this.search;
    data['SDT'] = this.sDT;
    return data;
  }
}
