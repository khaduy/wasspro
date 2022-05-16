import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:wasspro/pages/dangnhap.dart';
import 'package:wasspro/pages/ghichiso.dart';
import 'package:wasspro/pages/hoadon.dart';
import 'package:wasspro/pages/print_pages/printing_widget.dart';
import 'package:wasspro/pages/quanlykhachhang.dart';
import 'package:wasspro/pages/sub1_pages/dsghi.dart';
import 'package:wasspro/pages/sub1_pages/dsthu.dart';
import 'package:wasspro/pages/sub1_pages/sub2.pages/camera.dart';
import 'package:wasspro/pages/sub1_pages/sub2.pages/ttkh_chthu.dart';
import 'package:wasspro/pages/sub1_pages/sub2.pages/ttkh_dathu.dart';
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
  RxString index = "".obs;
  RxString MaKH = "".obs;
  RxString imgPath = "".obs;
  RxString deviceID = "".obs;
  RxString deviceName = "".obs;
  RxString deviceType = "".obs;
  RxString deviceIsDis = "".obs;
  RxString deviceService = "".obs;
  RxString loTrinhID = "".obs;

  void add_slhd(int data) {
    slhd0.value = data;
  }

  void add_tt(int data) {
    tongtien.value = data;
  }

  void add_index(String data) {
    index.value = data;
  }

  void add_makh(String data) {
    MaKH.value = data;
  }

  void add_imgPath(String data) {
    imgPath.value = data;
  }

  void add_deviceName(String data) {
    deviceName.value = data;
  }

  void add_device(DeviceIdentifier id, String name) {
    deviceID.value = id.toString();
    deviceName.value = name;
  }

  void addLotrinhID(var data) {
    loTrinhID.value = data.toString();
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
        '/ttkhchthu': (context) => TTKH_ChThu(),
        '/ttkhdathu': (context) => TTKH_DaThu(),
        '/dsghi': (context) => DsGhi(),
        '/ttkhchghi': (context) => TTKH_ChGhi(),
        '/camera': (context) => Camera(),
        '/ttkhdaghi': (context) => TTKH_DaGhi(),
        '/prtgwg': (context) => PrintingWidget(),
      },
    );
  }
}
