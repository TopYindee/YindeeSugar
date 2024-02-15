import 'package:flutter/material.dart';
import 'package:yindeesugar/utility/app_constant.dart';
import 'package:yindeesugar/widgets/widget_form.dart';
import 'package:yindeesugar/widgets/widget_image_asset.dart';
import 'package:yindeesugar/widgets/widget_text.dart';

class Authen extends StatelessWidget {
  const Authen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 64),
                      width: 300,
                      child: Column(
                        children: [
                          displayLogoAndAppName(),
                          WidgetForm(
                            hint: 'Email : ',
                            sufficWidget: Icon(Icons.email),
                          ),
                          WidgetForm(
                            hint: 'Password :',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row displayLogoAndAppName() {
    return Row(
      children: [
        displayImage(),
        WidgetText(data: 'Yindee Sugar', textStyle: AppConstant().h1Style()),
      ],
    );
  }

  WidgetImageAsset displayImage() {
    return WidgetImageAsset(
      path: 'images/logo1.png',
      size: 80,
    );
  }
}
