import 'package:flutter/cupertino.dart';

class ListListener {
  final ValueNotifier<String> pno = ValueNotifier("1");

  Future<void> setPno(String pno) async {
    this.pno.value = pno;
  }
}
