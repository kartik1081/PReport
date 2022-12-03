// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class TakaListener {
  final ValueNotifier<String?> design = ValueNotifier("T.P.");

  void selectDesign(String? design) {
    this.design.value = design;
  }
}
