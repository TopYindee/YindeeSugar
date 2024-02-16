// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class WidgetImageFile extends StatelessWidget {
  const WidgetImageFile({
    Key? key,
    required this.file,
    this.redius,
  }) : super(key: key);

  final File file;
  final double? redius;

  @override
  Widget build(BuildContext context) {
    return GFAvatar(
      backgroundImage: FileImage(file),radius: redius,
    );
  }
}
