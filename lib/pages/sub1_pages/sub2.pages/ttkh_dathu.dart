import 'dart:convert';
import 'dart:typed_data';

import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasspro/main.dart';

import 'package:http/http.dart' as http;
import 'package:image/image.dart' as imgs;
import 'package:wasspro/pages/print_pages/alert.dart';
import 'package:wasspro/pages/print_pages/blue_print.dart';
import 'package:wasspro/pages/print_pages/convert_tiensangchu.dart';
import 'package:wasspro/pages/print_pages/printing_widget.dart';
import 'package:wasspro/pages/print_pages/utils.dart';
import 'package:wasspro/pages/print_pages/widget_to_image.dart';

class TTKH_DaThu extends StatefulWidget {
  const TTKH_DaThu({
    Key key,
  }) : super(key: key);
  @override
  State<TTKH_DaThu> createState() => _TTKH_DaThuState();
}

class _TTKH_DaThuState extends State<TTKH_DaThu> {
  @override
  void initState() {
    super.initState();
    futureDSKHThu = fetchTTKHThu();
  }

  var HoaDonID, KhachHangID, MaKH;
  var NhanVienID, LoTrinhID, ChiNhanhID;
  var MaDanhBo, NgayThuTien, NgayThucHien;
  var LocationX, LocationY, UserToken, Loai;
  final Control ctrl = Get.find();
  Future<List> futureDSKHThu;
  Future<List> fetchTTKHThu() async {
    await getStatus();
    await getNoiDung();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List jsonResponse1 = await jsonDecode(prefs.getString("dskhthu"));
    print(
        'data: ${jsonResponse1.where((e) => e["madanhbo"].toString() == ctrl.index.value.toString()).toList()[0]}');
    var jsonRes = jsonResponse1
        .where((e) => e["madanhbo"].toString() == ctrl.index.value.toString())
        .toList()[0];
    print(jsonRes);
    mtt1 = jsonRes["m3tieuthu"];
    print('mtt: ${jsonRes["m3tieuthu"]}');

    print(jsonRes["m3tieuthu"]);
    KY = jsonRes["KyGhiID"];
    KY = KY.substring(4, 6) + "/" + KY.substring(0, 4);
    DANH_BO = jsonRes["madanhbo"];
    TEN_KH = jsonRes["HoTenKH"];
    DIACHI = jsonRes["diachi"];
    SDT = jsonRes["SDT"];
    NGAYGHI = datetime.format(DateTime.parse(jsonRes["ngayghi"]));
    HoaDonID = jsonRes["HoaDonID"];
    KhachHangID = jsonRes["KhachHangID"];
    MaKH = jsonRes["madanhbo"];
    NhanVienID = jsonRes["NhanVienID"];
    LoTrinhID = jsonRes["LoTrinhID"];
    ChiNhanhID = jsonRes["ChiNhanhID"];
    MaDanhBo = jsonRes["madanhbo"];
    togtien = money.format(jsonRes["tongtien"]);
    CSC = jsonRes["chisocu"];
    CSM = jsonRes["chisomoi"];
    await tinhTien(jsonRes["DoiTuongID"]);
    changedText(mtt1.toInt());
    return jsonResponse1
        .where((e) => e["madanhbo"].toString() == ctrl.index.value.toString())
        .toList();
  }

