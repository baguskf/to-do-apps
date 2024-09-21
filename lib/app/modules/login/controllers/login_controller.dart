import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapps/app/controllers/firebaseauth_controller.dart';

class LoginController extends GetxController {
  var emailError = RxnString();
  var emailResetError = RxnString();
  var passwordError = RxnString();
  var isObscure = true.obs;
  final emailController = TextEditingController();
  final authController = Get.find<FirebaseauthController>();

  void validateEmail(String value) {
    if (value.isEmpty) {
      emailError.value = 'Email tidak boleh kosong';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[a-zA-Z]{2,}$').hasMatch(value)) {
      emailError.value = 'Email tidak valid';
    } else {
      emailError.value = null;
    }
  }

  void validateReset(String value) {
    if (value.isEmpty) {
      emailResetError.value = 'Email tidak boleh kosong';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[a-zA-Z]{2,}$').hasMatch(value)) {
      emailResetError.value = 'Email tidak valid';
    } else {
      emailResetError.value = null;
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

  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }

  void resetPassword() {
    emailController.clear();
  }

  void resetPasswordDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Masukan Email!',
          style: TextStyle(fontFamily: 'myfont'),
        ),
        content: Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  style: const TextStyle(fontFamily: 'myfont'),
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    label: const Text('Email',
                        style: TextStyle(fontFamily: 'myfont')),
                    labelStyle: const TextStyle(color: Colors.black),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorText: emailResetError.value,
                  ),
                  onChanged: (value) {
                    validateReset(value);
                  },
                ),
              ],
            )),
        actions: [
          TextButton(
            onPressed: () {
              if (emailResetError.value == null) {
                authController.reset(emailController.text);
              } else {
                Get.snackbar("Error", emailError.value!,
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
            child: const Text(
              'OK',
              style: TextStyle(fontFamily: 'myfont'),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(fontFamily: 'myfont'),
            ),
          ),
        ],
      ),
    );
  }
}
