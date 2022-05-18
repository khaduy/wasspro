import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasspro/main.dart';
import 'package:wasspro/models/dskhghi.dart';

import 'package:http/http.dart' as http;

class ChuaGhi extends StatefulWidget {
  const ChuaGhi({Key key}) : super(key: key);
  @override
  State<ChuaGhi> createState() => _ChuaGhiState();
}

class _ChuaGhiState extends State<ChuaGhi> {
  int sl = 0;
  List empList = [];
  List filteredList = [];

  Future<List> futureDSKHGhi;
  final Control slhd2 = Get.find();
  Future<List> getEmpData() async {
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
        "LoTrinhID": '${slhd2.loTrinhID.value}',
        "UserToken": login['token'].toString(),
      }),
    );
    List jsonResponse = await jsonDecode(response.body)["data"];
    setState(() {
      sl = jsonResponse.where((e) => e["ChiSoMoi"] == 0).toList().length;
    });
    return Future.delayed(const Duration(seconds: 1), () {
      return jsonResponse.where((e) => e["ChiSoMoi"] == 0).toList();
    });
  }

  final TextEditingController editingController = TextEditingController();

  ValueNotifier<String> empName = ValueNotifier('');
  void changed(String query) {
    filteredList = empList
        .where(
            (e) => e['HoTenKH'].toString().toLowerCase() == query.toLowerCase())
        .toList();
    empName.value = query;
  }

  final ctrl = Get.put(Control());
  void route(String data) {
    print(data);
    ctrl.add_makh(data);
    Navigator.pushNamed(context, '/ttkhchghi');
  }

  @override
  void initState() {
    super.initState();
    futureDSKHGhi = getEmpData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0, right: 5, left: 5),
          child: Column(
            children: <Widget>[
              // TextField(
              //   controller: editingController,
              //   onChanged: changed,
              //   decoration: InputDecoration(
              //       labelText: "Search",
              //       hintText: "Search",
              //       prefixIcon: Icon(Icons.search),
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              // ),
              // SizedBox(height: 15),
              FutureBuilder<List>(
                  future: futureDSKHGhi,
                  builder: (ctx, ss) {
                    if (ss.hasData) {
                      empList = ss.data;
                      return Expanded(
                          child: ValueListenableBuilder<String>(
                              valueListenable: empName,
                              builder: (context, value, child) {
                                var listViewList =
                                    value.isEmpty ? empList : filteredList;
                                return ListView.builder(
                                    itemCount: listViewList.length,
                                    itemBuilder: (ctx, i) {
                                      return TextButton(
                                        onPressed: () {
                                          route(listViewList[i]["MaDanhBo"]);
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${listViewList[i]["HoTenKH"]}',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              'Mã KH: ${listViewList[i]["MaDanhBo"]}',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.brown),
                                            ),
                                            Text(
                                              'CSC: ${listViewList[i]["ChiSoCu"]}',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.green),
                                            ),
                                            Text(
                                              'Đồng hồ: ${listViewList[i]["hieuDH"]} - ${listViewList[i]["SoSeri"]} - Địa chỉ: ${listViewList[i]["DiaChiKH"]}',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.blue),
                                            ),
                                            Divider(
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              }));
                    } else if (ss.hasError) {
                      return Center(child: Text(''));
                    }
                    return Center(child: CircularProgressIndicator());
                  })
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: size.height * 5 / 100,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tổng cộng: ${sl}',
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
