// ignore_for_file: file_names, empty_catches

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationListener {
  final ValueNotifier<String?> gender = ValueNotifier("Male");
  final ValueNotifier<String?> position = ValueNotifier("Owner");
  final ValueNotifier<bool> isPicked = ValueNotifier(false);
  final ValueNotifier<String> profilePic = ValueNotifier("assets/avatar.png");

  Future<String> selectGender(String gender) async {
    this.gender.value = gender;
    return gender;
  }

  Future<String> selectPosition(String position) async {
    this.position.value = position;
    return position;
  }

  void pickImage() async {
    try {
      final pickedFile = await ImagePicker()
          // ignore: deprecated_member_use
          .getImage(source: ImageSource.gallery, imageQuality: 100);
      if (pickedFile != null) {
        isPicked.value ? null : isPicked.value = !isPicked.value;
        profilePic.value = pickedFile.path;
      }
    } catch (e) {}
  }
}
