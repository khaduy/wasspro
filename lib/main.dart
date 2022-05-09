import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wasspro/pages/dangnhap.dart';
import 'package:wasspro/pages/ghichiso.dart';
import 'package:wasspro/pages/hoadon.dart';
import 'package:wasspro/pages/quanlykhachhang.dart';
import 'package:wasspro/pages/sub1_pages/dsghi.dart';
import 'package:wasspro/pages/sub1_pages/dsthu.dart';
import 'package:wasspro/pages/sub1_pages/sub2.pages/camera.dart';
import 'package:wasspro/pages/sub1_pages/sub2.pages/thongtinkhachhang.dart';
import 'package:wasspro/pages/sub1_pages/sub2.pages/ttkh_chghi.dart';
import 'package:wasspro/pages/sub1_pages/sub2.pages/ttkh_daghi.dart';
import 'package:wasspro/pages/thongke.dart';
import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Wasspro());
}

class Control extends GetxController {
  RxInt slhd0 = 0.obs;
  RxInt tongtien = 0.obs;
  RxInt index = 0.obs;
  RxString MaKH = "".obs;
  RxString imgPath = "".obs;
  void add_slhd(int data) {
    slhd0.value = data;
  }
  void add_tt(int data) {
    tongtien.value = data;
  }
  void add_index(int data) {
    index.value = data;
  }
  void add_makh(String data) {
    MaKH.value = data;
  }
  void add_imgPath(String data) {
    imgPath.value = data;
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
        '/ttkh': (context) => ThongTinKhachHang(),
        '/dsghi': (context) => DsGhi(),
        '/ttkhchghi': (context) => TTKH_ChGhi(),
        '/camera': (context) => Camera(),
        '/ttkhdaghi': (context) => TTKH_DaGhi(),
      },
    );
  }
}
