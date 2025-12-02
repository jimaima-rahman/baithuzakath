import 'package:flutter/material.dart';

class R {
  static double sw(double width, BuildContext context) {
    return MediaQuery.of(context).size.width * (width / 392.73);
  }

  static double sh(double height, BuildContext context) {
    return MediaQuery.of(context).size.height * (height / 856.73);
  }
}
