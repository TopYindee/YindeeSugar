import 'package:flutter/material.dart';

class AppConstant {
  //field
  static Color fillColor=Colors.grey.withOpacity(0.25);

  static String urlAPI = 'http://110.164.149.104:9295/fapi/userFlutter';

  //method

  TextStyle h1Style() {
    return const TextStyle(fontSize: 36, fontWeight: FontWeight.bold);
  }

  TextStyle h2Style() {
    return const TextStyle(fontSize: 22, fontWeight: FontWeight.w700);
  }

  TextStyle h3Style() {
    return const TextStyle(fontSize: 14, fontWeight: FontWeight.normal);
  }
}
