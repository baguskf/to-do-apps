import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapps/app/routes/app_pages.dart';

class FirebaseauthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<User?> get streamAuth => auth.authStateChanges();

  var emailError = Rx<String?>(null);
  var passwordError = Rx<String?>(null);

  void login(String email, String pass) async {
    if (email.isEmpty ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[a-zA-Z]{2,}$').hasMatch(email) ||
        pass.isEmpty ||
        pass.length < 8) {
      emailError.value = 'Email tidak valid';
      showDialog('Gagal Login', 'Harap masukan data dengan benar');
      return;
    }

    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      Get.back();
      Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      Get.back();
      String errorMessage = _getErrorMessage(e.code);

      Get.dialog(
        AlertDialog(
          title: const Text(
            'Login Gagal',
            style: TextStyle(fontFamily: 'myfont'),
          ),
          content: Text(
            errorMessage,
            style: TextStyle(fontFamily: 'myfont'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'OK',
                style: TextStyle(fontFamily: 'myfont'),
              ),
            ),
          ],
        ),
        barrierDismissible: true,
      );
    }
  }

  void register(String email, String password, String name) async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': email,
        'name': name,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await auth.signOut();
      Get.back();
      Get.dialog(
        AlertDialog(
          title: const Text('Berhasil'),
          content: const Text('Akun Berhasil Dibuat'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.offAllNamed(Routes.LOGIN);
              },
              child: const Text('OK'),
            ),
          ],
        ),
        barrierDismissible: true,
      );
    } on FirebaseAuthException catch (e) {
      Get.back();
      String errorMessage = _getErrorMessage(e.code);

      Get.dialog(
        AlertDialog(
          title: const Text('Registrasi Gagal'),
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

  void reset(String email) async {
    if (email.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

        Get.back();
        Get.snackbar(
          "Berhasil",
          "Link Reset Password Dikirim ke Email Anda",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          borderRadius: 10,
        );
      } catch (e) {
        Get.back();
        Get.snackbar(
          "Error",
          "Format Email Salah",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          borderRadius: 10,
        );
      }
    } else {
      Get.back();
      Get.snackbar(
        "Error",
        "Silahkan Masukkan Email",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        borderRadius: 10,
      );
    }
  }

  void showDialog(String title, String message) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
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
