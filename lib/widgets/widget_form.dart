// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:yindeesugar/utility/app_constant.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    this.hint,
    this.sufficWidget,
  }) : super(key: key);
  final String? hint;
  final Widget? sufficWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: AppConstant.fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: hint,
          suffixIcon: sufficWidget
        ),
      ),
    );
  }
}