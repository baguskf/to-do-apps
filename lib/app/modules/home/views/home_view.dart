import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todoapps/app/controllers/firebaseauth_controller.dart';
import 'package:todoapps/app/controllers/firestore_controller.dart';

import 'package:todoapps/app/routes/app_pages.dart';
import 'package:todoapps/colors/colors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final firestore = Get.put(FirestoreController());

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
              Get.toNamed(Routes.ADD_DATA, arguments: user!.uid);
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
          Expanded(
            child: StreamBuilder<QuerySnapshot<Object?>>(
              stream: firestore.getData(user!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var listData = snapshot.data!.docs;
                  if (listData.isEmpty) {
                    return const Center(
                      child: Text(
                        'Tidak ada data tugas',
                        style: TextStyle(fontSize: 18, color: neutralBlack),
                      ),
                    );
                  }
                  print('ini list data $listData');
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: listData.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      child: InkWell(
                        onTap: () => Get.toNamed(Routes.DETAIL, arguments: {
                          'userId': user!.uid,
                          'docId': listData[index].id,
                        }),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${(listData[index].data() as Map<String, dynamic>)["matkul"]}",
                                        style: const TextStyle(
                                          fontFamily: 'myfont',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: neutralBlack,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Batas Waktu : ${(listData[index].data() as Map<String, dynamic>)["tanggal"]}",
                                        style: const TextStyle(
                                          fontFamily: 'myfont',
                                          color: neutralBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: neutralBlack,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
