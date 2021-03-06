import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wasspro/drawer.dart';
import 'package:wasspro/main.dart';
import 'package:wasspro/pages/dangnhap.dart';
import 'package:wasspro/models/dangnhap_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/lotrinhghi.dart';
import '../models/lotrinhghi_data.dart';

class GhiChiSo extends StatefulWidget {
  const GhiChiSo({Key key}) : super(key: key);
  @override
  State<GhiChiSo> createState() => _GhiChiSoState();
}

class _GhiChiSoState extends State<GhiChiSo> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    futureLoTrinhGhi = fetchLoTrinhGhi();
    futureLoTrinhGhiData = fetchLoTrinhGhiDataFirst();
  }

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

  Future<List<LoTrinhGhi>> futureLoTrinhGhi;

  Future<List<LoTrinhGhiData>> futureLoTrinhGhiData;
  int j = -1, slghi = 0;
  int chghi = 0, daghi = 0;
  int chthu = 0, dathu = 0;
  final slhd1 = Get.put(Control());
  Future<List<LoTrinhGhiData>> fetchLoTrinhGhiData(num chiNhanhID,
      num nhanVienID, num loTrinhID, String token, int index) async {
    slhd1.addLotrinhID(loTrinhID);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var login = await jsonDecode(prefs.getString("dangnhap"));
    final response = await http.post(
      Uri.parse('http://api.vnptcantho.com.vn/pntest/api/getDSKhachHangGhi'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "Key": "3b851f9fb412e97ec9992295ab9c3215",
        "Token": "a29c79a210968550fe54fe8d86fd27dd",
        "NhanVienID": login['NhanVienID'].toInt().toString(),
        "ChiNhanhID": login['ChiNhanhID'].toInt().toString(),
        "LoTrinhID": loTrinhID.toString(),
        "UserToken": login['token'].toString(),
      }),
    );
    slghi = 0;
    chghi = 0;
    daghi = 0;
    chthu = 0;
    dathu = 0;
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        print(loTrinhID);
        List jsonResponse = await jsonDecode(response.body)["data"];
        String respString1 = await jsonEncode(jsonResponse);
        prefs.setString("dskhghi", respString1);
        setState(() {
          this.j = index;
          slghi = jsonResponse.length;
          for (int i = 0; i < jsonResponse.length; i++) {
            if (jsonResponse[i]["ChiSoMoi"] == 0) {
              chghi++;
            }
            if (jsonResponse[i]["ChiSoMoi"] != 0) {
              daghi++;
            }
            if (jsonResponse[i]["ThuTien_app"] == false) {
              chthu++;
            }
            if (jsonResponse[i]["ThuTien_app"] == true) {
              dathu++;
            }
          }
        });
        return jsonResponse
            .map((data) => LoTrinhGhiData.fromJson(data))
            .toList();
      } else {
        print('null roi');
        return [];
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
          title: Text("Ghi ch??? s???", style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/ghichiso')
                      .whenComplete(() => null);
                },
                child: Image.asset("assets/icon_sync.png"),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
          child: SizedBox(
            height: size.height,
            child: FutureBuilder<List<LoTrinhGhi>>(
                future: futureLoTrinhGhi,
                builder: (context, ltg) {
                  if (ltg.hasData) {
                    List<LoTrinhGhi> data = ltg.data;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Record(
                            data,
                            index,
                            data[index].chiNhanhID,
                            data[index].nhanVienID,
                            data[index].loTrinhID,
                            token);
                      },
                    );
                  } else if (ltg.hasError) {
                    return Container(
                        alignment: Alignment.center,
                        child: Text("Kh??ng t??m th???y d??? li???u"));
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

  Container Record(List<LoTrinhGhi> data, int index, num chiNhanhID,
      num nhanVienID, num loTrinhID, String token) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: FutureBuilder<List<LoTrinhGhiData>>(
              future: futureLoTrinhGhiData,
              builder: (context, ltgdata) {
                if (ltgdata.hasData) {
                  List<LoTrinhGhiData> data1 = ltgdata.data;
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // primary: false,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index1) {
                      if (this.j == index) {
                        data1[index1].chiSoCu = slghi;
                        data1[index1].chiSoMoi = chghi;
                        data1[index1].khachHangID = daghi;
                        data1[index1].soNK = chthu;
                        data1[index1].doiTuongID = dathu;
                        return Column(
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
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/dsghi');
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                                maxLines: 2,
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
                                              'S??? l?????ng ghi: ${data1[index1].chiSoCu} - Ch??a ghi: ${data1[index1].chiSoMoi} - ???? ghi: ${data1[index1].khachHangID}',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Ch??a thu: ${data1[index1].soNK} - ???? thu: ${data1[index1].doiTuongID}',
                                              style: TextStyle(
                                                  color: Colors.green),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 10 / 100,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            futureLoTrinhGhiData =
                                                fetchLoTrinhGhiData(
                                                    chiNhanhID,
                                                    nhanVienID,
                                                    loTrinhID,
                                                    token,
                                                    index);

                                            // futureLoTrinhGhiData =
                                            //     fetchLoTrinhGhiData(
                                            //         9.0, 48.0, 96.0, '4d24', 0);
                                          },
                                          child: Image.asset(
                                            "assets/icon_sync_lotrinh.png",
                                            width: 40,
                                            height: 40,
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: size.width * 80 / 100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                            maxLines: 2,
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
                                          'S??? l?????ng ghi: 0 - Ch??a ghi: 0 - ???? ghi: 0',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Ch??a thu: 0 - ???? thu: 0',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 10 / 100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              futureLoTrinhGhiData =
                                                  fetchLoTrinhGhiData(
                                                      chiNhanhID,
                                                      nhanVienID,
                                                      loTrinhID,
                                                      token,
                                                      index);

                                              // futureLoTrinhGhiData =
                                              //     fetchLoTrinhGhiData(
                                              //         9.0, 48.0, 96.0, '4d24', 0);
                                            },
                                            child: Image.asset(
                                              "assets/icon_sync_lotrinh.png",
                                              width: 30,
                                              height: 30,
                                            ))
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      }
                    },
                  );
                } else if (ltgdata.hasError) {
                  return Container(
                      alignment: Alignment.center,
                      child: Text("Kh??ng t??m th???y d??? li???u"));
                }
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              }),
        ),
        Divider(
          color: Colors.black12,
        ),
      ],
    ));
  }
}
