import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yindeesugar/utility/app_controller.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> processtakePhoto({required ImageSource imageSource}) async {
    var result = await ImagePicker()
        .pickImage(source: imageSource, maxWidth: 800, maxHeight: 800);

    if (result != null) {
      appController.files.add(File(result.path));
    }
  }
}
