import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var currentName = ''.obs;

  void getCurrentUserName() async {
    try {
      String uid = auth.currentUser!.uid;

      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();

      if (userDoc.exists) {
        currentName.value = userDoc['name'];
      } else {
        currentName.value = "Nama tidak ditemukan";
      }
    } catch (e) {
      currentName.value = "Error mengambil nama pengguna";
      print(e);
    }
  }
}
