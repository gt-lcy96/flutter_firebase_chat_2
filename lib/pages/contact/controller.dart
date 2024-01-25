import 'dart:convert';

import 'package:firebase_chat/common/entities/entities.dart';
import 'package:firebase_chat/common/store/store.dart';
import 'package:get/get.dart';
import 'index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactController extends GetxController {
  ContactController();
  final ContactState state = ContactState();
  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;

  @override
  void onReady() {
    super.onReady();
    asyncLoadAllData();
  }

  goChat(UserData to_userData) async {
    // create by current user
    var from_messages = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_uid", isEqualTo: token)
        .where("to_uid", isEqualTo: to_userData.id)
        .get();

    // create by other user
    var to_messages = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_uid", isEqualTo: to_userData.id)
        .where("to_uid", isEqualTo: token)
        .get();

    // for first time messaging, two user have never talked to each other
    if (from_messages.docs.isEmpty && to_messages.docs.isEmpty) {
      String profile = await UserStore.to.getProfile();
      UserLoginResponseEntity userData =
          UserLoginResponseEntity.fromJson(jsonDecode(profile));
      var msgData = Msg(
          from_uid: userData.accessToken,
          to_uid: to_userData.id,
          from_name: userData.displayName,
          to_name: to_userData.name,
          from_avatar: userData.photoUrl,
          to_avatar: to_userData.photourl,
          last_msg: "",
          last_time: Timestamp.now(),
          msg_num: 0);

      db
          .collection("message")
          .withConverter(
              fromFirestore: Msg.fromFirestore,
              toFirestore: (Msg msg, options) => msg.toFirestore())
          .add(msgData)
          .then((value) {
        Get.toNamed("/chat", parameters: {
          "doc_id": value.id,
          "to_uid": to_userData.id ?? "",
          "to_name": to_userData.name ?? "",
          "to_avatar": to_userData.photourl ?? "",
        });
      });
    } else {
      if (from_messages.docs.isNotEmpty) {
        Get.toNamed("/chat", parameters: {
          "doc_id": from_messages.docs.first.id,
          "to_uid": to_userData.id ?? "",
          "to_name": to_userData.name ?? "",
          "to_avatar": to_userData.photourl ?? "",
        });
      }

      if (to_messages.docs.isNotEmpty) {
        Get.toNamed("/chat", parameters: {
          "doc_id": to_messages.docs.first.id,
          "to_uid": to_userData.id ?? "",
          "to_name": to_userData.name ?? "",
          "to_avatar": to_userData.photourl ?? "",
        });
      }
    }
  }

  asyncLoadAllData() async {
    // print('asyncLoadAllData - called');
    var usersbase = await db
        .collection("users")
        .where("id", isNotEqualTo: token)
        .withConverter(
            fromFirestore: UserData.fromFirestore,
            toFirestore: (UserData userdata, options) => userdata.toFirestore())
        .get();

    print("usersbase.docs:  ${usersbase.docs}");
    for (var doc in usersbase.docs) {
      // print("doc.data():  ${doc.data()}");
      state.contactList.add(doc.data());
    }
    print("state.contactList:  ${state.contactList.length}");
  }
}
