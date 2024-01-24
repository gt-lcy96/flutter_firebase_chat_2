import 'package:firebase_chat/common/entities/user.dart';
import 'package:firebase_chat/common/routes/routes.dart';
import 'package:firebase_chat/common/routes/names.dart';
import 'package:firebase_chat/common/store/user.dart';
import 'package:firebase_chat/common/widgets/toast.dart';
import 'package:get/get.dart';
import 'index.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

GoogleSignIn _googleSighnIn = GoogleSignIn(scopes: <String>['openid']);

class SignInController extends GetxController {
  final state = SignInState();
  SignInController();
  final db = FirebaseFirestore.instance;

  Future<void> handleSignIn() async {
    try {
      var user = await _googleSighnIn.signIn();
      if (user != null) {

        final _gAuthentication = await user.authentication;
        final _credential = GoogleAuthProvider.credential(
          idToken: _gAuthentication.idToken,
          accessToken: _gAuthentication.accessToken,
        );
        await FirebaseAuth.instance.signInWithCredential(_credential);

        String displayName = user.displayName ?? user.email;
        String email = user.email;
        String id = user.id;
        String photoUrl = user.photoUrl ?? "";
        UserLoginResponseEntity userProfile = UserLoginResponseEntity();
        userProfile.email = email;
        userProfile.accessToken = id;
        userProfile.displayName = displayName;
        userProfile.photoUrl = photoUrl;

        UserStore.to.saveProfile(userProfile);
        var userbase = await db.collection("users").withConverter(
              fromFirestore: UserData.fromFirestore,
              toFirestore: (UserData userdata, options) => userdata.toFirestore(),
            ).where("id", isEqualTo: id).get();
        
        if(userbase.docs.isEmpty) {
          final data = UserData(
            id: id,
            name: displayName,
            email: email,
            photourl: photoUrl,
            location: "",
            fcmtoken: "",
            addtime: Timestamp.now()
          );

          await db.collection("users").withConverter(
              fromFirestore: UserData.fromFirestore,
              toFirestore: (UserData userdata, options) => userdata.toFirestore(),
            ).add(data);
        }
        toastInfo(msg: "login success");
        Get.offAndToNamed(AppRoutes.Application);
      }
    } catch (e) {
      toastInfo(msg: "login error");
      print('Exception in signIn controller: ${e}');
    }
  }

  @override
  void onReady() {
    super.onReady();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if(user==null) {
        print("User is currently logged out");
      } else {
        print("User is logged in");
      }
     });
  }
}
