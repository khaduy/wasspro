import 'package:flutter/material.dart';

class AlertDialogBase {
  AlertDialogBase();

  void showDialogThongBao(BuildContext context, String noidung) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Thông báo"),
          content: new Text(noidung),
          actions: <Widget>[
            new TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
