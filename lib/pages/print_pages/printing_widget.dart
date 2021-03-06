import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasspro/drawer.dart';
import 'package:wasspro/main.dart';
import 'package:wasspro/pages/print_pages/blue_print.dart';

import 'package:permission_handler/permission_handler.dart';

FlutterBlue flutterBlue = FlutterBlue.instance;

class PrintingWidget extends StatefulWidget {
  const PrintingWidget({Key key}) : super(key: key);
  @override
  State<PrintingWidget> createState() => _PrintingWidgetState();
}

class _PrintingWidgetState extends State<PrintingWidget> {
  List<ScanResult> scanResult;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    findDevices();
  }

  String token = "";
  String hoTenNV = "";
  String maND = "";
  Future<void> checkLoginStatus() async {
    await Permission.bluetoothConnect.request().isGranted;
    await Permission.bluetoothScan.request().isGranted;
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

  void findDevices() {
    flutterBlue.startScan(timeout: const Duration(seconds: 4));
    flutterBlue.scanResults.listen((result) {
      setState(() {
        scanResult =
            result.where((e) => e.device.name.toString() != "").toList();
      });
    });
    flutterBlue.stopScan();
  }

  final ctrl = Get.put(Control());
  void connectDevice(BluetoothDevice device) async {
    // await device.connect;
    var abc = device;
    print(abc);
    ctrl.add_deviceName(device.name);
    ctrl.add_device(device.id, device.name);
    device.disconnect;
  }

  void printWithDevice(BluetoothDevice device) async {
    await device.connect();
    final gen = Generator(PaperSize.mm58, await CapabilityProfile.load());
    final printer = BluePrint();
    printer.add(gen.text('Log out of the world'));
    printer.add(gen.feed(5));
    await printer.printData(device);
    device.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("C??i ?????t m??y in", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/prtgwg')
                    .whenComplete(() => null);
              },
              child: Image.asset("assets/icon_sync.png"),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => Text(
                    'Thi???t b??? ???? k???t n???i: ${ctrl.deviceName.value ?? "vui l??ng k???t n???i thi???t b???"}',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: size.height,
                  padding: const EdgeInsets.all(10),
                  color: Colors.grey[300],
                  child: Row(
                    children: [
                      Text(
                        'DANH S??CH THI???T B???',
                        style: TextStyle(
                            color: Colors.brown[500],
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: size.height * 50 / 100,
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
                itemCount: scanResult.length ?? 0,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (scanResult[index].device.name != "") ...[
                        TextButton(
                            onPressed: () =>
                                connectDevice(scanResult[index].device),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${scanResult[index].device.name}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  '${scanResult[index].device.id.id}',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ))
                      ] else ...[
                        Text('Thi???t b??? kh??ng h???p l???')
                      ]
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer1(hoTenNV, maND, context),
    ));
  }
}
