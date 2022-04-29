import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:wasspro/drawer.dart';
import 'package:wasspro/pages/dangnhap.dart';
import 'package:wasspro/models/dangnhap_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/thongke_data.dart';

class ThongKe extends StatefulWidget {
  @override
  _ThongKeState createState() => _ThongKeState();
}

class _ThongKeState extends State<ThongKe> {
  String hoTenNV = "";
  String maND = "";

  Future<List<ThongKeData>>? futureThongKe;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    futureThongKe = fetchThongKe();
  }

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
    });
    // print('dangnhap: ${hoTenNV}');
  }

  DateTime now = new DateTime.now();
  DateTime day = new DateTime(DateTime.now().year, DateTime.now().month, 1);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Thống kê", style: TextStyle(color: Colors.white)),
        ),
        body: Wrap(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Từ ngày"),
                ElevatedButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: day,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(3000),
                      );
                      if (newDate != null) {
                        setState(() {
                          day = day;
                        });
                      }
                      // thongKe();
                    },
                    child: Text('${day.day}-${day.month}-${day.year}')),
                Text("Đến ngày"),
                ElevatedButton(
                    onPressed: () async {
                      DateTime? newDate1 = await showDatePicker(
                        context: context,
                        initialDate: now,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(3000),
                      );
                      if (newDate1 != null) {
                        setState(() {
                          now = now;
                        });
                      }
                    },
                    child: Text('${now.day}-${now.month}-${now.year}'))
              ],
            ),
            Divider(
              color: Colors.black12,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: size.height * 10 / 15,
                child: 
                FutureBuilder<List<ThongKeData>>(
                    future: futureThongKe,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ThongKeData>? data = snapshot.data;
                        return ListView.builder(
                          itemCount: data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data[index].maTL}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(
                                  'Tổng 14 - Thành tiền: 1.000.0000',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                Text(
                                  'Đã thu: 0 - Thành tiền: 0',
                                  style: TextStyle(color: Colors.lightGreen),
                                ),
                                Divider(
                                  color: Colors.black12,
                                ),
                              ],
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('chua hien duoc: ${snapshot.hasError}');
                      }
                      return Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            ),
            // Text('data'),
            // Text('data'),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: size.height * 2 / 16,
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
                          'data1',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'data2data2data2d2ta2',
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
                          'data3',
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'data4',
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        drawer: Drawer1(hoTenNV, maND, context),
      ),
    );
  }
}
