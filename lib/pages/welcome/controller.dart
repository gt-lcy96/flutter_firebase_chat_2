import 'package:firebase_chat/common/routes/routes.dart';
import 'package:firebase_chat/common/store/config.dart';
import 'package:get/get.dart';
import 'package:firebase_chat/pages/welcome/state.dart';

class WelcomeController extends GetxController {
  final state = WelcomeState();
  WelcomeController();

  changePage(int index) async {
    state.index.value = index;
  }

  handleSignIn() async {
    await ConfigStore.to.saveAlreadyOpen();
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }
}