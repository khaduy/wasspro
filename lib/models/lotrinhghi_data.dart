import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

Future<List<LoTrinhGhiData>> fetchLoTrinhGhiDataFirst() async {
  String first0 =
      '[{"KhachHangID":0,"MaDanhBo":"0","HoTenKH":"0","DiaChiKH":"0","SDT":"0","SoNK":0,"DoiTuongID":0,"hieuDH":"0","SoSeri":"0","TieuThuKyTruoc":0,"TieuThuKyTruoc2":0,"TieuThuKyTruoc3":0,"ChiSoCu":0,"ChiSoMoi":0,"LuongTieuThu":0,"MaLT":"0","TenLT":"0","MaCN":"0","ChiSoNuocID":0,"KichCoDH":0,"NhanVienID":0,"STTThu":0,"STTGhi":0,"KyGhiID":"0","NgayGhi":"0","ThuTien_app":false,"ThanhTien_app":0,"TienThue_app":0,"TienBVMT_app":0,"TienHang_app":0,"GhiChuID":null,"GhiChu":"","LocationX":0,"LocationY":0,"Products_app":"0","NgayDongBo":"0","GiaBVMTID":0,"BatThuong":false,"HoaDonID":0,"TrangThai":0,"CSCu_DH_Thay":0,"CSMoi_DH_Thay":0,"ChuaTinhTien":false,"ThueDongHo":0,"TienThueDH_app":0,"TienVThueDH_app":0,"TienVBVMT_app":0,"TienNThai_app":0,"TienVNThai_app":0,"TienTruyThu_app":0,"TinhTrangKyTruoc":null,"NoiDung":null,"ChiSoTangGiam":0,"SoHopDong":null,"NhomDTID":0,"GhiChuKyTruoc":"","ChiNhanhID":0,"LoTrinhID":0,"URL":"0","MaDT":"0","search":"0","toadox_kh":null,"toadoy_kh":null,"TramID":0,"giaphi":0}]';
  List jsonFirst = await jsonDecode(first0);
  return jsonFirst.map((data) => LoTrinhGhiData.fromJson(data)).toList();
}

class LoTrinhGhiData {
  num khachHangID;
  String maDanhBo;
  String hoTenKH;
  String diaChiKH;
  String sDT;
  num soNK;
  num doiTuongID;
  String hieuDH;
  String soSeri;
  num tieuThuKyTruoc;
  num tieuThuKyTruoc2;
  num tieuThuKyTruoc3;
  num chiSoCu;
  num chiSoMoi;
  num luongTieuThu;
  String maLT;
  String tenLT;
  String maCN;
  num chiSoNuocID;
  num kichCoDH;
  num nhanVienID;
  num sTTThu;
  num sTTGhi;
  String kyGhiID;
  String ngayGhi;
  bool thuTienApp;
  num thanhTienApp;
  num tienThueApp;
  num tienBVMTApp;
  num tienHangApp;
  num ghiChuID;
  String ghiChu;
  num locationX;
  num locationY;
  String productsApp;
  String ngayDongBo;
  num giaBVMTID;
  bool batThuong;
  num hoaDonID;
  num trangThai;
  num cSCuDHThay;
  num cSMoiDHThay;
  bool chuaTinhTien;
  num thueDongHo;
  num tienThueDHApp;
  num tienVThueDHApp;
  num tienVBVMTApp;
  num tienNThaiApp;
  num tienVNThaiApp;
  num tienTruyThuApp;
  num tinhTrangKyTruoc;
  num noiDung;
  num chiSoTangGiam;
  num soHopDong;
  num nhomDTID;
  String ghiChuKyTruoc;
  num chiNhanhID;
  num loTrinhID;
  String uRL;
  String maDT;
  String search;
  num toadoxKh;
  num toadoyKh;
  num tramID;
  num giaphi;

