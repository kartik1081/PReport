import 'package:flutter/material.dart';

class Try extends StatelessWidget {
  Try({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _password1 = TextEditingController();
  final TextEditingController _password2 = TextEditingController();
  final FocusNode _passwordNode1 = FocusNode();
  final FocusNode _passwordNode2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
          onTap: (() => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Set Password for User"),
                  content: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _password1,
                          focusNode: _passwordNode1,
                          keyboardType: TextInputType.visiblePassword,
                          onEditingComplete: () {
                            _passwordNode1.unfocus();
                            _passwordNode2.requestFocus();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Password";
                            }
                            if (value.length < 8) {
                              return "minimum required length 8";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            label: Text("Enter Password"),
                          ),
                        ),
                        TextFormField(
                          controller: _password2,
                          focusNode: _passwordNode2,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          onEditingComplete: () {
                            _passwordNode1.unfocus();
                            _passwordNode2.requestFocus();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Password";
                            }
                            if (value.length < 8) {
                              return "minimum required length 8";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            label: Text("Re-Enter Password"),
                          ),
                        )
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {},
                      child: const Text("cancle"),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_password1.text == _password2.text) {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                title: Text("data"),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text("ok"),
                    ),
                  ],
                ),
              )),
          child: const Center(child: Text("Try"))),
    );
  }
}
