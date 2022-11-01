import 'package:flutter/material.dart';

class ValueListener {
  final ValueNotifier<bool> loading = ValueNotifier(false);
  final ValueNotifier<bool> before = ValueNotifier(false);
  final ValueNotifier<String> title = ValueNotifier("Sign In");
  final ValueNotifier<String> bottomText = ValueNotifier("Create Account");

  void changeLoading() {
    loading.value = !loading.value;
  }

  void afterSignIn() {
    before.value = !before.value;
    changeTitle();
    changeBottomText();
  }

  void changeTitle() {
    title.value = before.value ? "Sign In" : "Sign Up";
  }

  void changeBottomText() {
    bottomText.value = before.value ? "Create Account" : "Already has Account";
  }
}
