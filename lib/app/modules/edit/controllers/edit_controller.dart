import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoapps/app/routes/app_pages.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

class EditController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var selectedFiles = <File>[].obs;
  var existingFiles = <String>[].obs;
  var dateController = RxnString();
  DateTime? selectedDate;
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void onInit() {
    super.onInit();
    getFilesFromFirebaseStorage();
    clearFiles();
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
    );

    if (result != null) {
      selectedFiles.value = result.paths.map((path) => File(path!)).toList();
    } else {
      print('gajadi');
    }
  }

  void clearFiles() {
    selectedFiles.clear();
  }

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateController.value = DateFormat('d MMM yyyy').format(selectedDate!);
    }
  }

  Future<DocumentSnapshot<Object?>> getData(String userId, String docID) async {
    DocumentReference docRef = firestore
        .collection('data')
        .doc(userId)
        .collection('dataUser')
        .doc(docID);

    return docRef.get();
  }

  Future<void> getFilesFromFirebaseStorage() async {
    existingFiles.clear();
    final storageRef = FirebaseStorage.instance.ref();
    final listResult = await storageRef.child('folder_di_storage').listAll();

    for (var item in listResult.items) {
      final fileUrl = await item.getDownloadURL();
      existingFiles.add(fileUrl);
    }
  }

  Future<void> downloadFileAndAddToPicker(String fileUrl) async {
    try {
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/${fileUrl.split('/').last}';

      Dio dio = Dio();
      await dio.download(fileUrl, filePath);

      File file = File(filePath);
      addFileToFilePicker(file);
    } catch (e) {
      print("Error downloading file: $e");
    }
  }

  void addFileToFilePicker(File file) {
    selectedFiles.add(file);
  }

  void editData(
    String matkul,
    String dosen,
    String tanggal,
    String note,
    String userId,
    String docID,
  ) async {
    DocumentReference docRef = firestore
        .collection('data')
        .doc(userId)
        .collection('dataUser')
        .doc(docID);

    List<String> newFileUrls = [];
    List<String> oldFileUrls = [];

    var existingData = await docRef.get();
    if (existingData.exists) {
      oldFileUrls = List<String>.from(existingData['files'] ?? []);
    }

    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    if (selectedFiles.isNotEmpty) {
      var fileID = const Uuid();
      try {
        for (File file in selectedFiles) {
          String fileName = path.basename(file.path);
          Reference ref = storage.ref().child('${fileID.v4()}_$fileName');

          await ref.putFile(file);

          String downloadUrl = await ref.getDownloadURL();
          newFileUrls.add(downloadUrl);
        }
      } catch (e) {
        Get.back();
        Get.snackbar('Gagal', 'Terjadi kesalahan saat mengunggah file.',
            margin: EdgeInsets.all(20), snackPosition: SnackPosition.BOTTOM);
        return;
      }
    }

    if (newFileUrls.isEmpty) {
      newFileUrls = oldFileUrls;
    } else {
      for (String oldFileUrl in oldFileUrls) {
        try {
          Reference oldFileRef = storage.refFromURL(oldFileUrl);
          await oldFileRef.delete();
        } catch (e) {
          print("Error deleting old file: $e");
        }
      }
    }

    try {
      await docRef.update({
        "matkul": matkul,
        "dosen": dosen,
        "tanggal": tanggal,
        "note": note,
        "files": newFileUrls,
        "createdAt": FieldValue.serverTimestamp(),
      });

      Get.back();

      Get.snackbar('Sukses', 'Data berhasil diperbarui.',
          margin: EdgeInsets.all(20), snackPosition: SnackPosition.BOTTOM);

      Get.offAllNamed(Routes.DETAIL, arguments: {
        'userId': userId,
        'docId': docID,
      });
    } on FirebaseException catch (e) {
      Get.back();

      Get.snackbar('Gagal', 'Data gagal diperbarui. Error: ${e.message}',
          margin: EdgeInsets.all(20), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
