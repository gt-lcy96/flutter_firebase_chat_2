import 'package:firebase_chat/common/store/user.dart';
import 'package:get/get.dart';
import 'package:firebase_chat/common/store/config.dart';
import 'package:firebase_chat/common/services/storage.dart';


Future<void> init() async {
  final storageService = Get.put(StorageService());
  await storageService.init();

  Get.put(ConfigStore());
  Get.put(UserStore());
  // Get.lazyPut(() => OrderController(orderRepo: Get.find()));
}