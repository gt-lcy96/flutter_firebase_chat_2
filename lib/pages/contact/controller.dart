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

  asyncLoadAllData() async {
    // print('asyncLoadAllData - called');
    var usersbase = await db
        .collection("users")
        // .where("id", isNotEqualTo: token)
        .withConverter(
            fromFirestore: UserData.fromFirestore,
            toFirestore: (UserData userdata, options) => userdata.toFirestore())
        .get();

    print("usersbase.docs:  ${usersbase.docs}");
    for(var doc in usersbase.docs) {
      // print("doc.data():  ${doc.data()}");
      state.contactList.add(doc.data());
    }
    print("state.contactList:  ${state.contactList.length}");
  }
}
