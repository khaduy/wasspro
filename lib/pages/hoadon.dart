import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wasspro/drawer.dart';
import 'package:wasspro/main.dart';
import 'package:wasspro/pages/dangnhap.dart';
import 'package:wasspro/models/dangnhap_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/lotrinhthu.dart';
import '../models/lotrinhthu_data.dart';

class HoaDon extends StatefulWidget {
  const HoaDon({Key? key}) : super(key: key);
  @override
  State<HoaDon> createState() => _HoaDonState();
}

class _HoaDonState extends State<HoaDon> {
  @override
  void initState() {
    super.initState();
    theFirst();
  }

  void theFirst() async {
    await checkLoginStatus();
    futureHoaDon = fetchHoaDon();
    futureThongTinHoaDon = fetchThongTinHoaDonFirst();
  }

  Future<List<LoTrinhThu>>? futureHoaDon;
  Future<List<LoTrinhThuData>>? futureThongTinHoaDon;
  final slhd1 = Get.put(Control());
  Future<List<LoTrinhThuData>> fetchThongTinHoaDon(num loTrinhID,
      num nhanVienID, num chiNhanhID, String token, int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(
      Uri.parse('http://api.vnptcantho.com.vn/pntest/api/getLoTrinhThuByID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "Key": "3b851f9fb412e97ec9992295ab9c3215",
        "Token": "a29c79a210968550fe54fe8d86fd27dd",
        "NhanVienID": '48',
        "ChiNhanhID": "9",
        "LoTrinhID": '$loTrinhID',
        "UserToken": "765edf44ac1a6730cc0f38b42fcb1926"
      }),
    );
    final response1 = await http.post(
      Uri.parse('http://api.vnptcantho.com.vn/pntest/api/getDSKhachHangThu'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
       "Key": "3b851f9fb412e97ec9992295ab9c3215",
        "Token": "a29c79a210968550fe54fe8d86fd27dd",
        "NhanVienID": '48',
        "ChiNhanhID": "9",
        "LoTrinhID": '$loTrinhID',
        "UserToken": "765edf44ac1a6730cc0f38b42fcb1926"
      }),
    );
    print(loTrinhID);
    setState(() {
      this.i = index;
    });
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        List respJson = await jsonDecode(response.body)["data"];
        List respJson1 = await jsonDecode(response1.body)["data"];
        String respString1 = await jsonEncode(respJson1);
        prefs.setString("dskh", respString1);
        setState(() {
          this.soluongthu = respJson[0]["soluongthu"];
          this.tongtienthu = respJson[0]["tongtienthu"];
          this.soluongdongbo = respJson[0]["soluongdongbo"];
          this.tongtiendongbo = respJson[0]["tongtiendongbo"];
        });
        // this.slhd1. = respJson[0]["soluongdongbo"];
        double n1 = respJson[0]["tongtiendongbo"];
        int n2 = n1.toInt();
        this.slhd1.add_slhd(respJson[0]["soluongdongbo"]);
        this.slhd1.add_tt(n2);
        return respJson.map((data) => LoTrinhThuData.fromJson(data)).toList();
      } else {
        print('null roi');
        return [];
      }
    } else {
      print('res: ${response.body}');
      throw Exception('Failed');
    }
  }

  Future<List<LoTrinhThuData>> fetchThongTinHoaDonFirst() async {
    String first0 =
        '[{"soluongthu":0,"tongtienthu":0,"tenLT":"QUẢNG HỢP - Thôn Đồng Cơ","maLT":"QHP.1","maCN":"ABH","LoTrinhID":96.0,"ChiNhanhID":9.0,"NhanVienID":48.0,"soluongdongbo":0,"tongtiendongbo":0}]';
    List jsonFirst = await jsonDecode(first0);
    return jsonFirst.map((data) => LoTrinhThuData.fromJson(data)).toList();
  }

  num soluongthu = 0;
  num tongtienthu = 0;
  String tenLT = "";
  String maLT = "";
  String maCN = "";
  num loTrinhID = 0;
  num chiNhanhID = 0;
  num nhanVienID = 0;
  num soluongdongbo = 0;
  num tongtiendongbo = 0;

  int i = -1;
  String token = "";
  String hoTenNV = "";
  String maND = "";
  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("dangnhap") == null) {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
    setState(() {
      String result = (prefs.getString('dangnhap') ?? "");
      var jsonResult = json.decode(result);
      hoTenNV = jsonResult['HoTenNV'];
      maND = jsonResult['ma_nd'];
      token = jsonResult['token'];
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Hóa đơn", style: TextStyle(color: Colors.white)),
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
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
          child: SizedBox(
            height: size.height,
            child: FutureBuilder<List<LoTrinhThu>>(
                future: futureHoaDon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<LoTrinhThu>? data = snapshot.data;
                    return ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InfoBill(
                            data,
                            index,
                            data[index].loTrinhID,
                            data[index].nhanVienID,
                            data[index].chiNhanhID,
                            token);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Container(
                        alignment: Alignment.center,
                        child: Text("Không tìm thấy dữ liệu"));
                  }
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ),
        drawer: Drawer1(hoTenNV, maND, context),
      ),
    );
  }

  Container InfoBill(List<LoTrinhThu> data, int index, num loTrinhID,
      num nhanVienID, num chiNhanhID, String token) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<List<LoTrinhThuData>>(
            future: futureThongTinHoaDon,
            builder: (context, thongtinhoadon) {
              if (thongtinhoadon.hasData) {
                List<LoTrinhThuData>? data1 = thongtinhoadon.data;
                return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: data1!.length,
                  itemBuilder: (BuildContext context, int index1) {
                    if (this.i == index) {
                      data1[index1].soluongthu = this.soluongthu;
                      data1[index1].tongtienthu = this.tongtienthu;
                      data1[index1].soluongdongbo = this.soluongdongbo;
                      data1[index1].tongtiendongbo = this.tongtiendongbo;
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/dsthu');
                                },
                                child: SizedBox(
                                  width: size.width * 80 / 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      RichText(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            text:
                                                '${data[index].maLT} - ${data[index].tenLT}',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black),
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Đã thu: ${data1[index1].soluongthu} - Tổng tiền: ${data1[index1].tongtienthu}',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Số lượng đồng bộ: ${data1[index1].soluongdongbo} - Tổng tiền: ${data1[index1].tongtiendongbo}',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Số lượng chưa đồng bộ: 0 - Tổng tiền: 0',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 13 / 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          futureThongTinHoaDon =
                                              fetchThongTinHoaDon(
                                                  loTrinhID,
                                                  nhanVienID,
                                                  chiNhanhID,
                                                  token,
                                                  index);
                                        },
                                        child: Image.asset(
                                          "assets/icon_sync_lotrinh.png",
                                          width: 50,
                                          height: 50,
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                        ],
                      );
                    } else {
                      data1[index1].soluongthu = 0;
                      data1[index1].tongtienthu = 0;
                      data1[index1].soluongdongbo = 0;
                      data1[index1].tongtiendongbo = 0;
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: size.width * 80 / 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            text:
                                                '${data[index].maLT} - ${data[index].tenLT}',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black),
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Đã thu: ${data1[index1].soluongthu} - Tổng tiền: ${data1[index1].tongtienthu}',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Số lượng đồng bộ: ${data1[index1].soluongdongbo} - Tổng tiền: ${data1[index1].tongtiendongbo}',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Số lượng chưa đồng bộ: 0 - Tổng tiền: 0',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 13 / 100,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            futureThongTinHoaDon =
                                                fetchThongTinHoaDon(
                                                    loTrinhID,
                                                    nhanVienID,
                                                    chiNhanhID,
                                                    token,
                                                    index);
                                          },
                                          child: Image.asset(
                                            "assets/icon_sync_lotrinh.png",
                                            width: 50,
                                            height: 50,
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              } else if (thongtinhoadon.hasError) {
                return Container(
                    alignment: Alignment.center,
                    child: Text("Không tìm thấy dữ liệu"));
              }
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }),
      ],
    ));
  }
}
