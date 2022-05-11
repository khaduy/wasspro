import 'package:flutter/material.dart';
import 'package:wasspro/pages/sub1_pages/chuathu.dart';
import 'package:wasspro/pages/sub1_pages/dathu.dart';

class DsThu extends StatefulWidget {
  const DsThu({Key key}) : super(key: key);
  @override
  State<DsThu> createState() => _DsThuState();
}

class _DsThuState extends State<DsThu> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text('Danh sách khách hàng'),
              bottom: TabBar(tabs: [
                Tab(
                  text: 'Chưa thu',
                ),
                Tab(
                  text: 'Đã thu',
                )
              ]),
            ),
            body: TabBarView(children: [ChuaThu(), DaThu()]),
          ),
        ));
  }
}
