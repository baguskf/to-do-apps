import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todoapps/app/routes/app_pages.dart';
import 'package:todoapps/colors/colors.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final String docId = arguments['docId'];
    final String userId = arguments['userId'];
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
      body: StreamBuilder<DocumentSnapshot<Object?>>(
        stream: controller.getData(userId, docId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data["matkul"],
                              style: TextStyle(
                                fontFamily: 'myfont',
                                color: neutralBlack,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      Get.toNamed(Routes.EDIT, arguments: {
                                    'userId': userId,
                                    'docId': docId,
                                  }),
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      controller.deleteData(userId, docId),
                                  icon: Icon(Icons.delete_outline_sharp),
                                ),
                              ],
                            )
                          ],
                        ),
                        Divider(
                          color: neutralBlack,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Guru/Dosen',
                              style: TextStyle(
                                  fontFamily: 'myfont',
                                  color: neutralBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data["dosen"],
                              style: TextStyle(
                                  fontFamily: 'myfont', color: neutralBlack),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Batas Waktu',
                              style: TextStyle(
                                  fontFamily: 'myfont',
                                  color: neutralBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data["tanggal"],
                              style: TextStyle(
                                  fontFamily: 'myfont', color: neutralBlack),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Catatan : ',
                              style: TextStyle(
                                  fontFamily: 'myfont',
                                  color: neutralBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                data["note"],
                                style: TextStyle(
                                    fontFamily: 'myfont', color: neutralBlack),
                                textAlign: TextAlign.justify,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'File : ',
                              style: TextStyle(
                                  fontFamily: 'myfont',
                                  color: neutralBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            SizedBox(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: data["files"].length,
                                itemBuilder: (context, index) {
                                  final fileUrl = data["files"][index];
                                  final fileName =
                                      fileUrl.split('/').last.split('?').first;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: GestureDetector(
                                      onTap: () =>
                                          controller.downloadFile(fileUrl),
                                      child: Text(
                                        "* $fileName",
                                        style: TextStyle(
                                          fontFamily: 'myfont',
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
