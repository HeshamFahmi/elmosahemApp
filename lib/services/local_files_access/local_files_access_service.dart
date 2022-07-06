import 'dart:io';

import '../../exceptions/local_files_handling/image_picking_exceptions.dart';
import '../../exceptions/local_files_handling/local_file_handling_exception.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<String> choseImageFromLocalFiles(
  BuildContext context, {
  int maxSizeInKB = 1024,
  int minSizeInKB = 5,
}) async {
  final PermissionStatus photoPermissionStatus =
      await Permission.photos.request();
  if (!photoPermissionStatus.isGranted) {
    throw LocalFileHandlingStorageReadPermissionDeniedException(
        message: "برجاء السماح بالوصول الي التخزين");
  }

  final imgPicker = ImagePicker();
  final imgSource = await showDialog(
    builder: (context) {
      return AlertDialog(
        title: Text("اختر مصدرالصوره"),
        actions: [
          FlatButton(
            child: Text("الكاميرا"),
            onPressed: () {
              Navigator.pop(context, ImageSource.camera);
            },
          ),
          FlatButton(
            child: Text("الجاليري"),
            onPressed: () {
              Navigator.pop(context, ImageSource.gallery);
            },
          ),
        ],
      );
    },
    context: context,
  );
  if (imgSource == null)
    throw LocalImagePickingInvalidImageException(
        message: "لم يتم تحديد مصدر الصوره");
  final PickedFile imagePicked = await imgPicker.getImage(source: imgSource);
  if (imagePicked == null) {
    throw LocalImagePickingInvalidImageException();
  } else {
    final fileLength = await File(imagePicked.path).length();
    if (fileLength > (maxSizeInKB * 1024) ||
        fileLength < (minSizeInKB * 1024)) {
      throw LocalImagePickingFileSizeOutOfBoundsException(
          message: "الصوره لا يجب ان تتخطي ال 1 ميجابايت");
    } else {
      return imagePicked.path;
    }
  }
}
