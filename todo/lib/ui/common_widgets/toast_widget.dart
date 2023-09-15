import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowAlert {
  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg.trim(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
