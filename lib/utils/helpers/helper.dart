import 'package:flutter/material.dart';

class HHelper {

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
  
}
