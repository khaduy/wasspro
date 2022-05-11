class DSKHGhi {
  var khachHangID;
  var maDanhBo;
  var hoTenKH;
  var diaChiKH;
  var sDT;
  var soNK;
  var doiTuongID;
  var hieuDH;
  var soSeri;
  var tieuThuKyTruoc;
  var tieuThuKyTruoc2;
  var tieuThuKyTruoc3;
  var chiSoCu;
  var chiSoMoi;
  var luongTieuThu;
  var maLT;
  var tenLT;
  var maCN;
  var chiSoNuocID;
  var kichCoDH;
  var nhanVienID;
  var sTTThu;
  var sTTGhi;
  var kyGhiID;
  var ngayGhi;
  var thuTienApp;
  var thanhTienApp;
  var tienThueApp;
  var tienBVMTApp;
  var tienHangApp;
  var ghiChuID;
  var ghiChu;
  var locationX;
  var locationY;
  var productsApp;
  var ngayDongBo;
  var giaBVMTID;
  var batThuong;
  var hoaDonID;
  var trangThai;
  var cSCuDHThay;
  var cSMoiDHThay;
  var chuaTinhTien;
  var thueDongHo;
  var tienThueDHApp;
  var tienVThueDHApp;
  var tienVBVMTApp;
  var tienNThaiApp;
  var tienVNThaiApp;
  var tienTruyThuApp;
  var tinhTrangKyTruoc;
  var noiDung;
  var chiSoTangGiam;
  var soHopDong;
  var nhomDTID;
  var ghiChuKyTruoc;
  var chiNhanhID;
  var loTrinhID;
  var uRL;
  var maDT;
  var search;
  var toadoxKh;
  var toadoyKh;
  var tramID;
  var giaphi;

  DSKHGhi(
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

  factory DSKHGhi.fromJson(Map<String, dynamic> json) {
    return DSKHGhi(
      khachHangID: json["KhachHangID"] ?? "",
      maDanhBo: json["MaDanhBo"] ?? "",
      hoTenKH: json["HoTenKH"] ?? "",
      diaChiKH: json["DiaChiKH"] ?? "",
      sDT: json["SDT"] ?? "",
      soNK: json["SoNK"] ?? "",
      doiTuongID: json["DoiTuongID"] ?? "",
      hieuDH: json["hieuDH"] ?? "",
      soSeri: json["SoSeri"] ?? "",
      tieuThuKyTruoc: json["TieuThuKyTruoc"] ?? "",
      tieuThuKyTruoc2: json["TieuThuKyTruoc2"] ?? "",
      tieuThuKyTruoc3: json["TieuThuKyTruoc3"] ?? "",
      chiSoCu: json["ChiSoCu"] ?? "",
      chiSoMoi: json["ChiSoMoi"] ?? "",
      luongTieuThu: json["LuongTieuThu"] ?? "",
      maLT: json["MaLT"] ?? "",
      tenLT: json["TenLT"] ?? "",
      maCN: json["MaCN"] ?? "",
      chiSoNuocID: json["ChiSoNuocID"] ?? "",
      kichCoDH: json["KichCoDH"] ?? "",
      nhanVienID: json["NhanVienID"] ?? "",
      sTTThu: json["STTThu"] ?? "",
      sTTGhi: json["STTGhi"] ?? "",
      kyGhiID: json["KyGhiID"] ?? "",
      ngayGhi: json["NgayGhi"] ?? "",
      thuTienApp: json["ThuTien_app"] ?? "",
      thanhTienApp: json["ThanhTien_app"] ?? "",
      tienThueApp: json["TienThue_app"] ?? "",
      tienBVMTApp: json["TienBVMT_app"] ?? "",
      tienHangApp: json["TienHang_app"] ?? "",
      ghiChuID: json["GhiChuID"] ?? "",
      ghiChu: json["GhiChu"] ?? "",
      locationX: json["LocationX"] ?? "",
      locationY: json["LocationY"] ?? "",
      productsApp: json["Products_app"] ?? "",
      ngayDongBo: json["NgayDongBo"] ?? "",
      giaBVMTID: json["GiaBVMTID"] ?? "",
      batThuong: json["BatThuong"] ?? "",
      hoaDonID: json["HoaDonID"] ?? "",
      trangThai: json["TrangThai"] ?? "",
      cSCuDHThay: json["CSCu_DH_Thay"] ?? "",
      cSMoiDHThay: json["CSMoi_DH_Thay"] ?? "",
      chuaTinhTien: json["ChuaTinhTien"] ?? "",
      thueDongHo: json["ThueDongHo"] ?? "",
      tienThueDHApp: json["TienThueDH_app"] ?? "",
      tienVThueDHApp: json["TienVThueDH_app"] ?? "",
      tienVBVMTApp: json["TienVBVMT_app"] ?? "",
      tienNThaiApp: json["TienNThai_app"] ?? "",
      tienVNThaiApp: json["TienVNThai_app"] ?? "",
      tienTruyThuApp: json["TienTruyThu_app"] ?? "",
      tinhTrangKyTruoc: json["TinhTrangKyTruoc"] ?? "",
      noiDung: json["NoiDung"] ?? "",
      chiSoTangGiam: json["ChiSoTangGiam"] ?? "",
      soHopDong: json["SoHopDong"] ?? "",
      nhomDTID: json["NhomDTID"] ?? "",
      ghiChuKyTruoc: json["GhiChuKyTruoc"] ?? "",
      chiNhanhID: json["ChiNhanhID"] ?? "",
      loTrinhID: json["LoTrinhID"] ?? "",
      uRL: json["URL"] ?? "",
      maDT: json["MaDT"] ?? "",
      search: json["search"] ?? "",
      toadoxKh: json["toadox_kh"] ?? "",
      toadoyKh: json["toadoy_kh"] ?? "",
      tramID: json["TramID"] ?? "",
      giaphi: json["giaphi"] ?? "",
    );
  }
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['KhachHangID'] = this.khachHangID;
  //   data['MaDanhBo'] = this.maDanhBo;
  //   data['HoTenKH'] = this.hoTenKH;
  //   data['DiaChiKH'] = this.diaChiKH;
  //   data['SDT'] = this.sDT;
  //   data['SoNK'] = this.soNK;
  //   data['DoiTuongID'] = this.doiTuongID;
  //   data['hieuDH'] = this.hieuDH;
  //   data['SoSeri'] = this.soSeri;
  //   data['TieuThuKyTruoc'] = this.tieuThuKyTruoc;
  //   data['TieuThuKyTruoc2'] = this.tieuThuKyTruoc2;
  //   data['TieuThuKyTruoc3'] = this.tieuThuKyTruoc3;
  //   data['ChiSoCu'] = this.chiSoCu;
  //   data['ChiSoMoi'] = this.chiSoMoi;
  //   data['LuongTieuThu'] = this.luongTieuThu;
  //   data['MaLT'] = this.maLT;
  //   data['TenLT'] = this.tenLT;
  //   data['MaCN'] = this.maCN;
  //   data['ChiSoNuocID'] = this.chiSoNuocID;
  //   data['KichCoDH'] = this.kichCoDH;
  //   data['NhanVienID'] = this.nhanVienID;
  //   data['STTThu'] = this.sTTThu;
  //   data['STTGhi'] = this.sTTGhi;
  //   data['KyGhiID'] = this.kyGhiID;
  //   data['NgayGhi'] = this.ngayGhi;
  //   data['ThuTien_app'] = this.thuTienApp;
  //   data['ThanhTien_app'] = this.thanhTienApp;
  //   data['TienThue_app'] = this.tienThueApp;
  //   data['TienBVMT_app'] = this.tienBVMTApp;
  //   data['TienHang_app'] = this.tienHangApp;
  //   data['GhiChuID'] = this.ghiChuID;
  //   data['GhiChu'] = this.ghiChu;
  //   data['LocationX'] = this.locationX;
  //   data['LocationY'] = this.locationY;
  //   data['Products_app'] = this.productsApp;
  //   data['NgayDongBo'] = this.ngayDongBo;
  //   data['GiaBVMTID'] = this.giaBVMTID;
  //   data['BatThuong'] = this.batThuong;
  //   data['HoaDonID'] = this.hoaDonID;
  //   data['TrangThai'] = this.trangThai;
  //   data['CSCu_DH_Thay'] = this.cSCuDHThay;
  //   data['CSMoi_DH_Thay'] = this.cSMoiDHThay;
  //   data['ChuaTinhTien'] = this.chuaTinhTien;
  //   data['ThueDongHo'] = this.thueDongHo;
  //   data['TienThueDH_app'] = this.tienThueDHApp;
  //   data['TienVThueDH_app'] = this.tienVThueDHApp;
  //   data['TienVBVMT_app'] = this.tienVBVMTApp;
  //   data['TienNThai_app'] = this.tienNThaiApp;
  //   data['TienVNThai_app'] = this.tienVNThaiApp;
  //   data['TienTruyThu_app'] = this.tienTruyThuApp;
  //   data['TinhTrangKyTruoc'] = this.tinhTrangKyTruoc;
  //   data['NoiDung'] = this.noiDung;
  //   data['ChiSoTangGiam'] = this.chiSoTangGiam;
  //   data['SoHopDong'] = this.soHopDong;
  //   data['NhomDTID'] = this.nhomDTID;
  //   data['GhiChuKyTruoc'] = this.ghiChuKyTruoc;
  //   data['ChiNhanhID'] = this.chiNhanhID;
  //   data['LoTrinhID'] = this.loTrinhID;
  //   data['URL'] = this.uRL;
  //   data['MaDT'] = this.maDT;
  //   data['search'] = this.search;
  //   data['toadox_kh'] = this.toadoxKh;
  //   data['toadoy_kh'] = this.toadoyKh;
  //   data['TramID'] = this.tramID;
  //   data['giaphi'] = this.giaphi;
  //   return data;
  // }

}
