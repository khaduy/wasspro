import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Drawer Drawer1(String hoTenNV, String maND, BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(color: Colors.blue),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: size.width * 25 / 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                        child: Image.asset(
                      "assets/icon_menu_user.png",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ))
                  ],
                ),
              ),
              Container(
                width: size.width * 40 / 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$hoTenNV',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        )),
                    Text('$maND',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ],
                ),
              )
            ],
          ),
        ),
        ListTile(
          title: Text('Chức năng',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Divider(
          color: Colors.black12,
        ),
        ListTile(
            leading: SizedBox(
              height: 20,
              width: 20,
              child: Image.asset('assets/icon_menu_thongke.png'),
            ),
            title: Text('Thống kê'),
            onTap: () {
              Navigator.pushNamed(context, '/thongke');
            }),
        ListTile(
            leading: SizedBox(
              height: 20,
              width: 20,
              child: Image.asset('assets/icon_menu_hoadon.png'),
            ),
            title: Text('Hóa đơn'),
            onTap: () {
              Navigator.pushNamed(context, '/hoadon');
            }),
        ListTile(
            leading: SizedBox(
              height: 20,
              width: 20,
              child: Image.asset('assets/icon_menu_ghichiso.png'),
            ),
            title: Text('Ghi chỉ số'),
            onTap: () {
              Navigator.pushNamed(context, '/ghichiso');
            }),
        ListTile(
            leading: SizedBox(
              height: 20,
              width: 20,
              child: Image.asset('assets/icon_menu_customer.png'),
            ),
            title: Text('Quản lý khách hàng'),
            onTap: () {
              Navigator.pushNamed(context, '/qlykh');
            }),
        ListTile(
          title: Text('Tùy chọn',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Divider(
          color: Colors.black12,
        ),
        ListTile(
          leading: SizedBox(
            height: 25,
            width: 25,
            child: Image.asset('assets/printsetting.PNG'),
          ),
          title: Text('Cài đặt máy in'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Divider(
          color: Colors.white,
        ),
        Container(
          decoration: BoxDecoration(color: Colors.blue),
          child: ListTile(
            leading: Icon(Icons.logout, color: Colors.white),
            title: Text(
              'Đăng xuất',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onTap: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.remove('token');
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
        ),
      ],
    ),
  );
}
