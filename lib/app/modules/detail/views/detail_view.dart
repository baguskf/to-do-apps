import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF6200EE),
                Color.fromARGB(255, 47, 0, 255),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: const Text(
              'Detail Tugas',
              style: TextStyle(color: Colors.white, fontFamily: 'myfont'),
            ),
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'DetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
