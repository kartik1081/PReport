import 'package:flutter/cupertino.dart';

class TakaListener {
  final ValueNotifier<String?> design = ValueNotifier("T.P.");

  void selectDesign(String? design) {
    this.design.value = design;
  }
}
