import 'dart:convert';
import 'dart:io' as Io;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasspro/main.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:wasspro/pages/print_pages/alert.dart';
import 'package:wasspro/pages/sub1_pages/sub2.pages/camera.dart';

class TTKH_ChGhi extends StatefulWidget {
  const TTKH_ChGhi({Key key}) : super(key: key);
  @override
  State<TTKH_ChGhi> createState() => _TTKH_ChGhiState();
}

class _TTKH_ChGhiState extends State<TTKH_ChGhi> {
  final Control ctrl = Get.find();
  @override
  void initState() {
    super.initState();
    futureDSKHGhi = getData();
    getStatus();
  }

  var ki1, ki2, ki3;
  var batthuong;
  var KY;
  var ChiSoNuocID, KhachHangID;
  var ChiSoMoi, LuongTieuThu;
  var TienHang, TienThue, TienBVMT;
  var ThanhTien, ThuTien, GhiChuID;
  var Notes, BatThuong, NgayGhi;
  var NhanVienID, MaNV, TienThueDH;
  var TienVThueDH, TienVBVMT, TienNThai;
  var TienVNThai, TienTruyThu, DiaChi;
  var LoTrinhID, HinhAnh, UserToken;
  var CSMoi_DHThay, CSCu_DHThay;
  List empList = [];
  Future<List> futureDSKHGhi;
  Future<List> getData() async {
    final response1 = await http.post(
      Uri.parse('http://api.vnptcantho.com.vn/pntest/api/getBatThuong'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "Key": "3b851f9fb412e97ec9992295ab9c3215",
        "Token": "a29c79a210968550fe54fe8d86fd27dd",
      }),
    );
    var jsonRes1 = await jsonDecode(response1.body)["data"][0]["soluong"];
    batthuong = jsonRes1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List jsonResponse = await jsonDecode(prefs.getString("dskhghi") ?? "");
    var jsonRes = jsonResponse
        .where((e) => e["MaDanhBo"].toString() == ctrl.MaKH.value.toString())
        .toList()[0];
    print(jsonResponse
        .where((e) => e["MaDanhBo"].toString() == ctrl.MaKH.value.toString())
        .toList());
    ki1 = jsonRes["TieuThuKyTruoc"];
    ki2 = jsonRes["TieuThuKyTruoc2"];
    ki3 = jsonRes["TieuThuKyTruoc3"];
    KY = jsonRes["KyGhiID"];
    KY = KY.substring(4, 6) + "/" + KY.substring(0, 4);
    ChiSoNuocID = jsonRes["ChiSoNuocID"];
    KhachHangID = jsonRes["KhachHangID"];
    TienBVMT = jsonRes["TienBVMT_app"];
    ThuTien = jsonRes["ThuTien_app"];
    TienThueDH = jsonRes["TienThueDH_app"];
    TienVThueDH = jsonRes["TienVThueDH_app"];
    TienVBVMT = jsonRes["TienVBVMT_app"];
    TienNThai = jsonRes["TienNThai_app"];
    TienVNThai = jsonRes["TienVNThai_app"];
    TienTruyThu = jsonRes["TienTruyThu_app"];
    DiaChi = jsonRes["DiaChiKH"];
    LoTrinhID = jsonRes["LoTrinhID"];

