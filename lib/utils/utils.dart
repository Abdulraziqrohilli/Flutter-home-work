import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class Utils {
  static void showTopSnackbar(
    // BuildContext context,
    String message,
    Color color,
  ) =>
      showSimpleNotification(
        Text("Internet Connectivity Update"),
        subtitle: Text(message),
        background: color,
        duration: Duration(seconds: 2)
      );
}
