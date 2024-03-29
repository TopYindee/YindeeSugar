import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:yindeesugar/utility/app_controller.dart';
import 'package:yindeesugar/utility/app_dialog.dart';
import 'package:yindeesugar/utility/app_service.dart';
import 'package:yindeesugar/widgets/widget_button.dart';
import 'package:yindeesugar/widgets/widget_form.dart';
import 'package:yindeesugar/widgets/widget_icon_button.dart';
import 'package:yindeesugar/widgets/widget_image_asset.dart';
import 'package:yindeesugar/widgets/widget_image_file.dart';
import 'package:yindeesugar/widgets/widget_text.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({super.key});

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  AppController appController = Get.put(AppController());

  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (appController.files.isNotEmpty) {
      appController.files.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: const WidgetText(data: 'Create New Account'),
        ),
        
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: ListView(
            children: [
              Column(
                children: [
                  displayImage(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: Get.width * 0.75,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              WidgetForm(
                                textEditingController: nameController,
                                validateFanc: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return '***โปรดกรอก ชื่อ';
                                  } else {
                                    return null;
                                  }
                                },
                                labelWidget:
                                    const WidgetText(data: 'Display Name : '),
                              ),
                              WidgetForm(
                                textEditingController: emailController,
                                validateFanc: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return '***โปรดกรอก Email';
                                  } else {
                                    return null;
                                  }
                                },
                                labelWidget: const WidgetText(data: 'Email : '),
                              ),
                              WidgetForm(
                                textEditingController: passwordController,
                                validateFanc: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return '***โปรดกรอก รหัสผ่าน';
                                  } else {
                                    return null;
                                  }
                                },
                                labelWidget: const WidgetText(data: 'Password :'),
                              ),
                              WidgetButton(
                                label: 'Create New Account',
                                pressFunc: () {
                                  if (appController.files.isEmpty) {
                                    Get.snackbar('ยังไม่มีรูป',
                                        'โปรดเลือกรูปภาพ.! ด้วย คับ.....',
                                        backgroundColor: GFColors.DANGER,
                                        colorText: GFColors.WHITE);
                                  } else if (formKey.currentState!.validate()) {
                                    context.loaderOverlay.show();




                                    AppService().processCreateNewAccount(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        context: context);
                                        
                                  }
                                },
                              ),
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
      ),
    );
  }

  Row displayImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: Get.width * 0.6,
          height: Get.width * 0.6,
          child: Stack(
            children: [
              Obx(() => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: appController.files.isEmpty
                        ? const WidgetImageAsset(
                            path: 'images/avata.png',
                            //size: Get.width * 0.4,
                          )
                        : WidgetImageFile(
                            file: appController.files.last,
                            redius: Get.width * 0.6 * 0.5,
                          ),
                  )),
              Positioned(
                right: 0,
                bottom: 0,
                child: WidgetIconButton(
                  iconData: Icons.photo_camera,
                  pressFunc: () {
                    AppDialog().narmalDialog(
                        title: 'Camera or Gallery',
                        iconWidget: const WidgetImageAsset(
                          path: 'images/takeimage.png',
                          size: 150,
                        ),
                        contentWidget: const WidgetText(
                            data: 'โปรดเลือก Camera หรือ Gallery'),
                        firstWidget: WidgetButton(
                          label: 'Camera',
                          pressFunc: () {
                            Get.back();
                            AppService().processtakePhoto(
                                imageSource: ImageSource.camera);
                          },
                        ),
                        secontWidget: WidgetButton(
                          label: 'Gallery',
                          pressFunc: () {
                            Get.back();
                            AppService().processtakePhoto(
                                imageSource: ImageSource.gallery);
                          },
                        ));
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
