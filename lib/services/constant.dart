import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:preport/services/ValueListener/takaListener.dart';
import 'package:preport/services/basic.dart';
import 'package:preport/services/fire.dart';
import 'package:preport/services/models/company_candidate.dart';
import 'package:preport/services/models/current.dart';
import 'package:preport/services/models/lists.dart';
import 'package:preport/services/providers/currentProvider.dart';
import 'package:provider/provider.dart';

import 'ValueListener/listListener.dart';

final fire = Fire();
final service = BasicService();
final lists = Lists();

final listListener = ListListener();
final takaListener = TakaListener();

final auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

const white = Colors.white;
const black = Colors.black;
// const appbar = Color(0xff4272f1);
// const listtile = Color.fromARGB(255, 194, 225, 250);
// const background = Color.fromARGB(255, 255, 255, 255);
// const button = Color.fromARGB(255, 241, 66, 66);
const button = Color.fromARGB(255, 241, 66, 66);
const appbar = Color(0xff2e3a59);
const background = Color(0xffffffff);
const listtile = Color(0xffedf1f7);

height(double height) => SizedBox(
      height: height,
    );

width(double width) => SizedBox(
      width: width,
    );

backButton(BuildContext context) => IconButton(
    onPressed: () => Navigator.pop(context),
    icon: const Icon(Icons.arrow_back));
