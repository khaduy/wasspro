import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wasspro/main.dart';
import 'package:wasspro/pages/sub1_pages/sub2.pages/ttkh_chghi.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  const Camera({
    Key? key,
  }) : super(key: key);
  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File? imageFile;
  void _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    setState(() {
      imageFile = File(pickedFile!.path);
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Chup Hinh", style: TextStyle(color: Colors.white)),
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
            body: 
            ListView(
              children: [
                SizedBox(
                  height: 50,
                ),
                imageFile != null
                    ? Container(
                        child: Image.file(imageFile!),
                      )
                    : Container(
                        child: Icon(
                          Icons.camera_enhance_rounded,
                          color: Colors.green,
                          size: MediaQuery.of(context).size.width * .6,
                        ),
                      ),
                ElevatedButton(
                  onPressed: () {
                    _getFromCamera();
                  },
                  child: Text('Capture Image with Camera'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.purple),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      textStyle:
                          MaterialStateProperty.all(TextStyle(fontSize: 16))),
                )
              ],
            )));
  }
}
