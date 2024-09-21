import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todoapps/app/controllers/firebaseauth_controller.dart';
import 'package:todoapps/app/routes/app_pages.dart';
import 'package:todoapps/colors/colors.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({super.key});
  final authController = Get.find<FirebaseauthController>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset('assets/images/buku.png'),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Silahkan Daftar!',
                      style: TextStyle(
                        fontFamily: 'MyFont',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => TextField(
                    style: const TextStyle(fontFamily: 'myfont'),
                    maxLength: 20,
                    controller: _nameController,
                    decoration: InputDecoration(
                      counterText: '',
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: neutralBlack,
                      ),
                      label: const Text(
                        'Nama',
                        style: TextStyle(fontFamily: 'myfont'),
                      ),
                      labelStyle: const TextStyle(color: neutralBlack),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: neutralBlack),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primary700),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
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
                      errorText: controller.nameError.value,
                    ),
                    onChanged: (value) => controller.validateName(value),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => TextField(
                    style: const TextStyle(fontFamily: 'myfont'),
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: neutralBlack,
                      ),
                      label: const Text(
                        'Email',
                        style: TextStyle(fontFamily: 'myfont'),
                      ),
                      labelStyle: const TextStyle(color: neutralBlack),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: neutralBlack),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primary700),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
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
                      errorText: controller.emailError.value,
                    ),
                    onChanged: (value) => controller.validateEmail(value),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => TextField(
                    style: const TextStyle(fontFamily: 'myfont'),
                    controller: _passwordController,
                    obscureText: controller.isObscure.value,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.password_outlined,
                        color: neutralBlack,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isObscure.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                        ),
                        onPressed: () => controller.toggleObscure(),
                      ),
                      label: const Text(
                        'Password',
                        style: TextStyle(fontFamily: 'myfont'),
                      ),
                      labelStyle: const TextStyle(color: neutralBlack),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: neutralBlack),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primary700),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
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
                      errorText: controller.passwordError.value,
                    ),
                    onChanged: (value) => controller.validatePassword(value),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => TextField(
                    style: const TextStyle(fontFamily: 'myfont'),
                    controller: _passwordConfirmController,
                    obscureText: controller.isConfirmObscure.value,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.password_outlined,
                        color: neutralBlack,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isConfirmObscure.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                        ),
                        onPressed: () => controller.toggleConfirmObscure(),
                      ),
                      label: const Text(
                        'Konfirmasi Password',
                        style: TextStyle(fontFamily: 'myfont'),
                      ),
                      labelStyle: const TextStyle(color: neutralBlack),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: neutralBlack),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primary700),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
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
                      errorText: controller.passwordConfirmError.value,
                    ),
                    onChanged: (value) =>
                        controller.validatePasswordConfirmation(
                            _passwordController.text,
                            _passwordConfirmController.text),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "Sudah Punya Akun?",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'myfont',
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: ' Login',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontFamily: 'myfont',
                                fontSize: 12,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, Routes.LOGIN);
                                },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        primary700,
                        Color.fromARGB(255, 47, 0, 255),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_nameController.text.isEmpty ||
                          _emailController.text.isEmpty ||
                          _passwordConfirmController.text.isEmpty ||
                          _passwordController.text !=
                              _passwordConfirmController.text) {
                        controller.registerDialog();
                      } else {
                        authController.register(
                          _emailController.text,
                          _passwordConfirmController.text,
                          _nameController.text,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.transparent,
                    ),
                    child: const Text(
                      'Daftar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'myfont'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
