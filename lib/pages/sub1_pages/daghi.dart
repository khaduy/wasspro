import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasspro/main.dart';

import 'package:http/http.dart' as http;

class DaGhi extends StatefulWidget {
  const DaGhi({Key key}) : super(key: key);
  @override
  State<DaGhi> createState() => _DaGhiState();
}

class _DaGhiState extends State<DaGhi> {
  List empList = [];
  List filteredList = [];

  final Control slhd2 = Get.find();
  Future<List> futureDSKHGhi;
  int tc = 0, dt = 0, ct = 0;
  double tt1 = 0, tt2 = 0, tt3 = 0;
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
    await prefs.setString("dskhghi", jsonEncode(jsonResponse));
    List jsonResponse1 =
        await jsonResponse.where((e) => e["ChiSoMoi"] != 0).toList();
    jsonResponse1.forEach((item1) {
      setState(() {
        tt1 = tt1 + item1["ThanhTien_app"];
      });
    });
    List jsonResponse2 =
        await jsonResponse1.where((e) => e["ThuTien_app"] == true).toList();
    jsonResponse2.forEach((item1) {
      setState(() {
        tt2 = tt2 + item1["ThanhTien_app"];
      });
    });
    List jsonResponse3 =
        await jsonResponse1.where((e) => e["ThuTien_app"] == false).toList();
    jsonResponse3.forEach((item1) {
      setState(() {
        tt3 = tt3 + item1["ThanhTien_app"];
      });
    });
    setState(() {
      ct = jsonResponse3.length;
      dt = jsonResponse2.length;
      tc = jsonResponse1.length;
    });
    return Future.delayed(const Duration(seconds: 1), () {
      return jsonResponse.where((e) => e["ChiSoMoi"] != 0).toList();
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
    Navigator.pushNamed(context, '/ttkhdaghi');
  }

  final money = new NumberFormat("#,##0", "eu");
  var datetime = new DateFormat("dd/MM/yyyy HH:mm");
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
                                              'MTT: ${listViewList[i]["LuongTieuThu"]} - Ngày ghi: ${datetime.format(DateTime.parse(listViewList[i]["NgayGhi"]))}',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.green),
                                            ),
                                            if (listViewList[i]
                                                    ["ThuTien_app"] ==
                                                true) ...[
                                              Text(
                                                'Đã thu: ${money.format(listViewList[i]["ThanhTien_app"])}',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.orange),
                                              ),
                                            ] else ...[
                                              Text(
                                                'Đã thu: chưa thu',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.orange),
                                              )
                                            ],
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
          height: size.height * 15 / 100,
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
                          'Tổng cộng: ${tc}',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Tổng tiền: ${money.format(tt1)}',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Đã thu: ${dt}',
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Tổng tiền: ${money.format(tt2)}',
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Chưa thu: ${ct}',
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Tổng tiền: ${money.format(tt3)}',
                          style: TextStyle(
                              color: Colors.orange,
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
