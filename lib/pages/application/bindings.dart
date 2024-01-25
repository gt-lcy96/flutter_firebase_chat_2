import 'package:get/get.dart';
import 'index.dart';
import 'package:firebase_chat/pages/contact/controller.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    // Get.lazyPut<ContactController>(() => ContactController());
  }
}