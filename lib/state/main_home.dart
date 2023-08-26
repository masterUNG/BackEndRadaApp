import 'package:backendradaapp/utility/app_controller.dart';
import 'package:backendradaapp/utility/app_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    AppService().readAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: appController.userModels.isEmpty
              ? Text('ไม่สมาชิกเลย')
              : Text(
                  'จำนวนเครื่องที่ติดตั้งแอพ ==> ${appController.userModels.length}'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  width: 250,
                  margin: const EdgeInsets.only(top: 16),
                  child: TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      label: Text('Title :'),
                      filled: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: 250,
                  margin: const EdgeInsets.only(top: 16),
                  child: TextFormField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      label: Text('Message'),
                      filled: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    if ((titleController.text.isEmpty) ||
                        (messageController.text.isEmpty)) {
                      //Have Space
                      Get.snackbar('Have Space', 'Please Fill Every Blank',
                          backgroundColor: Colors.red.shade700,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 5));
                    } else {
                      for (var element in appController.userModels) {
                        String token = element.token;
                        print('token ที่ต้องส่ง ---> $token');
                        AppService().processSentNoti(token: token, title: titleController.text, message: messageController.text);
                      }
                    }
                  },
                  child: const Text('Sent Noti'),
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}
