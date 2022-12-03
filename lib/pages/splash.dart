import 'dart:async';

import 'package:flutter/material.dart';
import 'package:preport/pages/chooseUser.dart';
import 'package:preport/services/basic.dart';
import 'package:preport/services/constant.dart';
import 'package:preport/services/ValueListener/valueListener.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _email;
  late TextEditingController _password;
  final BasicService _service = BasicService();
  late Widget _logoWidget;

  double _paddingValue = 200.0;
  double _containerOpacity = 0.0;
  Widget _logWidget = const SizedBox();
  bool after = false;

  final ValueListener _valueListener = ValueListener();

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _logoWidget = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: const [
        Text(
          "P",
          style: TextStyle(
            color: button,
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Report",
          style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
        )
      ],
    );
    Timer(
      const Duration(seconds: 3),
      () => fire.checkCurrentUser().listen((value) => !value
          ? setState(() {
              _paddingValue = 0.0;
              logo(context);
            })
          : _service.navigat(context, ChooseUser())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: ValueListenableBuilder<bool>(
              valueListenable: _valueListener.loading,
              builder: (context, value, child) => value
                  ? const CircularProgressIndicator()
                  : Container(
                      padding: const EdgeInsets.only(
                        left: 30.0,
                        right: 30.0,
                      ),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width - 30.0,
                      child: AnimatedPadding(
                        duration: const Duration(milliseconds: 1500),
                        padding: EdgeInsets.only(top: _paddingValue),
                        curve: Curves.bounceOut,
                        onEnd: () => setState(() {
                          _containerOpacity = 1.0;
                          logoImage(context);
                        }),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 200.0,
                              width: 200.0,
                              child: AnimatedSwitcher(
                                  duration: const Duration(microseconds: 500),
                                  transitionBuilder: (child, animation) =>
                                      ScaleTransition(
                                        scale: animation,
                                        child: child,
                                      ),
                                  child: _logWidget),
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              transitionBuilder: (child, animation) =>
                                  ScaleTransition(
                                scale: animation,
                                child: child,
                              ),
                              child: _logoWidget,
                            ),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: _containerOpacity,
                              curve: Curves.easeInOut,
                              child: Container(
                                key: const ValueKey(2),
                                margin: const EdgeInsets.only(top: 30.0),
                                padding: const EdgeInsets.all(20.0),
                                decoration: const BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _email,
                                        enableSuggestions: true,
                                        autocorrect: true,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter Email";
                                          }
                                          if (!_service.emailRegex
                                              .hasMatch(value)) {
                                            return "Please enter valid Email";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(Icons.mail),
                                          hintText: "Enter Email",
                                          hintStyle: const TextStyle(
                                              color: Colors.grey),
                                          fillColor: Colors.white,
                                          filled: true,
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  13.0, 10.0, 0.0, 10.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 0.0000000001,
                                                color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 0.0000000001,
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      TextFormField(
                                        controller: _password,
                                        enableSuggestions: true,
                                        autocorrect: true,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: true,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter Password";
                                          }
                                          if (value.length < 8) {
                                            return "minimum required length 8";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          prefixIcon:
                                              const Icon(Icons.password),
                                          hintText: "Enter Password",
                                          hintStyle: const TextStyle(
                                              color: Colors.grey),
                                          fillColor: Colors.white,
                                          filled: true,
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  13.0, 10.0, 0.0, 10.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 0.0000000001,
                                                color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 0.0000000001,
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      FloatingActionButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (!after) {
                                              fire.signIn(context, _email.text,
                                                  _password.text);
                                            } else {
                                              fire.signUp(context, _email.text,
                                                  _password.text);
                                            }

                                            _email.clear();
                                            _password.clear();
                                          }
                                          // _valueListener.changeLoading();
                                        },
                                        backgroundColor: Colors.redAccent,
                                        child: const Icon(
                                          Icons.arrow_right_alt,
                                          size: 45.0,
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                            onTap: () => setState(() {
                                                  after = _valueListener
                                                      .before.value;
                                                  _valueListener.afterSignIn();
                                                }),
                                            child: SizedBox(
                                              height: 30,
                                              width: 150.0,
                                              // color: Colors.red,
                                              child: Center(
                                                child: ValueListenableBuilder<
                                                    String>(
                                                  valueListenable:
                                                      _valueListener.bottomText,
                                                  builder:
                                                      (context, value, _) =>
                                                          Text(
                                                    value,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  void logo(BuildContext context) {
    _logoWidget = ValueListenableBuilder(
      valueListenable: _valueListener.title,
      builder: (context, value, child) => Text(
        value,
        style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500),
      ),
    );
  }

  void logoImage(BuildContext context) {
    _logWidget = Container(
      margin: const EdgeInsets.symmetric(vertical: 40.0),
      child: const Image(
        image: AssetImage("assets/signIn.png"),
      ),
    );
  }
}
