import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:wasspro/drawer.dart';
import 'package:wasspro/pages/dangnhap.dart';
import 'package:wasspro/models/dangnhap_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/lotrinhkh.dart';

class QLKhachHang extends StatefulWidget {
  const QLKhachHang({Key? key}) : super(key: key);
  @override
  State<QLKhachHang> createState() => _QLKhachHangState();
}

class _QLKhachHangState extends State<QLKhachHang> {
  Future<List<LoTrinhKH>>? futureLoTrinhKH;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    futureLoTrinhKH = fetchLoTrinhKH();
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:
              Text("Quản lý khách hàng", style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    futureLoTrinhKH = fetchLoTrinhKH1();
                  });
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
            child: FutureBuilder<List<LoTrinhKH>>(
                future: futureLoTrinhKH,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<LoTrinhKH>? data = snapshot.data;
                    return ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: SizedBox(
                                      width: size.width * 80/100,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          RichText(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(
                                                text: '${data[index].tenlt}',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black),
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              ('Số lượng KH: ${data[index].soluongKH}')),
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                  width: size.width * 13 / 100,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      TextButton(
                                          onPressed: () {},
                                          child: Image.asset(
                                            "assets/icon_sync_lotrinh.png",
                                            width: 50,
                                            height: 50,
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        );
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
}
