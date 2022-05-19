import 'package:flutter/material.dart';
import 'package:wasspro/pages/sub1_pages/chuaghi.dart';
import 'package:wasspro/pages/sub1_pages/daghi.dart';

class DsGhi extends StatefulWidget {
  const DsGhi({Key key}) : super(key: key);
  @override
  State<DsGhi> createState() => _DsGhiState();
}

class _DsGhiState extends State<DsGhi> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/ghichiso');
                },
              ),
              title: Text('Danh sách khách hàng'),
              bottom: TabBar(tabs: [
                Tab(
                  text: 'Chưa ghi',
                ),
                Tab(
                  text: 'Đã ghi',
                )
              ]),
            ),
            body: TabBarView(children: [ChuaGhi(), DaGhi()]),
          ),
        ));
  }
}
