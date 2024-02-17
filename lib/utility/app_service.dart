import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:yindeesugar/models/respon_model.dart';
import 'package:yindeesugar/models/user_api_model.dart';
import 'package:yindeesugar/models/user_model.dart';
import 'package:yindeesugar/utility/app_constant.dart';
import 'package:yindeesugar/utility/app_controller.dart';
import 'package:dio/dio.dart' as dio;
import 'package:yindeesugar/utility/app_dialog.dart';
import 'package:yindeesugar/widgets/widget_button.dart';
import 'package:yindeesugar/widgets/widget_text.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> processtakePhoto({required ImageSource imageSource}) async {
    var result = await ImagePicker()
        .pickImage(source: imageSource, maxWidth: 800, maxHeight: 800);

    if (result != null) {
      appController.files.add(File(result.path));
    }
  }

  Future<void> processCreateNewAccount({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      String uid = value.user!.uid;
      print('Uid ที่ได้จากการสมัคร----> $uid');

      //Process Upload Image to Storage
      String nameFile = '$uid.jpg';

      FirebaseStorage firebaseStorage = FirebaseStorage.instance;
      Reference reference = firebaseStorage.ref().child('avatar/$nameFile');
      UploadTask uploadTask = reference.putFile(appController.files.last);

      await uploadTask.whenComplete(() async {
        print('Upload $nameFile Success');

        await reference.getDownloadURL().then((value) async {
          String? urlImage = value;
          print(urlImage);

          UserModel userModel = UserModel(
              uid: uid,
              name: name,
              email: email,
              password: password,
              urlImage: urlImage);

          await FirebaseFirestore.instance
              .collection('user')
              .doc(uid)
              .set(userModel.toMap())
              .then((value) async {
            print('insert firebase Success');

            //Insert Data to API
            UserApiModel userApiModel = UserApiModel(
                name: name,
                email: email,
                password: password,
                fuidstr: uid,
                bod: DateTime.now().toString(),
                picurl: urlImage);

            await dio.Dio()
                .post(AppConstant.urlAPI, data: userApiModel.toMap())
                .then((value) {
              if (value.statusCode == 200) {
                ResponModel responModel = ResponModel.fromMap(value.data);

                AppDialog().narmalDialog(
                    title: 'Create Account Success',
                    contentWidget: WidgetText(data: responModel.message),
                    secontWidget: WidgetButton(
                      label: 'Thank you',
                      pressFunc: () {
                        context.loaderOverlay.hide();
                        Get.back();
                        Get.back();
                      },
                    ));
              } else {}
            });
          });
        });
      });
    }).catchError((onError) {
      context.loaderOverlay.hide();

      Get.snackbar(onError.code, onError.message,
          backgroundColor: GFColors.DANGER, colorText: GFColors.WHITE);
          
    });
  }
}
