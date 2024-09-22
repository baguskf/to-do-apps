import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddDataController extends GetxController {
  var selectedFiles = <File>[].obs;
  var dateController = RxnString();
  DateTime? selectedDate;

  @override
  void onInit() {
    super.onInit();
    resetDate();
  }

  void resetDate() {
    selectedDate = null;
    dateController.value = '';
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
}
