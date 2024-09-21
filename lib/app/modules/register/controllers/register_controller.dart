import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapps/app/controllers/firebaseauth_controller.dart';

class RegisterController extends GetxController {
  var nameError = RxnString();
  var emailError = RxnString();
  var emailResetError = RxnString();
  var passwordError = RxnString();
  var passwordConfirmError = RxnString();
  var isObscure = true.obs;
  var isConfirmObscure = true.obs;
  final emailController = TextEditingController();
  final authController = Get.find<FirebaseauthController>();

  void validateName(String value) {
    if (value.isEmpty) {
      nameError.value = 'Nama tidak boleh kosong';
    } else {
      nameError.value = null;
    }
  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      emailError.value = 'Email tidak boleh kosong';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[a-zA-Z]{2,}$').hasMatch(value)) {
      emailError.value = 'Email tidak valid';
    } else {
      emailError.value = null;
    }
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordError.value = 'Password tidak boleh kosong';
    } else if (value.length < 8) {
      passwordError.value = 'Password harus terdiri dari minimal 8 karakter';
    } else {
      passwordError.value = null;
    }
  }

  void validatePasswordConfirmation(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      passwordConfirmError.value = 'Konfirmasi password tidak boleh kosong';
    } else if (confirmPassword.length < 8) {
      passwordConfirmError.value =
          'Password harus terdiri dari minimal 8 karakter';
    } else if (password != confirmPassword) {
      passwordConfirmError.value = 'Password dan konfirmasi tidak cocok';
    } else {
      passwordConfirmError.value = null;
    }
  }

  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }

  void toggleConfirmObscure() {
    isConfirmObscure.value = !isConfirmObscure.value;
  }

  void registerDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Gagal Register',
          style: TextStyle(fontFamily: 'myfont'),
        ),
        content: const Text(
          'Harap Masukkan Semua Data',
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
    );
  }
}
