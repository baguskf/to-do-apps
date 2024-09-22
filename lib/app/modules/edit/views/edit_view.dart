import 'dart:io';

import 'package:another_dashed_container/another_dashed_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todoapps/app/controllers/firestore_controller.dart';
import 'package:todoapps/colors/colors.dart';

import '../controllers/edit_controller.dart';
import 'package:path/path.dart' as path;

class EditView extends GetView<EditController> {
  EditView({super.key});
  final _nameC = TextEditingController();
  final _dosenC = TextEditingController();
  final _notesC = TextEditingController();
  final firestore = Get.find<FirestoreController>();

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final String docId = arguments['docId'];
    final String userId = arguments['userId'];

    controller.clearFiles();
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
                'Edit Tugas',
                style: TextStyle(color: Colors.white, fontFamily: 'myfont'),
              ),
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getData(userId, docId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              _nameC.text = data["matkul"];
              _dosenC.text = data["dosen"];
              controller.dateController.value = data["tanggal"];
              _notesC.text = data["note"];

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          TextField(
                            controller: _nameC,
                            style: const TextStyle(
                                fontFamily: 'myfont', fontSize: 20),
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
                            style: const TextStyle(
                                fontFamily: 'myfont', fontSize: 20),
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
                              style: const TextStyle(
                                  fontFamily: 'myfont', fontSize: 20),
                              controller: TextEditingController(
                                  text: controller.dateController.value),
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () =>
                                      controller.selectDate(context),
                                  icon:
                                      const Icon(Icons.calendar_month_outlined),
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
                              style: const TextStyle(
                                  fontFamily: 'myfont', fontSize: 20),
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
                                Obx(() {
                                  if (controller.selectedFiles.isNotEmpty) {
                                    return Column(
                                      children: [
                                        ...controller.selectedFiles.map((file) {
                                          final fileName =
                                              path.basename(file.path);
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            child: GestureDetector(
                                              child: Text(
                                                "* $fileName",
                                                style: const TextStyle(
                                                  fontFamily: 'myfont',
                                                  color: Colors.blue,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        TextButton(
                                          onPressed: () {
                                            controller.clearFiles();
                                          },
                                          child: const Text("Clear files"),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: data["files"].length,
                                            itemBuilder: (context, index) {
                                              final fileUrl =
                                                  data["files"][index];
                                              final fileName = fileUrl
                                                  .split('/')
                                                  .last
                                                  .split('?')
                                                  .first;
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                child: GestureDetector(
                                                  child: Text(
                                                    "* $fileName",
                                                    style: TextStyle(
                                                      fontFamily: 'myfont',
                                                      color: Colors.blue,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            controller.pickFile();
                                          },
                                          child: const Text("Ganti file"),
                                        ),
                                      ],
                                    );
                                  }
                                }),
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
                                (controller.dateController.value?.isEmpty ??
                                    true)) {
                              Get.dialog(
                                AlertDialog(
                                  title: const Text('Gagal Menyimpan'),
                                  content: const Text(
                                      'File Bertanda * Wajib Diisi!'),
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
                              print(
                                  "Editing data for: ${_nameC.text}, ${_dosenC.text}, ${controller.dateController.value ?? ''}, ${_notesC.text}, $userId, $docId");
                              controller.editData(
                                  _nameC.text,
                                  _dosenC.text,
                                  controller.dateController.value ?? '',
                                  _notesC.text,
                                  userId,
                                  docId);
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
                            'Update',
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
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
