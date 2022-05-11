import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasspro/main.dart';

class DaGhi extends StatefulWidget {
  const DaGhi({Key key}) : super(key: key);
  @override
  State<DaGhi> createState() => _DaGhiState();
}

class _DaGhiState extends State<DaGhi> {
  int sl = 0;
  List empList = [];
  List filteredList = [];

  Future<List> futureDSKHGhi;

  Future<List> getEmpData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List jsonResponse = await jsonDecode(prefs.getString("dskhghi") ?? "");
    setState(() {
      sl = jsonResponse.where((e) => e["ChiSoMoi"] != 0).toList().length;
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
              TextField(
                controller: editingController,
                onChanged: changed,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
              SizedBox(height: 15),
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
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              'Mã KH: ${listViewList[i]["MaDanhBo"]}',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.brown),
                                            ),
                                            Text(
                                              'MTT: ${listViewList[i]["LuongTieuThu"]} - Ngày ghi: ${datetime.format(DateTime.parse(listViewList[i]["NgayGhi"]))}',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.green),
                                            ),
                                            if (listViewList[i]
                                                    ["ThuTien_app"] ==
                                                true) ...[
                                              Text(
                                                'Đã thu: ${money.format(listViewList[i]["ThanhTien_app"])}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.orange),
                                              ),
                                            ] else ...[
                                              Text(
                                                'Đã thu: chưa thu',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.orange),
                                              )
                                            ],
                                            Text(
                                              'Đồng hồ: ${listViewList[i]["hieuDH"]} - ${listViewList[i]["SoSeri"]} - Địa chỉ: ${listViewList[i]["DiaChiKH"]}',
                                              style: TextStyle(
                                                  fontSize: 18,
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
