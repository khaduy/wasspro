import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasspro/main.dart';
import 'package:wasspro/models/dskhthu.dart';

class ThongTinKhachHang extends StatefulWidget {
  const ThongTinKhachHang({
    Key? key,
  }) : super(key: key);
  @override
  State<ThongTinKhachHang> createState() => _ThongTinKhachHangState();
}

class _ThongTinKhachHangState extends State<ThongTinKhachHang> {
  @override
  void initState() {
    super.initState();
    futureDSKHThu = fetchTTKHThu();
  }

  final Control index2 = Get.find();

  Future<DSKHThu>? futureDSKHThu;
  Future<DSKHThu> fetchTTKHThu() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List jsonResponse = await jsonDecode(prefs.getString("dskh") ?? "");
    var respJson1 = await jsonEncode(jsonResponse[index2.index.value]);
    // print(index2.index.value);
    print(respJson1);
    return DSKHThu.fromJson(jsonDecode(respJson1));
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
        child: FutureBuilder<DSKHThu>(
          future: futureDSKHThu,
          builder: (context, dskh) {
            if (dskh.hasData) {
              return Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: size.height,
                    child: Wrap(
                      children: [
                        Text(
                          'Mã KH - Tên khách hàng',
                          style:
                              TextStyle(color: Colors.blue[500], fontSize: 18),
                        ),
                        TextFormField(
                          enabled: false,
                          initialValue:
                              '${dskh.data!.madanhbo} - ${dskh.data!.hoTenKH}',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'Địa chỉ',
                            style: TextStyle(
                              color: Colors.blue[500],
                              fontSize: 18,
                            ),
                          ),
                        ),
                        TextFormField(
                          maxLines: 2,
                          enabled: false,
                          initialValue: '${dskh.data!.diachi}',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Row(
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      child: Container(
                                          child: Text(
                                        'Đối tượng',
                                        style: TextStyle(
                                            color: Colors.blue[500],
                                            fontSize: 18),
                                      )),
                                    ),
                                    SizedBox(
                                      child: Container(
                                        child: TextFormField(
                                          enabled: false,
                                          initialValue: '${dskh.data!.maDT}',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
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
                                              fontSize: 18),
                                        )),
                                      ),
                                      SizedBox(
                                        child: Container(
                                          child: TextFormField(
                                            enabled: false,
                                            initialValue: '${dskh.data!.soNK}',
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      child: Container(
                                          child: Text(
                                        'Mã danh bộ',
                                        style: TextStyle(
                                            color: Colors.blue[500],
                                            fontSize: 18),
                                      )),
                                    ),
                                    SizedBox(
                                      child: Container(
                                        child: TextFormField(
                                          enabled: false,
                                          initialValue:
                                              '${dskh.data!.madanhbo}',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: size.height,
                          padding: const EdgeInsets.all(10),
                          color: Colors.grey[300],
                          child: Text(
                            'DANH SÁCH HÓA ĐƠN',
                            style: TextStyle(
                                color: Colors.brown[500],
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Kỳ ghi',
                                style: TextStyle(
                                    color: Colors.blue[500], fontSize: 18),
                              ),
                              Text(
                                'Tiêu thụ',
                                style: TextStyle(
                                    color: Colors.blue[500], fontSize: 18),
                              ),
                              Text(
                                'Thành tiền',
                                style: TextStyle(
                                    color: Colors.blue[500], fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black87,
                        ),
                        Row()
                      ],
                    ),
                  ));
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
