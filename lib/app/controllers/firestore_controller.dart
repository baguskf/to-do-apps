import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:todoapps/app/routes/app_pages.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';
import 'package:todoapps/app/modules/add_data/controllers/add_data_controller.dart';

class FirestoreController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  final AddDataController addDataController = Get.find<AddDataController>();

  void upload(String matkul, String dosen, String tanggal, String note,
      String userId) async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    try {
      List<String> fileUrl = [];

      var fileID = const Uuid();
      for (File file in addDataController.selectedFiles) {
        String fileName = path.basename(file.path);
        Reference ref = storage.ref().child('${fileID.v4()}_$fileName');

        await ref.putFile(file);

        String downloadUrl = await ref.getDownloadURL();
        fileUrl.add(downloadUrl);
      }

      Get.back();

      await firestore.collection('data').doc(userId).collection('dataUser').add(
        {
          "matkul": matkul,
          "dosen": dosen,
          "tanggal": tanggal,
          "note": note,
          "files": fileUrl,
          "createdAt": FieldValue.serverTimestamp(),
        },
      );
      Get.dialog(
        AlertDialog(
          title: const Text('Berhasil disimpan'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.offAllNamed(Routes.HOME);
              },
              child: const Text('OK'),
            ),
          ],
        ),
        barrierDismissible: true,
      );
    } on FirebaseException catch (e) {
      Get.back();
      String errorMessage = _getErrorMessage(e.code);
      Get.dialog(
        AlertDialog(
          title: const Text('Gagal disimpan'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        ),
        barrierDismissible: true,
      );
    }
  }

  Stream<QuerySnapshot<Object?>> getData(String userId) {
    CollectionReference listdata =
        firestore.collection('data').doc(userId).collection('dataUser');
    return listdata.snapshots();
  }

  String _getErrorMessage(String errorCode) {
    final errorMessages = {
      'invalid-credential': 'Email atau Password salah',
      'channel-error': 'Masukan Semua Data!',
      'wrong-password': 'Password salah',
      'invalid-email': 'Email tidak valid',
      'weak-password': 'Password terlalu lemah',
      'email-already-in-use': 'Email sudah digunakan',
      'The email address is badly formatted': 'Format email salah'
    };
    return errorMessages[errorCode] ?? 'Terjadi kesalahan: $errorCode';
  }
}
