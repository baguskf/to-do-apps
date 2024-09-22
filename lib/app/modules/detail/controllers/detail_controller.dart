import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'dart:io';

class DetailController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<DocumentSnapshot<Object?>> getData(String userId, String docID) async {
    DocumentReference docRef = firestore
        .collection('data')
        .doc(userId)
        .collection('dataUser')
        .doc(docID);

    return docRef.get();
  }

  Future<void> downloadFile(String url) async {
    final dio = Dio();
    try {
      final directory = Directory('/storage/emulated/0/Download');

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final fileName = url.split('/').last.split('?').first;
      final filePath = '${directory.path}/$fileName';

      await dio.download(url, filePath);

      print('Download Sukses. File telah diunduh ke $filePath');
      Get.snackbar(
        'Download Sukses',
        'File berhasil diunduh ke $filePath',
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      );
    } catch (e) {
      Get.snackbar(
        'Download Gagal',
        'Terjadi kesalahan saat mengunduh file.',
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      );
    }
  }
}