    return Future.delayed(const Duration(seconds: 1), () {
      return jsonResponse
          .where((e) => e["MaDanhBo"].toString() == ctrl.MaKH.value.toString())
          .toList();
    });
  }

  Io.File imageFile;
  void _getFromCamera() async {
    XFile pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    setState(() {
      imageFile = Io.File(pickedFile.path);
    });
  }

  var dg1, dg2, dg3, dg4;
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

    List jsonResponse1 = await jsonDecode(response1.body)["data"];
    dg1 = jsonResponse1[0]["DonGia0V"].toInt();
    dg2 = jsonResponse1[1]["DonGia0V"].toInt();
    dg3 = jsonResponse1[2]["DonGia0V"].toInt();
    dg4 = jsonResponse1[3]["DonGia0V"].toInt();
    setState(() {
      data = jsonResponse;
      _mySelection = jsonResponse[0]["GhiChuID"];
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String result = (prefs.getString('dangnhap') ?? "");
    var jsonResult = json.decode(result);
    print(jsonResult);
    NhanVienID = jsonResult["NhanVienID"];
    MaNV = jsonResult["MaNV"];
    UserToken = jsonResult["token"];
    return Future.delayed(const Duration(seconds: 1), () {
      return jsonResponse;
    });
  }

  var myCtrl = TextEditingController();
  var mtt;
  var m3_1, m3_2, m3_3, m3_4;
  var dg, tt_1, tt_2, tt_3, tt_4;
  var tongTien, tienNuoc, thueTN, thueBao;
  int truonghop = 0;
  int csmInt = 0;
  int csc = 0;
  var csm1;
  final money = new NumberFormat("#,##0", "eu");
  void changedText(String value, empList) {
    csm1 = value;
    csc = empList.toInt();
    int temp = 0;
    if (value == "") {
      setState(() {
        mtt = "";
        m3_1 = "";
      });
    } else {
      csmInt = int.parse(value);
      temp = csmInt - csc;
      if (temp <= 0) {
        setState(() {
          mtt = temp;
          m3_1 = 0;
          truonghop = 1;
          tienNuoc = 0;
          thueTN = 0;
          tongTien = 0;
        });
      } else if (temp > 0 && temp <= 10) {
        setState(() {
          mtt = temp;
          m3_1 = temp;
          truonghop = 2;
          tt_1 = money.format(m3_1 * dg1);
          int tempMoney = (m3_1 * dg1);
          tienNuoc = tt_1;
          thueTN = money.format(tempMoney * 5 / 100);
          tongTien = money.format(tempMoney + (tempMoney * 5 / 100));
        });
      } else if (temp > 10 && temp <= 20) {
        setState(() {
          mtt = temp;
          m3_1 = 10;
          m3_2 = temp - 10;
          truonghop = 3;
          tt_1 = money.format(m3_1 * dg1);
          tt_2 = money.format(m3_2 * dg2);
          int tempMoney = m3_1 * dg1 + m3_2 * dg2;
          tienNuoc = money.format(tempMoney);
          thueTN = money.format(tempMoney * 5 / 100);
          tongTien = money.format(tempMoney + (tempMoney * 5 / 100));
        });
      } else if (temp > 20 && temp <= 30) {
        setState(() {
          mtt = temp;
          m3_1 = 10;
          m3_2 = 10;
          m3_3 = temp - 20;
          truonghop = 4;
          tt_1 = money.format(m3_1 * dg1);
          tt_2 = money.format(m3_2 * dg2);
          tt_3 = money.format(m3_3 * dg3);
          int tempMoney = m3_1 * dg1 + m3_2 * dg2 + m3_3 * dg3;
          tienNuoc = money.format(tempMoney);
          thueTN = money.format(tempMoney * 5 / 100);
          tongTien = money.format(tempMoney + (tempMoney * 5 / 100));
        });
      } else if (temp > 30) {
        setState(() {
          mtt = temp;
          m3_1 = 10;
          m3_2 = 10;
          m3_3 = 10;
          m3_4 = temp - 30;
          truonghop = 5;
          tt_1 = money.format(m3_1 * dg1);
          tt_2 = money.format(m3_2 * dg2);
          tt_3 = money.format(m3_3 * dg3);
          tt_4 = money.format(m3_4 * dg4);
          int tempMoney = m3_1 * dg1 + m3_2 * dg2 + m3_3 * dg3 + m3_4 * dg4;
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
  }

  final _alertDialogBase = AlertDialogBase();
  void checkSave() {
    if (mtt == null || mtt == '') {
      _alertDialogBase.showDialogThongBao(context, "Chưa cập nhật chỉ số mới");
    } else if (mtt < 0) {
      _alertDialogBase.showDialogThongBao(context, "Chỉ số mới không hợp lệ");
    } else {
      double TB = (ki1 + ki2 + ki3) / 3;
      double checkBT = (ki1 + ki2 + ki3) / 3 + batthuong;
      double mttDouble = mtt.toDouble();
      double mtt2 = mttDouble - TB;
      print(TB);
      print(mttDouble);
      if (mttDouble > checkBT) {
        BatThuong = true;
        Fluttertoast.showToast(
            msg:
                'Mức tiêu thụ ${mtt2.toInt()} chênh lệch hơn ${batthuong.toInt()} m3',
            fontSize: 18,
            gravity: ToastGravity.BOTTOM);
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Thông báo"),
              content: const Text('Bạn có chắc chắn lưu những thông tin này!'),
              actions: <Widget>[
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    saveData();
                  },
                ),
              ],
            );
          },
        );
      } else {
        BatThuong = false;
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Thông báo"),
              content: const Text('Bạn có chắc chắn lưu những thông tin này!'),
              actions: <Widget>[
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    saveData();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  void saveData() async {
    NgayGhi = DateTime.now();
    var body1 = jsonEncode(<String, String>{
      "Key": "3b851f9fb412e97ec9992295ab9c3215",
      "Token": "a29c79a210968550fe54fe8d86fd27dd",
      "ChiSoNuocID": ChiSoNuocID.toString(),
      "KhachHangID": KhachHangID.toString(),
      "ChiSoMoi": csm1.toString(),
      "LuongTieuThu": mtt.toString(),
      "TienHang": tienNuoc,
      "TienThue": thueTN,
      "TienBVMT": TienBVMT.toString(),
      "ThanhTien": tongTien.toString(),
      "ThuTien": 'false',
      "Product":
          "<Products><Product><ProdName>GIA1AB</ProdName><ProdQuantity>10.0</ProdQuantity><ProdPrice>7470.0000</ProdPrice><Amount>74704.8000</Amount><ProdPriceV>7844.0000</ProdPriceV><AmountV>78440.0000</AmountV></Product><Product><ProdName>GIA2AB</ProdName><ProdQuantity>8.0</ProdQuantity><ProdPrice>9338.0000</ProdPrice><Amount>74704.8000</Amount><ProdPriceV>9805.0000</ProdPriceV><AmountV>78440.0000</AmountV></Product></Products>",
      "GhiChuID": GhiChuID.toString(),
      "Notes": Notes.toString(),
      "BatThuong": BatThuong.toString(),
      "LocationX": '0',
      "LocationY": '0',
      "NgayGhi": NgayGhi.toString(),
      "NgayDongBo": NgayGhi.toString(),
      "NhanVienID": NhanVienID.toString(),
      "MaNV": MaNV.toString(),
      "TienThueDH": TienThueDH.toString(),
      "TienVThueDH": TienVThueDH.toString(),
      "TienVBVMT": TienVBVMT.toString(),
      "TienNThai": TienNThai.toString(),
      "TienVNThai": TienVNThai.toString(),
      "TienTruyThu": TienTruyThu.toString(),
      "DiaChi": DiaChi.toString(),
      "LoTrinhID": LoTrinhID.toString(),
      "HinhAnh": null,
      "UserToken": UserToken.toString(),
      "CSMoi_DHThay": '0',
      "CSCu_DHThay": '0'
    });
    print(body1);

    final response = await http.post(
        Uri.parse('http://api.vnptcantho.com.vn/pntest/api/updateChiSoNuoc'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body1);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        List jsonResponse = await jsonDecode(response.body)["data"];
        String respString1 = await jsonEncode(jsonResponse);
        print(jsonResponse);
        print(respString1);
      } else {
        print('null roi');
      }
    } else {
      print('res: ${response.body}');
      throw Exception('Failed');
    }
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
                checkSave();
              },
              child: Image.asset("assets/icon_save.png"),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: size.height,
        child: FutureBuilder<List>(
          future: futureDSKHGhi,
          builder: (ctx, dskh) {
            if (dskh.hasData) {
              empList = dskh.data;
              return ListView.builder(
                  itemCount: empList.length,
                  itemBuilder: (ctx, i) {
                    return Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 0, bottom: 20),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Container(
                                                child: Text(
                                              'Kỳ ghi',
                                              style: TextStyle(
                                                  color: Colors.blue[500],
                                                  fontSize: 15),
                                            )),
                                          ),
                                          SizedBox(
                                            child: Container(
                                              child: TextFormField(
                                                enabled: false,
                                                initialValue: '${KY}',
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                'Ngày ghi',
                                                style: TextStyle(
                                                    color: Colors.blue[500],
                                                    fontSize: 15),
                                              )),
                                            ),
                                            SizedBox(
                                              child: Container(
                                                child: TextFormField(
                                                  enabled: false,
                                                  initialValue:
                                                      '${empList[i]["NgayGhi"] ?? ""}',
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Container(
                                                child: Text(
                                              'Mã danh bộ',
                                              style: TextStyle(
                                                  color: Colors.blue[500],
                                                  fontSize: 15),
                                            )),
                                          ),
                                          SizedBox(
                                            child: Container(
                                              child: TextFormField(
                                                enabled: false,
                                                initialValue:
                                                    '${empList[i]["MaDanhBo"]}',
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                'Mã KH - Tên khách hàng',
                                style: TextStyle(
                                    color: Colors.blue[500], fontSize: 15),
                              ),
                              TextFormField(
                                enabled: false,
                                initialValue:
                                    '${empList[i]["MaDanhBo"]} - ${empList[i]["HoTenKH"]}',
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'Địa chỉ',
                                  style: TextStyle(
                                    color: Colors.blue[500],
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              TextFormField(
                                maxLines: 2,
                                enabled: false,
                                initialValue: '${empList[i]["DiaChiKH"]}',
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Container(
                                                child: Text(
                                              'Điện thoại',
                                              style: TextStyle(
                                                  color: Colors.blue[500],
                                                  fontSize: 15),
                                            )),
                                          ),
                                          SizedBox(
                                            child: Container(
                                              child: TextFormField(
                                                enabled: false,
                                                initialValue:
                                                    '${empList[i]["SDT"] ?? ""}',
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                'Đối tượng',
                                                style: TextStyle(
                                                    color: Colors.blue[500],
                                                    fontSize: 15),
                                              )),
                                            ),
                                            SizedBox(
                                              child: Container(
                                                child: TextFormField(
                                                  enabled: false,
                                                  initialValue:
                                                      '${empList[i]["MaDT"]}',
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
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
                                                  fontSize: 15),
                                            )),
                                          ),
                                          SizedBox(
                                            child: Container(
                                              child: TextFormField(
                                                enabled: false,
                                                initialValue:
                                                    '${empList[i]["SoNK"]}',
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Container(
                                                child: Text(
                                              'Hiệu đồng hồ',
                                              style: TextStyle(
                                                  color: Colors.blue[500],
                                                  fontSize: 15),
                                            )),
                                          ),
                                          SizedBox(
                                            child: Container(
                                              child: TextFormField(
                                                enabled: false,
                                                initialValue:
                                                    '${empList[i]["hieuDH"]}',
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                'Seri đồng hồ',
                                                style: TextStyle(
                                                    color: Colors.blue[500],
                                                    fontSize: 15),
                                              )),
                                            ),
                                            SizedBox(
                                              child: Container(
                                                child: TextFormField(
                                                  enabled: false,
                                                  initialValue:
                                                      '${empList[i]["SoSeri"]}',
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // NOI DUNG CHI TIET
                              Container(
                                width: size.height,
                                padding: const EdgeInsets.all(10),
                                color: Colors.grey[300],
                                child: Text(
                                  'NỘI DUNG CHI TIẾT',
                                  style: TextStyle(
                                      color: Colors.brown[500],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Container(
                                                child: Text(
                                              'Trước 1 tháng',
                                              style: TextStyle(
                                                  color: Colors.blue[500],
                                                  fontSize: 15),
                                            )),
                                          ),
                                          SizedBox(
                                            child: Container(
                                              child: TextFormField(
                                                enabled: false,
                                                initialValue:
                                                    '${empList[i]["TieuThuKyTruoc"]}',
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                'Trước 2 tháng',
                                                style: TextStyle(
                                                    color: Colors.blue[500],
                                                    fontSize: 15),
                                              )),
                                            ),
                                            SizedBox(
                                              child: Container(
                                                child: TextFormField(
                                                  enabled: false,
                                                  initialValue:
                                                      '${empList[i]["TieuThuKyTruoc2"]}',
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                'Trước 3 tháng',
                                                style: TextStyle(
                                                    color: Colors.blue[500],
                                                    fontSize: 15),
                                              )),
                                            ),
                                            SizedBox(
                                              child: Container(
                                                child: TextFormField(
                                                  enabled: false,
                                                  initialValue:
                                                      '${empList[i]["TieuThuKyTruoc3"]}',
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Container(
                                                child: Text(
                                              'Chỉ số cũ',
                                              style: TextStyle(
                                                  color: Colors.blue[500],
                                                  fontSize: 15),
                                            )),
                                          ),
                                          SizedBox(
                                            child: Container(
                                              child: TextFormField(
                                                enabled: false,
                                                initialValue:
                                                    '${empList[i]["ChiSoCu"].toInt()}',
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                'Chỉ số mới',
                                                style: TextStyle(
                                                    color: Colors.blue[500],
                                                    fontSize: 15),
                                              )),
                                            ),
                                            SizedBox(
                                              child: Container(
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(r'[0-9]'))
                                                  ],
                                                  onChanged: (String value) {
                                                    changedText(
                                                      value,
                                                      empList[i]["ChiSoCu"],
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                'Mức tiêu thụ',
                                                style: TextStyle(
                                                    color: Colors.blue[500],
                                                    fontSize: 15),
                                              )),
                                            ),
                                            SizedBox(
                                              child: Container(
                                                child: TextFormField(
                                                  key: Key(mtt.toString()),
                                                  enabled: false,
                                                  initialValue: '${mtt ?? ""}',
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // CHI TIET TINH TIEN
                              Container(
                                  width: size.height,
                                  padding: const EdgeInsets.all(10),
                                  color: Colors.grey[300],
                                  child: Row(
                                    children: [
                                      Text(
                                        'CHI TIẾT TÍNH TIỀN ',
                                        style: TextStyle(
                                            color: Colors.brown[500],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        '** Chưa thu **',
                                        style: TextStyle(
                                            color: Colors.red[500],
                                            fontSize: 15),
                                      ),
                                    ],
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Container(
                                                child: Text(
                                              'M3',
                                              style: TextStyle(
                                                  color: Colors.blue[500],
                                                  fontSize: 15),
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                'Đơn giá',
                                                style: TextStyle(
                                                    color: Colors.blue[500],
                                                    fontSize: 15),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                'Thành tiền',
                                                style: TextStyle(
                                                    color: Colors.blue[500],
                                                    fontSize: 15),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.black87,
                              ),

                              if (truonghop == 1) ...[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                '0',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '0',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '0',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ] else if (truonghop == 2) ...[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                '${m3_1}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '${money.format(dg1)}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '${tt_1}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ] else if (truonghop == 3) ...[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                '${m3_1}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '${money.format(dg1)}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '${tt_1}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
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
                                  padding:
                                      const EdgeInsets.only(top: 20, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                '${m3_2}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '${money.format(dg2)}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '${tt_2}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ] else if (truonghop == 4) ...[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                '${m3_1}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '${money.format(dg1)}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '${tt_1}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
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
                                  padding:
                                      const EdgeInsets.only(top: 20, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                '${m3_2}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '${money.format(dg2)}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '${tt_2}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
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
                                  padding:
                                      const EdgeInsets.only(top: 20, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                '${m3_3}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '${money.format(dg3)}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '${tt_3}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ] else if (truonghop == 5) ...[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                '${m3_1}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '${money.format(dg1)}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '${tt_1}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
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
                                  padding:
                                      const EdgeInsets.only(top: 20, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                '${m3_2}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '${money.format(dg2)}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '${tt_2}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
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
                                  padding:
                                      const EdgeInsets.only(top: 20, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                '${m3_3}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '${money.format(dg3)}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '${tt_3}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
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
                                  padding:
                                      const EdgeInsets.only(top: 20, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                '${m3_4}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '${money.format(dg4)}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  '${tt_4}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
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

                              Divider(
                                color: Colors.black87,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Container(
                                                child: Text(
                                              '',
                                              style: TextStyle(
                                                  color: Colors.blue[500],
                                                  fontSize: 15),
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                'Tiền nước:',
                                                style: TextStyle(
                                                    color: Colors.blue[500],
                                                    fontSize: 15),
                                              )),
                                            ),
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                'Thuế TN(5%):',
                                                style: TextStyle(
                                                    color: Colors.blue[500],
                                                    fontSize: 15),
                                              )),
                                            ),
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                'Phí nước thải:',
                                                style: TextStyle(
                                                    color: Colors.blue[500],
                                                    fontSize: 15),
                                              )),
                                            ),
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                'Chỉ số mới',
                                                style: TextStyle(
                                                    color: Colors.blue[500],
                                                    fontSize: 15),
                                              )),
                                            ),
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                'Thuế NT(10%):',
                                                style: TextStyle(
                                                    color: Colors.blue[500],
                                                    fontSize: 15),
                                              )),
                                            ),
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                'Phí môi trường:',
                                                style: TextStyle(
                                                    color: Colors.blue[500],
                                                    fontSize: 15),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                '${tienNuoc ?? ""}',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15),
                                              )),
                                            ),
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                '${thueTN ?? ""}',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15),
                                              )),
                                            ),
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                '${thueBao ?? ""}',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15),
                                              )),
                                            ),
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                '${thueBao ?? ""}',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15),
                                              )),
                                            ),
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                '${thueBao ?? ""}',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15),
                                              )),
                                            ),
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                '${thueBao ?? ""}',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.black87,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                '',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                'Tổng tiền',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                  child: Text(
                                                '${tongTien ?? ""}',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // CAMERA
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 5, left: 100, right: 100),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _getFromCamera();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child: Container(
                                                    child: Text(
                                                  'Camera',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            imageFile != null
                                                ? SizedBox(
                                                    height: 500,
                                                    child: Container(
                                                      child:
                                                          Image.file(imageFile),
                                                    ),
                                                  )
                                                : Container(child: Text(''))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // SELECT BOX TRANG THAI
                              Container(
                                width: size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Trạng thái',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 18),
                                    ),
                                    DropdownButton(
                                        alignment: AlignmentDirectional.center,
                                        elevation: 2,
                                        items: data.map((item) {
                                          return DropdownMenuItem(
                                            child: Container(
                                              child: Text(item["NoiDung"]),
                                            ),
                                            value: item["GhiChuID"],
                                          );
                                        }).toList(),
                                        onChanged: (newVal) {
                                          setState(() {
                                            _mySelection = newVal;
                                          });
                                          print(newVal);
                                        },
                                        value: _mySelection),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'Ghi chú kỳ trước',
                                  style: TextStyle(
                                      color: Colors.blue[500], fontSize: 18),
                                ),
                              ),
                              TextFormField(
                                enabled: false,
                                initialValue: '${empList[i]["GhiChuKyTruoc"]}',
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'Ghi chú',
                                  style: TextStyle(
                                      color: Colors.blue[500], fontSize: 18),
                                ),
                              ),
                              TextFormField(
                                onChanged: (String value) {
                                  Notes = value;
                                },
                                // initialValue: '${empList[i]["MaDanhBo"]}',
                              ),
                            ],
                          ),
                        ));
                  });
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
        // child: Text('${index2.index.value}'),
      ),
    ));
  }
}
