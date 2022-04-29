import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wasspro/pages/dangnhap.dart';
import 'package:wasspro/pages/ghichiso.dart';
import 'package:wasspro/pages/hoadon.dart';
import 'package:wasspro/pages/quanlykhachhang.dart';
import 'package:wasspro/pages/sub1_pages/dsthu.dart';
import 'package:wasspro/pages/sub1_pages/sub2.pages/thongtinkhachhang.dart';
import 'package:wasspro/pages/thongke.dart';

void main() async {
  runApp(Wasspro());
}

class Control extends GetxController {
  RxInt slhd0 = 0.obs;
  RxInt tongtien = 0.obs;
  RxInt index = 0.obs;
  void add_slhd(int data) {
    slhd0.value = data;
  }

  void add_tt(int data) {
    tongtien.value = data;
  }
  void add_index(int data) {
    index.value = data;
  }
}

class Wasspro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wasspro HGI',
      initialRoute: '/',
      routes: {
        '/': (context) => DangNhap(),
        '/thongke': (context) => ThongKe(),
        '/hoadon': (context) => HoaDon(),
        '/ghichiso': (context) => GhiChiSo(),
        '/qlykh': (context) => QLKhachHang(),
        '/dsthu': (context) => DsThu(),
        '/ttkh': (context) => ThongTinKhachHang()
      },
    );
  }
}
