import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:wasspro/drawer.dart';
import 'package:wasspro/main.dart';
import 'package:wasspro/models/dskhthu.dart';
import 'package:wasspro/pages/dangnhap.dart';
import 'package:wasspro/models/dangnhap_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../models/lotrinhthu_data.dart';

class DaThu extends StatefulWidget {
  const DaThu({Key key}) : super(key: key);
  @override
  State<DaThu> createState() => _DaThuState();
}

class _DaThuState extends State<DaThu> {
  @override
  void initState() {
    super.initState();
    futureDSKHThu = fetchDSKHThu();
  }

  final Control slhd2 = Get.find();
  final money = new NumberFormat("#,##0", "eu");
  int sl = 0;
  double tt = 0;

  Future<List<DSKHThu>> futureDSKHThu;
  Future<List<DSKHThu>> fetchDSKHThu() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(slhd2.loTrinhID.value);
    var login = await jsonDecode(prefs.getString("dangnhap"));
    final response = await http.post(
      Uri.parse('http://api.vnptcantho.com.vn/pntest/api/getDSKhachHangThu'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "Key": "3b851f9fb412e97ec9992295ab9c3215",
        "Token": "a29c79a210968550fe54fe8d86fd27dd",
        "NhanVienID": login['NhanVienID'].toInt().toString(),
        "ChiNhanhID": login['ChiNhanhID'].toInt().toString(),
        "LoTrinhID": '${slhd2.loTrinhID.value}',
        "UserToken": login['token'].toString(),
      }),
    );
    final response1 = await http.post(
      Uri.parse('http://api.vnptcantho.com.vn/pntest/api/getDMPhieuThuByLT'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "Key": "3b851f9fb412e97ec9992295ab9c3215",
        "Token": "a29c79a210968550fe54fe8d86fd27dd",
        "NhanVienID": login['NhanVienID'].toInt().toString(),
        "ChiNhanhID": login['ChiNhanhID'].toInt().toString(),
        "LoTrinhID": '${slhd2.loTrinhID.value}',
        "UserToken": login['token'].toString(),
      }),
    );
    print('denday');
    List jsonRes = await jsonDecode(response.body)["data"];
    List jsonRes1 = await jsonDecode(response1.body)["data"];
    List<dynamic> newList = [];
    jsonRes.forEach((item1) {
      jsonRes1.forEach((item2) {
        if (item1["KhachHangID"].toInt() == item2["KhachHangID"].toInt()) {
          newList.add(item1);
        }
      });
    });
    newList.forEach((item) {
      tt = tt.toDouble() + item["tongtien"].toDouble();
    });
    String listString = jsonEncode(newList);
    prefs.setString("dskhthu", listString);

    setState(() {
      this.sl = newList.length;
    });
    return newList.map((data) => DSKHThu.fromJson(data)).toList();
  }

  final index1 = Get.put(Control());
  void route(String index) {
    index1.add_index(index);
    Navigator.pushNamed(context, '/ttkhdathu');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
          child: SizedBox(
            height: size.height,
            child: FutureBuilder<List<DSKHThu>>(
                future: futureDSKHThu,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<DSKHThu> data = snapshot.data;

                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TextButton(
                            onPressed: () {
                              route(data[index].madanhbo);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index].hoTenKH,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                Text(
                                  data[index].madanhbo,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.brown),
                                ),
                                Text(
                                  data[index].diachi,
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.blue),
                                ),
                                Text(
                                  'Số lượng: 1 - Tổng tiền: ${data[index].tongtien}',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.green),
                                ),
                                Text(
                                  'Chưa đồng bộ: Số lượng: 0 - Tổng tiền: 0',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.orange),
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                              ],
                            ));
                      },
                    );
                  } else if (snapshot.hasError) {
                    print('object2');
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
        bottomNavigationBar: SizedBox(
          height: size.height * 2 / 17,
          child: BottomAppBar(
            color: Colors.blueGrey[100],
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Số lượng: ${this.sl}',
                          style: TextStyle(
                              color: Colors.blue[700],
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Số lượng HĐ: ${sl}',
                          style: TextStyle(
                              color: Colors.green[800],
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Tổng tiền: ${money.format(slhd2.tongtien.value)}',
                          style: TextStyle(
                              color: Colors.green[800],
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
