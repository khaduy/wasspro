import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasspro/main.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:wasspro/pages/sub1_pages/sub2.pages/camera.dart';

class TTKH_ChGhi extends StatefulWidget {
  const TTKH_ChGhi({Key? key}) : super(key: key);
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

  List empList = [];
  Future<List>? futureDSKHGhi;
  Future<List> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List jsonResponse = await jsonDecode(prefs.getString("dskhghi") ?? "");
    return Future.delayed(const Duration(seconds: 1), () {
      return jsonResponse
          .where((e) => e["MaDanhBo"].toString() == ctrl.MaKH.value.toString())
          .toList();
    });
  }

  File? imageFile;
  void _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    setState(() {
      imageFile = File(pickedFile!.path);
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
    List jsonResponse = await jsonDecode(response.body)["data"];
    List jsonResponse1 = await jsonDecode(response1.body)["data"];
    dg1 = jsonResponse1[0]["DonGia0V"].toInt();
    dg2 = jsonResponse1[1]["DonGia0V"].toInt();
    dg3 = jsonResponse1[2]["DonGia0V"].toInt();
    dg4 = jsonResponse1[3]["DonGia0V"].toInt();
    print('abc: ${dg1}');
    setState(() {
      data = jsonResponse;
      _mySelection = jsonResponse[0]["GhiChuID"];
    });
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
  final money = new NumberFormat("#,##0", "eu");
  void changedText(String value, empList) {
    int csc = empList.toInt();
    int csmInt = 0;
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
                Navigator.pushNamed(context, '/hoadon')
                    .whenComplete(() => null);
              },
              child: Image.asset("assets/icon_sync.png"),
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
              empList = dskh.data!;
              return ListView.builder(
                  itemCount: empList.length,
                  itemBuilder: (ctx, i) {
                    return Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                                initialValue:
                                                    '${empList[i]["KyGhiID"]}',
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
                                                      child: Image.file(
                                                          imageFile!),
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
                              // SELECT BOX
                              Text(
                                'Trạng thái',
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 18),
                              ),
                              DropdownButton(
                                  elevation: 2,
                                  items: data.map((item) {
                                    return DropdownMenuItem(
                                      child: Container(
                                        child: Text(item["NoiDung"]),
                                        width: 500,
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