  LoTrinhGhiData(
      {this.khachHangID,
      this.maDanhBo,
      this.hoTenKH,
      this.diaChiKH,
      this.sDT,
      this.soNK,
      this.doiTuongID,
      this.hieuDH,
      this.soSeri,
      this.tieuThuKyTruoc,
      this.tieuThuKyTruoc2,
      this.tieuThuKyTruoc3,
      this.chiSoCu,
      this.chiSoMoi,
      this.luongTieuThu,
      this.maLT,
      this.tenLT,
      this.maCN,
      this.chiSoNuocID,
      this.kichCoDH,
      this.nhanVienID,
      this.sTTThu,
      this.sTTGhi,
      this.kyGhiID,
      this.ngayGhi,
      this.thuTienApp,
      this.thanhTienApp,
      this.tienThueApp,
      this.tienBVMTApp,
      this.tienHangApp,
      this.ghiChuID,
      this.ghiChu,
      this.locationX,
      this.locationY,
      this.productsApp,
      this.ngayDongBo,
      this.giaBVMTID,
      this.batThuong,
      this.hoaDonID,
      this.trangThai,
      this.cSCuDHThay,
      this.cSMoiDHThay,
      this.chuaTinhTien,
      this.thueDongHo,
      this.tienThueDHApp,
      this.tienVThueDHApp,
      this.tienVBVMTApp,
      this.tienNThaiApp,
      this.tienVNThaiApp,
      this.tienTruyThuApp,
      this.tinhTrangKyTruoc,
      this.noiDung,
      this.chiSoTangGiam,
      this.soHopDong,
      this.nhomDTID,
      this.ghiChuKyTruoc,
      this.chiNhanhID,
      this.loTrinhID,
      this.uRL,
      this.maDT,
      this.search,
      this.toadoxKh,
      this.toadoyKh,
      this.tramID,
      this.giaphi});

