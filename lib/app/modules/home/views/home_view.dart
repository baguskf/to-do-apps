import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todoapps/app/controllers/firebaseauth_controller.dart';
import 'package:todoapps/app/routes/app_pages.dart';
import 'package:todoapps/colors/colors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final authController = Get.find<FirebaseauthController>();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    controller.getCurrentUserName();
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                primary700,
                Color.fromARGB(255, 47, 0, 255),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            onPressed: () {
              Navigator.pushNamed(context, Routes.ADD_DATA,
                  arguments: user!.uid);
            },
            shape: const CircleBorder(),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primary700,
                  Color.fromARGB(255, 47, 0, 255),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              color: neutral500,
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Halo, ',
                        style: TextStyle(
                          color: neutralWhite,
                          fontSize: 30,
                          fontFamily: 'myfont',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Obx(() {
                        return Text(
                          "${controller.currentName.value}",
                          style: const TextStyle(
                            color: neutralWhite,
                            fontSize: 15,
                            fontFamily: 'myfont',
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Jangan Lupa Dikerjakan!',
                        style: TextStyle(
                            color: neutralWhite,
                            fontSize: 20,
                            fontFamily: 'myfont',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => authController.logout(),
                    icon: const Icon(
                      Icons.login_outlined,
                      color: neutralWhite,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
