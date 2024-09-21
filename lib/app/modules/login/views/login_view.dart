import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:todoapps/app/controllers/firebaseauth_controller.dart';

import 'package:todoapps/app/routes/app_pages.dart';

import 'package:todoapps/colors/colors.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authController = Get.find<FirebaseauthController>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: Image.asset(
                      'assets/images/catat.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(1),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 30,
                  left: 15,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Datang!',
                        style: TextStyle(
                          color: neutralWhite,
                          fontSize: 30,
                          fontFamily: 'myfont',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Catat PR, Capai Tujuanmu',
                        style: TextStyle(
                          color: neutralWhite,
                          fontSize: 20,
                          fontFamily: 'myfont',
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(45.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Silahkan Login!',
                          style: TextStyle(
                            fontFamily: 'myfont',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        textAlign: TextAlign.right,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: ' Lupa Password?',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontFamily: 'myfont',
                                fontSize: 12,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  controller.resetPasswordDialog();
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
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
                      onPressed: () => authController.login(
                          _emailController.text, _passwordController.text),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.transparent,
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'myfont'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                                text: "Belum Punya Akun?",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'myfont',
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: ' Daftar',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontFamily: 'myfont',
                                  fontSize: 12,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                        context, Routes.REGISTER);
                                  },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
