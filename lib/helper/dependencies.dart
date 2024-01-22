import 'package:get/get.dart';
import 'package:firebase_chat/common/store/config.dart';
import 'package:firebase_chat/common/services/storage.dart';


Future<void> init() async {

  Get.lazyPut(() => ConfigStore());
  Get.lazyPut(()=>StorageService());
  // Get.lazyPut(() => OrderController(orderRepo: Get.find()));
  // Get.lazyPut(()=>StorageService(_prefs: Get.find()));
  await Get.put(StorageService()).init();
}