import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:yindeesugar/states/create_new_account.dart';
import 'package:yindeesugar/utility/app_constant.dart';
import 'package:yindeesugar/utility/app_controller.dart';
import 'package:yindeesugar/widgets/widget_button.dart';
import 'package:yindeesugar/widgets/widget_form.dart';
import 'package:yindeesugar/widgets/widget_icon_button.dart';
import 'package:yindeesugar/widgets/widget_image_asset.dart';
import 'package:yindeesugar/widgets/widget_text.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
//ตัวเรียกข้อมูล

  AppController appController = Get.put(AppController());

  //key ที่ใช้ในการเช็ค validate

  final formKey = GlobalKey<FormState>();

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
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            displayLogoAndAppName(),
                            emailForm(),
                            passwordForm(),
                            loginbutton(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: WidgetButton(
        label: 'Create New Account !',
        pressFunc: () {
          Get.to(const CreateNewAccount());
        },
        gfButtonType: GFButtonType.transparent,
      ),
    );
  }

  Container loginbutton() {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(top: 8),
      child: WidgetButton(
        label: 'Login',
        pressFunc: () {
          if (formKey.currentState!.validate()) {}
        },
      ),
    );
  }

  Obx passwordForm() {
    return Obx(() => WidgetForm(
          validateFanc: (p0) {
            if (p0?.isEmpty ?? true) {
              return 'Please Fill Password';
            } else {
              return null;
            }
          },
          hint: 'Password :',
          obsecu: appController.redEye.value,
          sufficWidget: WidgetIconButton(
            iconData: appController.redEye.value
                ? Icons.remove_red_eye
                : Icons.remove_red_eye_outlined,
            pressFunc: () {
              appController.redEye.value = !appController.redEye.value;
            },
          ),
        ));
  }

  WidgetForm emailForm() {
    return WidgetForm(
      validateFanc: (p0) {
        if (p0?.isEmpty ?? true) {
          return 'Please Fill Email';
        } else {
          return null;
        }
      },
      hint: 'Email : ',
      sufficWidget: Icon(Icons.email),
    );
  }

  Row displayLogoAndAppName() {
    return Row(
      children: [
        displayImage(),
        WidgetText(data: 'Yindee', textStyle: AppConstant().h1Style()),
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
