import 'package:flutter/material.dart';

class PasswordView {
  final ValueNotifier<Widget> passwordView =
      ValueNotifier(const Icon(Icons.visibility));
  final ValueNotifier<Widget> confirmPasswordView =
      ValueNotifier(const Icon(Icons.visibility));
  final ValueNotifier<bool> passwordVisibility = ValueNotifier(false);
  final ValueNotifier<bool> confirmPasswordVisibility = ValueNotifier(false);

  void viewPassword() {
    passwordVisibility.value = !passwordVisibility.value;
    passwordView.value = passwordVisibility.value
        ? const Icon(Icons.visibility)
        : const Icon(Icons.visibility_off);
  }

  void viewConfirmPassword() {
    confirmPasswordVisibility.value = !confirmPasswordVisibility.value;
    confirmPasswordView.value = confirmPasswordVisibility.value
        ? const Icon(Icons.visibility)
        : const Icon(Icons.visibility_off);
  }
}
