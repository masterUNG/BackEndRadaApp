import 'package:backendradaapp/models/user_model.dart';
import 'package:backendradaapp/utility/app_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> readAllUser() async {
    FirebaseFirestore.instance.collection('user').get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          UserModel userModel = UserModel.fromMap(element.data());
          appController.userModels.add(userModel);
        }
      }
    });
  }

  Future<void> processSentNoti(
      {required String token,
      required String title,
      required String message}) async {
    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/noti/notiRada.php?isAdd=true&token=$token&title=$title&body=$message';
    await Dio().get(urlApi).then((value) {
      print('Sent Noti success value ---> $value');
    });
  }
}
