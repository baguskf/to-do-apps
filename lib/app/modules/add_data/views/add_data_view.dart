import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todoapps/app/controllers/firestore_controller.dart';
import 'package:todoapps/colors/colors.dart';
import 'package:another_dashed_container/another_dashed_container.dart';
import 'package:path/path.dart' as path;

import '../controllers/add_data_controller.dart';

class AddDataView extends GetView<AddDataController> {
  AddDataView({super.key});
  final String userId = Get.arguments as String;
  final _nameC = TextEditingController();
  final _dosenC = TextEditingController();
  final _notesC = TextEditingController();

  final firestore = Get.put(FirestoreController());

  @override
  Widget build(BuildContext context) {
    print('Cek UID : ${userId}');
    controller.resetInputs();
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
              'Tambah Tugas',
              style: TextStyle(color: Colors.white, fontFamily: 'myfont'),
            ),
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  TextField(
                    controller: _nameC,
                    style: const TextStyle(fontFamily: 'myfont', fontSize: 20),
                    cursorColor: neutralBlack,
                    decoration: const InputDecoration(
                      labelText: 'Mata Pelajaran',
                      labelStyle: TextStyle(
                          fontFamily: 'myfont',
                          fontSize: 20,
                          color: neutralBlack),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primary700),
                      ),
                    ),
                  ),
                  const Positioned(
                    right: 0,
                    top: 12,
                    child: Text(
                      '*',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Stack(
                children: [
                  TextField(
                    controller: _dosenC,
                    style: const TextStyle(fontFamily: 'myfont', fontSize: 20),
                    cursorColor: neutralBlack,
                    decoration: const InputDecoration(
                      labelText: 'Nama Guru/Dosen',
                      labelStyle: TextStyle(
                          fontFamily: 'myfont',
                          fontSize: 20,
                          color: neutralBlack),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primary700),
                      ),
                    ),
                  ),
                  const Positioned(
                    right: 0,
                    top: 12,
                    child: Text(
                      '*',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Stack(
                children: [
                  Obx(() {
                    return TextField(
                      onTap: () => controller.selectDate(context),
                      readOnly: true,
                      style:
                          const TextStyle(fontFamily: 'myfont', fontSize: 20),
                      controller: TextEditingController(
                          text: controller.dateController.value),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () => controller.selectDate(context),
                          icon: const Icon(Icons.calendar_month_outlined),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Batas Waktu',
                        labelStyle: const TextStyle(
                          fontFamily: 'myfont',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }),
                  const Positioned(
                    right: 0,
                    top: 12,
                    child: Text(
                      '*',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Catatan (opsional)',
                style: TextStyle(
                  fontFamily: 'myfont',
                  fontSize: 20,
                  color: neutralBlack,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: neutralBlack),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _notesC,
                      maxLines: null,
                      style:
                          const TextStyle(fontFamily: 'myfont', fontSize: 20),
                      cursorColor: neutralBlack,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelStyle: TextStyle(
                          fontFamily: 'myfont',
                          fontSize: 20,
                          color: neutralBlack,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              DashedContainer(
                dashColor: Colors.black,
                borderRadius: 20.0,
                dashedLength: 5.0,
                blankLength: 10.0,
                strokeWidth: 2.0,
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Obx(
                          () {
                            if (controller.selectedFiles.isEmpty) {
                              return Column(
                                children: [
                                  const Text(
                                    'Upload File (Opsional)',
                                    style: TextStyle(
                                        fontFamily: 'myfont', fontSize: 15),
                                  ),
                                  const Text(
                                    "'pdf', 'doc', 'docx', 'jpg', 'png'",
                                    style: TextStyle(
                                        fontFamily: 'myfont', fontSize: 15),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      controller.pickFile();
                                    },
                                    child: const Text("Upload file"),
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ...controller.selectedFiles.map(
                                    (file) => Text(
                                      "* File: ${path.basename(file.path)}",
                                      style: const TextStyle(
                                          fontFamily: 'myfont', fontSize: 15),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      controller.clearFiles();
                                    },
                                    child: const Text("Clear file"),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
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
                    if (_nameC.text.isEmpty ||
                        _dosenC.text.isEmpty ||
                        (controller.dateController.value?.isEmpty ?? true)) {
                      Get.dialog(
                        AlertDialog(
                          title: const Text('Gagal Menyimpan'),
                          content: const Text('File Bertanda * Wajib Diisi!'),
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
                    } else {
                      firestore.upload(
                          _nameC.text,
                          _dosenC.text,
                          controller.dateController.value ?? '',
                          _notesC.text,
                          userId);
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
                    'Simpan',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'myfont'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
