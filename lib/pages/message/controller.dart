import 'package:firebase_chat/common/store/store.dart';
import 'package:get/get.dart';
import 'index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageController extends GetxController {
  
  MessageController();

  final token = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  final MessageState state = MessageState();
  var listener;

}