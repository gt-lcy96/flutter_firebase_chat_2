import 'package:firebase_chat/pages/message/photoView/controller.dart';
import 'package:get/get.dart';

class PhotoImageViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhotoImageViewController>(() => PhotoImageViewController());
  }

}