  factory LoTrinhGhiData.fromJson(Map<String, dynamic> json) {
    // print('object: ${json["KhachHangID"]}');
    return LoTrinhGhiData(
      khachHangID: json['KhachHangID'],
      maDanhBo: json['MaDanhBo'],
      hoTenKH: json['HoTenKH'],
      diaChiKH: json['DiaChiKH'],
      sDT: json['SDT'],
      soNK: json['SoNK'],
      doiTuongID: json['DoiTuongID'],
      hieuDH: json['hieuDH'],
      soSeri: json['SoSeri'],
      tieuThuKyTruoc: json['TieuThuKyTruoc'],
      tieuThuKyTruoc2: json['TieuThuKyTruoc2'],
      tieuThuKyTruoc3: json['TieuThuKyTruoc3'],
      chiSoCu: json['ChiSoCu'],
      chiSoMoi: json['ChiSoMoi'],
      luongTieuThu: json['LuongTieuThu'],
      maLT: json['MaLT'],
      tenLT: json['TenLT'],
      maCN: json['MaCN'],
      chiSoNuocID: json['ChiSoNuocID'],
      kichCoDH: json['KichCoDH'],
      nhanVienID: json['NhanVienID'],
      sTTThu: json['STTThu'],
      sTTGhi: json['STTGhi'],
      kyGhiID: json['KyGhiID'],
      ngayGhi: json['NgayGhi'],
      thuTienApp: json['ThuTien_app'],
      thanhTienApp: json['ThanhTien_app'],
      tienThueApp: json['TienThue_app'],
      tienBVMTApp: json['TienBVMT_app'],
      tienHangApp: json['TienHang_app'],
      ghiChuID: json['GhiChuID'],
      ghiChu: json['GhiChu'],
      locationX: json['LocationX'] ?? 123,
      locationY: json['LocationY'] ?? 123,
      productsApp: json['Products_app'],
      ngayDongBo: json['NgayDongBo'],
      giaBVMTID: json['GiaBVMTID'],
      batThuong: json['BatThuong'],
      hoaDonID: json['HoaDonID'],
      trangThai: json['TrangThai'],
      cSCuDHThay: json['CSCu_DH_Thay'],
      cSMoiDHThay: json['CSMoi_DH_Thay'],
      chuaTinhTien: json['ChuaTinhTien'],
      thueDongHo: json['ThueDongHo'],
      tienThueDHApp: json['TienThueDH_app'],
      tienVThueDHApp: json['TienVThueDH_app'],
      tienVBVMTApp: json['TienVBVMT_app'],
      tienNThaiApp: json['TienNThai_app'],
      tienVNThaiApp: json['TienVNThai_app'],
      tienTruyThuApp: json['TienTruyThu_app'],
      tinhTrangKyTruoc: json['TinhTrangKyTruoc'],
      noiDung: json['NoiDung'],
      chiSoTangGiam: json['ChiSoTangGiam'],
      soHopDong: json['SoHopDong'],
      nhomDTID: json['NhomDTID'],
      ghiChuKyTruoc: json['GhiChuKyTruoc'],
      chiNhanhID: json['ChiNhanhID'],
      loTrinhID: json['LoTrinhID'],
      uRL: json['URL'],
      maDT: json['MaDT'],
      search: json['search'],
      toadoxKh: json['toadox_kh'],
      toadoyKh: json['toadoy_kh'],
      tramID: json['TramID'],
      giaphi: json['giaphi'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['KhachHangID'] = this.khachHangID;
    data['MaDanhBo'] = this.maDanhBo;
    data['HoTenKH'] = this.hoTenKH;
    data['DiaChiKH'] = this.diaChiKH;
    data['SDT'] = this.sDT;
    data['SoNK'] = this.soNK;
    data['DoiTuongID'] = this.doiTuongID;
    data['hieuDH'] = this.hieuDH;
    data['SoSeri'] = this.soSeri;
    data['TieuThuKyTruoc'] = this.tieuThuKyTruoc;
    data['TieuThuKyTruoc2'] = this.tieuThuKyTruoc2;
    data['TieuThuKyTruoc3'] = this.tieuThuKyTruoc3;
    data['ChiSoCu'] = this.chiSoCu;
    data['ChiSoMoi'] = this.chiSoMoi;
    data['LuongTieuThu'] = this.luongTieuThu;
    data['MaLT'] = this.maLT;
    data['TenLT'] = this.tenLT;
    data['MaCN'] = this.maCN;
    data['ChiSoNuocID'] = this.chiSoNuocID;
    data['KichCoDH'] = this.kichCoDH;
    data['NhanVienID'] = this.nhanVienID;
    data['STTThu'] = this.sTTThu;
    data['STTGhi'] = this.sTTGhi;
    data['KyGhiID'] = this.kyGhiID;
    data['NgayGhi'] = this.ngayGhi;
    data['ThuTien_app'] = this.thuTienApp;
    data['ThanhTien_app'] = this.thanhTienApp;
    data['TienThue_app'] = this.tienThueApp;
    data['TienBVMT_app'] = this.tienBVMTApp;
    data['TienHang_app'] = this.tienHangApp;
    data['GhiChuID'] = this.ghiChuID;
    data['GhiChu'] = this.ghiChu;
    data['LocationX'] = this.locationX;
    data['LocationY'] = this.locationY;
    data['Products_app'] = this.productsApp;
    data['NgayDongBo'] = this.ngayDongBo;
    data['GiaBVMTID'] = this.giaBVMTID;
    data['BatThuong'] = this.batThuong;
    data['HoaDonID'] = this.hoaDonID;
    data['TrangThai'] = this.trangThai;
    data['CSCu_DH_Thay'] = this.cSCuDHThay;
    data['CSMoi_DH_Thay'] = this.cSMoiDHThay;
    data['ChuaTinhTien'] = this.chuaTinhTien;
    data['ThueDongHo'] = this.thueDongHo;
    data['TienThueDH_app'] = this.tienThueDHApp;
    data['TienVThueDH_app'] = this.tienVThueDHApp;
    data['TienVBVMT_app'] = this.tienVBVMTApp;
    data['TienNThai_app'] = this.tienNThaiApp;
    data['TienVNThai_app'] = this.tienVNThaiApp;
    data['TienTruyThu_app'] = this.tienTruyThuApp;
    data['TinhTrangKyTruoc'] = this.tinhTrangKyTruoc;
    data['NoiDung'] = this.noiDung;
    data['ChiSoTangGiam'] = this.chiSoTangGiam;
    data['SoHopDong'] = this.soHopDong;
    data['NhomDTID'] = this.nhomDTID;
    data['GhiChuKyTruoc'] = this.ghiChuKyTruoc;
    data['ChiNhanhID'] = this.chiNhanhID;
    data['LoTrinhID'] = this.loTrinhID;
    data['URL'] = this.uRL;
    data['MaDT'] = this.maDT;
    data['search'] = this.search;
    data['toadox_kh'] = this.toadoxKh;
    data['toadoy_kh'] = this.toadoyKh;
    data['TramID'] = this.tramID;
    data['giaphi'] = this.giaphi;
    return data;
  }
}