  var DenM3_1, DenM3_2, DenM3_3, DenM3_4;
  void tinhTien(value) async {
    final response1 = await http.post(
      Uri.parse('http://api.vnptcantho.com.vn/pntest/api/getBangGia'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "Key": "3b851f9fb412e97ec9992295ab9c3215",
        "Token": "a29c79a210968550fe54fe8d86fd27dd",
      }),
    );
    final response2 = await http.post(
      Uri.parse('http://api.vnptcantho.com.vn/pntest/api/getBangGiaDinhMuc'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "Key": "3b851f9fb412e97ec9992295ab9c3215",
        "Token": "a29c79a210968550fe54fe8d86fd27dd",
      }),
    );

    List jsonResponse2 = await jsonDecode(response2.body)["data"];
    List jsonResponse3 =
        await jsonResponse2.where((e) => e["DoiTuongID"] == value).toList();
    if (jsonResponse3.length >= 1) {
      DenM3_1 = jsonResponse3[0]["DenM3"].toInt();
    }
    if (jsonResponse3.length >= 2) {
      DenM3_2 = jsonResponse3[1]["DenM3"].toInt();
    }
    if (jsonResponse3.length >= 3) {
      DenM3_3 = jsonResponse3[2]["DenM3"].toInt();
    }
    if (jsonResponse3.length >= 4) {
      DenM3_4 = jsonResponse3[3]["DenM3"].toInt();
    }
    print(jsonResponse3.length);
    List jsonResponse1 = await jsonDecode(response1.body)["data"];
    if (jsonResponse3.length >= 1) {
      List jsonResponse4 = await jsonResponse1
          .where((e) => e["GiaID"] == jsonResponse3[0]["GiaID"])
          .toList();
      dg11 = jsonResponse4[0]["DonGia"].toInt();
      dg1 = jsonResponse4[0]["DonGia0V"].toInt();
    }
    if (jsonResponse3.length >= 2) {
      List jsonResponse5 = await jsonResponse1
          .where((e) => e["GiaID"] == jsonResponse3[1]["GiaID"])
          .toList();
      dg22 = jsonResponse5[0]["DonGia"].toInt();
      dg2 = jsonResponse5[0]["DonGia0V"].toInt();
    }
    if (jsonResponse3.length >= 3) {
      List jsonResponse6 = await jsonResponse1
          .where((e) => e["GiaID"] == jsonResponse3[2]["GiaID"])
          .toList();
      dg33 = jsonResponse6[0]["DonGia"].toInt();
      dg3 = jsonResponse6[0]["DonGia0V"].toInt();
    }
    if (jsonResponse3.length >= 4) {
      List jsonResponse7 = await jsonResponse1
          .where((e) => e["GiaID"] == jsonResponse3[3]["GiaID"])
          .toList();
      dg44 = jsonResponse7[0]["DonGia"].toInt();
      dg4 = jsonResponse7[0]["DonGia0V"].toInt();
    }
  }

  void setMoney(bool value, empList) {
    setState(() {
      if (value == true) {
        togtien = money.format(empList);
      } else {
        togtien = 0;
      }
      isChecked = value;
    });
  }

  // CHUC NANG IN
  var dg1, dg2, dg3, dg4;
  var dg11, dg22, dg33, dg44;
  var _mySelection;
  List data = List.empty();
  Future<List> getStatus() async {
    final response = await http.post(
      Uri.parse('http://api.vnptcantho.com.vn/pntest/api/getDMGhiChu'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "Key": "3b851f9fb412e97ec9992295ab9c3215",
        "Token": "a29c79a210968550fe54fe8d86fd27dd",
      }),
    );
    List jsonResponse = await jsonDecode(response.body)["data"];

    setState(() {
      data = jsonResponse;
      _mySelection = jsonResponse[0]["GhiChuID"];
    });
    return Future.delayed(const Duration(seconds: 0), () {
      return jsonResponse;
    });
  }

  var m3_1, m3_2, m3_3, m3_4;
  var dg, tt_1, tt_2, tt_3, tt_4;
  var tongTien, tienNuoc, thueTN, thueBao;
  int truonghop = 0;

  var datetime = new DateFormat("dd/MM/yyyy");
  final money = new NumberFormat("#,##0", "eu");
  void changedText(int mtt1) {
    print(mtt1);
    if (mtt1 <= 0) {
      setState(() {
        m3_1 = 0;
        truonghop = 1;
        tienNuoc = 0;
        thueTN = 0;
        tongTien = 0;
      });
    } else if (mtt1 > 0 && mtt1 <= DenM3_1) {
      setState(() {
        m3_1 = mtt1;
        truonghop = 2;
        tt_1 = money.format(m3_1 * (dg11 / 1.05));
        double tempMoney = (m3_1 * (dg11 / 1.05));
        tienNuoc = tt_1;
        thueTN = money.format(tempMoney * 5 / 100);
        tongTien = money.format(tempMoney + (tempMoney * 5 / 100));
      });
    } else if (mtt1 > DenM3_1 && mtt1 <= DenM3_1 + DenM3_2) {
      setState(() {
        m3_1 = 10;
        m3_2 = mtt1 - 10;
        truonghop = 3;
        tt_1 = money.format(m3_1 * (dg11 / 1.05));
        tt_2 = money.format(m3_2 * (dg22 / 1.05));
        double tempMoney = m3_1 * (dg11 / 1.05) + m3_2 * (dg22 / 1.05);
        tienNuoc = money.format(tempMoney);
        thueTN = money.format(tempMoney * 5 / 100);
        tongTien = money.format(tempMoney + (tempMoney * 5 / 100));
      });
    } else if (mtt1 > DenM3_1 + DenM3_2 &&
        mtt1 <= DenM3_1 + DenM3_2 + DenM3_3) {
      setState(() {
        m3_1 = 10;
        m3_2 = 10;
        m3_3 = mtt1 - 20;
        truonghop = 4;
        tt_1 = money.format(m3_1 * (dg11 / 1.05));
        tt_2 = money.format(m3_2 * (dg22 / 1.05));
        tt_3 = money.format(m3_3 * dg3);
        double tempMoney =
            m3_1 * (dg11 / 1.05) + m3_2 * (dg22 / 1.05) + m3_3 * (dg33 / 1.05);
        tienNuoc = money.format(tempMoney);
        thueTN = money.format(tempMoney * 5 / 100);
        tongTien = money.format(tempMoney + (tempMoney * 5 / 100));
      });
    } else if (mtt1 > DenM3_1 + DenM3_2 + DenM3_3) {
      setState(() {
        m3_1 = 10;
        m3_2 = 10;
        m3_3 = 10;
        m3_4 = mtt1 - 30;
        truonghop = 5;
        tt_1 = money.format(m3_1 * (dg11 / 1.05));
        tt_2 = money.format(m3_2 * (dg22 / 1.05));
        tt_3 = money.format(m3_3 * (dg33 / 1.05));
        tt_4 = money.format(m3_4 * (dg44 / 1.05));
        double tempMoney = m3_1 * (dg11 / 1.05) +
            m3_2 * (dg22 / 1.05) +
            m3_3 * (dg33 / 1.05) +
            m3_4 * (dg44 / 1.05);
        tienNuoc = money.format(tempMoney);
        thueTN = money.format(tempMoney * 5 / 100);
        tongTien = money.format(tempMoney + (tempMoney * 5 / 100));
      });
    } else {
      print("6");
    }
    setState(() {
      thueBao = 0;
    });
  }

  var togtien;
  bool isChecked = true;
  var TENCTY, DIACHICTY, HOTLINE;
  var KY, TIME, ID_KH, TEN_KH;
  var DIACHI, DANH_BO, SDT;
  var NGAYGHI, CSC, CSM, mtt1;
  var hoTenNV, sdtNV;
  Future<void> getNoiDung() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("dangnhap") == null) {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
    setState(() {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd/MM/yyyy kk:mm:ss').format(now);
      String result = (prefs.getString('dangnhap') ?? "");
      var jsonResult = json.decode(result);
      TENCTY = jsonResult["tenCTY"];
      DIACHICTY = jsonResult['DC_CTY'];
      HOTLINE = jsonResult['SDT_CTY'];
      TIME = formattedDate;
      hoTenNV = jsonResult["HoTenNV"];
      sdtNV = jsonResult["SDT"];
      UserToken = jsonResult["token"];
    });
  }

  GlobalKey key1;
  GlobalKey key2;
  Uint8List bytes1;
  Uint8List bytes2;
  BluetoothDevice dv;
  BluetoothDevice dvInfo;
  final _alertDialogBase = AlertDialogBase();
  List<ScanResult> scanResult;
  void HamIn() async {
    if (isChecked == false) {
      _alertDialogBase.showDialogThongBao(context, "Vui lòng chọn kỳ ghi!");
    } else {
      print('ID thiet bi: ${ctrl.deviceID}');
      flutterBlue.startScan(timeout: const Duration(seconds: 1));
      flutterBlue.scanResults.listen((result) {
        setState(() {
          dvInfo = result
              .where((e) => e.device.id.toString() == ctrl.deviceID.toString())
              .toList()[0]
              .device;
        });
      });
      flutterBlue.stopScan();
      showHoaDon();
    }
  }

  Future<void> showHoaDon() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thông báo'),
            content: SingleChildScrollView(
              child: SizedBox(
                  width: 280,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WidgetToImage(builder: (key) {
                        key1 = key;
                        return noiDungGB();
                      }),
                      SizedBox(height: 50),
                      WidgetToImage(builder: (key) {
                        key2 = key;
                        return noiDungBN();
                      }),
                    ],
                  )),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Biên nhận'),
                onPressed: () async {
                  bytes2 = await Utils.capture(key2);
                  printWithDevice(bytes2);
                },
              ),
            ],
          );
        });
  }

  void printWithDevice(Uint8List bytess) async {
    print('bat dau');
    await print("thiet bi: ${dvInfo}");
    final img = imgs.decodeImage(bytess);
    var thumbnail = imgs.copyResize(img, width: 320);
    await dvInfo.connect();
    final gen = Generator(PaperSize.mm58, await CapabilityProfile.load());
    final printer = BluePrint();
    printer.add(gen.feed(3));
    printer.add(gen.image(thumbnail));
    printer.add(gen.feed(3));
    await printer.printData(dvInfo);
    await dvInfo.disconnect();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Thông báo"),
          content: Text("Lưu thông tin thành công"),
          actions: <Widget>[
            new TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.pushNamed(context, '/dsthu');
              },
            ),
          ],
        );
      },
    );
    print('ket thuc');
  }

  void savePhieuThu() async {
    NgayThuTien = DateTime.now();
    var body1 = jsonEncode(<String, String>{
      "Key": "3b851f9fb412e97ec9992295ab9c3215",
      "Token": "a29c79a210968550fe54fe8d86fd27dd",
      "HoaDonID": HoaDonID.toString(),
      "KhachHangID": KhachHangID.toString(),
      "MaKH": KhachHangID.toString(),
      "NhanVienID": NhanVienID.toInt().toString(),
      "LoTrinhID": LoTrinhID.toString(),
      "ChiNhanhID": ChiNhanhID.toString(),
      "MaDanhBo": MaDanhBo.toString(),
      "NgayThuTien": NgayThuTien.toString(),
      "NgayThucHien": NgayThuTien.toString(),
      "LocationX": '0',
      "LocationY": '0',
      "UserToken": UserToken.toString(),
      "Loai": '1'
    });
    print(body1);

    final response = await http.post(
        Uri.parse('http://api.vnptcantho.com.vn/pntest/api/insertPhieuThu'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body1);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        String jsonResponse = await jsonDecode(response.body)["data"];
        print(jsonResponse);
        // Navigator.pushNamed(context, '/dsthu');
      } else {
        print('null roi');
      }
    } else {
      print('res: ${response.body}');
      throw Exception('Failed');
    }
  }

  void showThongBao() {
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thông báo'),
            content: Container(
              width: size.width * 95 / 100,
              child: Wrap(children: [
                thongBao(),
                thongBao2(),
              ]),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title:
            Text("Thông tin khách hàng", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                HamIn();
              },
              child: Image.asset("assets/icon_print.png"),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: size.height,
        child: FutureBuilder<List>(
          future: futureDSKHThu,
          builder: (context, dskh) {
            if (dskh.hasData) {
              List empList = dskh.data;
              return Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: size.height,
                    child: Wrap(
                      children: [
                        Text(
                          'Mã KH - Tên khách hàng',
                          style:
                              TextStyle(color: Colors.blue[500], fontSize: 18),
                        ),
                        TextFormField(
                          enabled: false,
                          initialValue:
                              '${empList[0]["madanhbo"]} - ${empList[0]["HoTenKH"]}',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'Địa chỉ',
                            style: TextStyle(
                              color: Colors.blue[500],
                              fontSize: 18,
                            ),
                          ),
                        ),
                        TextFormField(
                          maxLines: 2,
                          enabled: false,
                          initialValue: '${empList[0]["diachi"]}',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Row(
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      child: Container(
                                          child: Text(
                                        'Đối tượng',
                                        style: TextStyle(
                                            color: Colors.blue[500],
                                            fontSize: 18),
                                      )),
                                    ),
                                    SizedBox(
                                      child: Container(
                                        child: TextFormField(
                                          enabled: false,
                                          initialValue: '${empList[0]["MaDT"]}',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        child: Container(
                                            child: Text(
                                          'Số NK',
                                          style: TextStyle(
                                              color: Colors.blue[500],
                                              fontSize: 18),
                                        )),
                                      ),
                                      SizedBox(
                                        child: Container(
                                          child: TextFormField(
                                            enabled: false,
                                            initialValue:
                                                '${empList[0]["soNK"]}',
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      child: Container(
                                          child: Text(
                                        'Mã danh bộ',
                                        style: TextStyle(
                                            color: Colors.blue[500],
                                            fontSize: 18),
                                      )),
                                    ),
                                    SizedBox(
                                      child: Container(
                                        child: TextFormField(
                                          enabled: false,
                                          initialValue:
                                              '${empList[0]["madanhbo"]}',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: size.height,
                          padding: const EdgeInsets.all(10),
                          color: Colors.grey[300],
                          child: Text(
                            'DANH SÁCH HÓA ĐƠN',
                            style: TextStyle(
                                color: Colors.brown[500],
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 40, right: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Kỳ ghi',
                                style: TextStyle(
                                    color: Colors.blue[500], fontSize: 18),
                              ),
                              Text(
                                'Tiêu thụ',
                                style: TextStyle(
                                    color: Colors.blue[500], fontSize: 18),
                              ),
                              Text(
                                'Thành tiền',
                                style: TextStyle(
                                    color: Colors.blue[500], fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black87,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                    value: isChecked,
                                    onChanged: (bool value) {
                                      setMoney(value, empList[0]["tongtien"]);
                                    }),
                                Text(
                                  '${KY}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ],
                            ),
                            Text(
                              '${empList[0]["m3tieuthu"].toInt()}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${money.format(empList[0]["tongtien"])}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                                TextButton(
                                    onPressed: () {
                                      showThongBao();
                                    },
                                    child: Image.asset(
                                      "assets/icon_info.png",
                                      height: 30,
                                      width: 30,
                                    ))
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black87,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "",
                            ),
                            Text(
                              "",
                            ),
                            Text(
                              "Tổng cộng thanh toán",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${togtien ?? 0}',
                              style: TextStyle(color: Colors.red, fontSize: 18),
                            ),
                            Text(
                              "",
                            ),
                          ],
                        )
                      ],
                    ),
                  ));
            } else if (dskh.hasError) {
              return Container(
                  alignment: Alignment.center,
                  child: Text("Không tìm thấy dữ liệu"));
            }
            return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          },
        ),
      ),
    ));
  }

  Column noiDungGB() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${TENCTY}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              '${DIACHICTY}',
              style: TextStyle(color: Colors.black, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            Text(
              'Hotline: ${HOTLINE}',
              style: TextStyle(color: Colors.black, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'GIẤY BÁO TIỀN ĐIỆN NƯỚC KỲ ${KY}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              '(Không có giá trị thu tiền)',
              style: TextStyle(color: Colors.black, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            Text(
              'Ngày ${TIME}',
              style: TextStyle(color: Colors.black, fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'MÃ KH: ${DANH_BO}',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            Text(
              'Tên KH: ${TEN_KH}',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Text(
              'Địa chỉ: ${DIACHI}',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Text(
              'SĐT: ${SDT}',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Text(
              'Ngày ghi: ${NGAYGHI}',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ],
        ),
        Text('-------------------------------------'),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Container(
                          child: Text(
                        'CS Cũ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Container(
                            child: Text(
                          'CS Mới',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        child: Container(
                            child: Text(
                          'M3TT',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Container(
                          child: Text(
                        '${CSC}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Container(
                            child: Text(
                          '${CSM}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        child: Container(
                            child: Text(
                          '${mtt1}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Text('-------------------------------------'),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Container(
                          child: Text(
                        'M3',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Container(
                          child: Text(
                        'Đơn Giá',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      child: Container(
                          child: Text(
                        'Thành tiền',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            if (truonghop == 1) ...[
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '0',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '0',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '0',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ] else if (truonghop == 2) ...[
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${m3_1}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${money.format(dg1)}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${tt_1}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ] else if (truonghop == 3) ...[
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${m3_1}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${money.format(dg1)}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${tt_1}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${m3_2}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${money.format(dg2)}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${tt_2}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ] else if (truonghop == 4) ...[
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${m3_1}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${money.format(dg1)}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${tt_1}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${m3_2}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${money.format(dg2)}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${tt_2}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${m3_3}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${money.format(dg3)}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${tt_3}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ] else if (truonghop == 5) ...[
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${m3_1}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${money.format(dg1)}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${tt_1}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${m3_2}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${money.format(dg2)}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${tt_2}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${m3_3}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${money.format(dg3)}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${tt_3}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${m3_4}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Container(
                                  child: Text(
                                '${money.format(dg4)}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              child: Container(
                                  child: Text(
                                '${tt_4}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Text(''),
            ],
          ],
        ),
        Text('-------------------------------------'),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Container(
                          child: Text(
                        'Tiền nước:',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      )),
                    ),
                    SizedBox(
                      child: Container(
                          child: Text(
                        'Thuế TN(5%):',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      )),
                    ),
                    SizedBox(
                      child: Container(
                          child: Text(
                        'Phí nước thải:',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      )),
                    ),
                    SizedBox(
                      child: Container(
                          child: Text(
                        'Chỉ số mới',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      )),
                    ),
                    SizedBox(
                      child: Container(
                          child: Text(
                        'Thuế NT(10%):',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      )),
                    ),
                    SizedBox(
                      child: Container(
                          child: Text(
                        'Phí môi trường:',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      )),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        child: Container(
                            child: Text(
                          '${tienNuoc ?? ""}',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )),
                      ),
                      SizedBox(
                        child: Container(
                            child: Text(
                          '${thueTN ?? ""}',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )),
                      ),
                      SizedBox(
                        child: Container(
                            child: Text(
                          '${thueBao ?? ""}',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )),
                      ),
                      SizedBox(
                        child: Container(
                            child: Text(
                          '${thueBao ?? ""}',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )),
                      ),
                      SizedBox(
                        child: Container(
                            child: Text(
                          '${thueBao ?? ""}',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )),
                      ),
                      SizedBox(
                        child: Container(
                            child: Text(
                          '${thueBao ?? ""}',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Text('-------------------------------------'),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Container(
                          child: Text(
                        'Tổng tiền',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Container(
                          child: Text(
                        '${tongTien ?? ""}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Bằng chữ: ${ConvertTienSangChu.Convert_NumtoText(double.parse(tongTien).toInt().toString())}',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            Text(
              'Có khoán thêm: 0 m3',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Text('Quý khách thanh toán tại văn phòng Công ty',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                )),
            Text(
              'Nộp chậm sẽ bị phạt Nộp chậm theo quy định. Nếu không thanh toán buộc lòng chúng tôi phải ngưng cấp nước theo quy định.',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Text(
              'NV: ${hoTenNV}',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Text(
              'SĐT: ${sdtNV}',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Text(
              'Link: http://nuocsachhaugiang.com.vn',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Cảm ơn Quý khách hàng!',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column noiDungBN() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${TENCTY}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              '${DIACHICTY}',
              style: TextStyle(color: Colors.black, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            Text(
              'Hotline: ${HOTLINE}',
              style: TextStyle(color: Colors.black, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'BIÊN NHẬN THANH TOÁN TIỀN NƯỚC KỲ ${KY}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              'Ngày ${TIME}',
              style: TextStyle(color: Colors.black, fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'MÃ KH: ${DANH_BO}',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            Text(
              'Tên KH: ${TEN_KH}',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Text(
              'Địa chỉ: ${DIACHI}',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Text(
              'SĐT: ${SDT}',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Text(
              'Ngày ghi: ${NGAYGHI}',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ],
        ),
        Text('-------------------------------------'),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Container(
                          child: Text(
                        'CS Cũ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Container(
                            child: Text(
                          'CS Mới',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        child: Container(
                            child: Text(
                          'M3TT',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Container(
                          child: Text(
                        '${CSC}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Container(
                            child: Text(
                          '${CSM}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        child: Container(
                            child: Text(
                          '${mtt1}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Text('-------------------------------------'),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Container(
                          child: Text(
                        'M3',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Container(
                          child: Text(
                        'Đơn Giá',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      child: Container(
                          child: Text(
                        'Thành tiền',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            if (truonghop == 1) ...[
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '0',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '0',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '0',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ] else if (truonghop == 2) ...[
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${m3_1}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${money.format(dg1)}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${tt_1}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ] else if (truonghop == 3) ...[
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${m3_1}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${money.format(dg1)}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${tt_1}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${m3_2}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${money.format(dg2)}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${tt_2}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ] else if (truonghop == 4) ...[
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${m3_1}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${money.format(dg1)}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${tt_1}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${m3_2}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${money.format(dg2)}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${tt_2}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${m3_3}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${money.format(dg3)}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${tt_3}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ] else if (truonghop == 5) ...[
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${m3_1}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${money.format(dg1)}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${tt_1}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${m3_2}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${money.format(dg2)}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${tt_2}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${m3_3}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${money.format(dg3)}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${tt_3}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Container(
                                child: Text(
                              '${m3_4}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Container(
                                  child: Text(
                                '${money.format(dg4)}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              child: Container(
                                  child: Text(
                                '${tt_4}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Text(''),
            ],
          ],
        ),
        Text('-------------------------------------'),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Container(
                          child: Text(
                        'Tiền nước:',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      )),
                    ),
                    SizedBox(
                      child: Container(
                          child: Text(
                        'Thuế TN(5%):',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      )),
                    ),
                    SizedBox(
                      child: Container(
                          child: Text(
                        'Phí nước thải:',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      )),
                    ),
                    SizedBox(
                      child: Container(
                          child: Text(
                        'Chỉ số mới',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      )),
                    ),
                    SizedBox(
                      child: Container(
                          child: Text(
                        'Thuế NT(10%):',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      )),
                    ),
                    SizedBox(
                      child: Container(
                          child: Text(
                        'Phí môi trường:',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      )),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        child: Container(
                            child: Text(
                          '${tienNuoc ?? ""}',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )),
                      ),
                      SizedBox(
                        child: Container(
                            child: Text(
                          '${thueTN ?? ""}',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )),
                      ),
                      SizedBox(
                        child: Container(
                            child: Text(
                          '${thueBao ?? ""}',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )),
                      ),
                      SizedBox(
                        child: Container(
                            child: Text(
                          '${thueBao ?? ""}',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )),
                      ),
                      SizedBox(
                        child: Container(
                            child: Text(
                          '${thueBao ?? ""}',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )),
                      ),
                      SizedBox(
                        child: Container(
                            child: Text(
                          '${thueBao ?? ""}',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Text('-------------------------------------'),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Container(
                          child: Text(
                        'Tổng tiền',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Container(
                          child: Text(
                        '${tongTien ?? ""}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Bằng chữ: ${ConvertTienSangChu.Convert_NumtoText(double.parse(tongTien).toInt().toString())}',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            Text(
              'Có khoán thêm: 0 m3',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'NV: ${hoTenNV}',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Text(
              'SĐT: ${sdtNV}',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Text(
              'Link: http://nuocsachhaugiang.com.vn',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Cảm ơn Quý khách hàng!',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Table thongBao() {
    return Table(
      border: TableBorder.all(),
      columnWidths: {
        0: FractionColumnWidth(0.2),
        1: FractionColumnWidth(0.4),
        2: FractionColumnWidth(0.4),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        const TableRow(children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'M3',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Đơn Giá',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Thành tiền',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ]),
        if (truonghop == 1) ...[
          const TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '0',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '0',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '0',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
        ] else if (truonghop == 2) ...[
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${m3_1}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${money.format(dg1)}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${tt_1}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
        ] else if (truonghop == 3) ...[
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${m3_1}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${money.format(dg1)}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${tt_1}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${m3_2}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${money.format(dg2)}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${tt_2}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
        ] else if (truonghop == 4) ...[
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${m3_1}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${money.format(dg1)}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${tt_1}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${m3_2}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${money.format(dg2)}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${tt_2}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${m3_3}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${money.format(dg3)}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${tt_3}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
        ] else if (truonghop == 5) ...[
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${m3_1}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${money.format(dg1)}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${tt_1}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${m3_2}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${money.format(dg2)}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${tt_2}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${m3_3}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${money.format(dg3)}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${tt_3}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              Text(
                '${m3_4}',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              Text(
                '${money.format(dg4)}',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              Text(
                '${tt_4}',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ],
          ),
        ] else ...[
          TableRow(children: [
            Text('abc'),
          ])
        ],
      ],
    );
  }

  Table thongBao2() {
    return Table(
      border: TableBorder(
          horizontalInside: BorderSide(width: 1),
          verticalInside: BorderSide(width: 1),
          right: BorderSide(width: 1),
          left: BorderSide(width: 1),
          bottom: BorderSide(width: 1)),
      columnWidths: {
        0: FractionColumnWidth(0.6),
        1: FractionColumnWidth(0.4),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Tiền nước:',
              style: TextStyle(color: Colors.blueAccent[700], fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${tienNuoc ?? ""}',
              style: TextStyle(color: Colors.blueAccent[700], fontSize: 15),
            ),
          )
        ]),
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Thuế TN(5%):',
              style: TextStyle(color: Colors.blueAccent[700], fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${thueTN ?? ""}',
              style: TextStyle(color: Colors.blueAccent[700], fontSize: 15),
            ),
          )
        ]),
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Phí nước thải:',
              style: TextStyle(color: Colors.blueAccent[700], fontSize: 15),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${thueBao ?? ""}',
                style: TextStyle(color: Colors.blueAccent[700], fontSize: 15),
              ))
        ]),
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Chỉ số mới:',
              style: TextStyle(color: Colors.blueAccent[700], fontSize: 15),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${thueBao ?? ""}',
                style: TextStyle(color: Colors.blueAccent[700], fontSize: 15),
              ))
        ]),
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Thuế NT (10%):',
              style: TextStyle(color: Colors.blueAccent[700], fontSize: 15),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${thueBao ?? ""}',
                style: TextStyle(color: Colors.blueAccent[700], fontSize: 15),
              ))
        ]),
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Phí môi trường:',
              style: TextStyle(color: Colors.blueAccent[700], fontSize: 15),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${thueBao ?? ""}',
                style: TextStyle(color: Colors.blueAccent[700], fontSize: 15),
              ))
        ]),
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Tổng tiền',
              style: TextStyle(
                  color: Colors.blueAccent[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${tongTien ?? ""}',
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ])
      ],
    );
  }
}
