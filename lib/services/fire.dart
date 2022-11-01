import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:preport/pages/chooseUser.dart';
import 'package:preport/pages/registration.dart';
import 'package:preport/pages/splash.dart';
import 'package:preport/services/ValueListener/registrationListener.dart';
import 'package:preport/services/ValueListener/valueListener.dart';
import 'package:preport/services/basic.dart';
import 'package:preport/services/models/current.dart';

import '../pages/home.dart';
import 'models/company_candidate.dart';

class Fire {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final BasicService _service = BasicService();
  final ValueListener _valueListener = ValueListener();

  String currentUserId() {
    return _auth.currentUser!.uid;
  }

  Stream<bool> checkCurrentUser() {
    return _auth
        .authStateChanges()
        .map((event) => event != null ? true : false);
  }

  Future<void> signIn(
      BuildContext context, String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (value) =>
                _firestore.collection("Company").doc(value.user!.uid).update(
              {
                "signIn": DateTime.now(),
              },
            ),
          );
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> signUp(
      BuildContext context, String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => _service
                .navigat(
                  context,
                  Registration(user: value.user!),
                )
                .whenComplete(
                  () =>
                      _firestore.collection("Company").doc(value.user!.uid).set(
                    {
                      "signUp": DateTime.now(),
                      "singIn": DateTime.now(),
                    },
                  ),
                ),
          );
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<void> signOut(BuildContext context) async {
    _auth
        .signOut()
        .whenComplete(() => _service.navigat(context, const Splash()));
  }

  Future<void> registrationAbort(BuildContext context) async {
    _firestore.collection("Company").doc(currentUserId()).delete().whenComplete(
          () => _auth.currentUser!.delete(),
        );
  }

  Future<void> storeCompanyDetail(Map<String, dynamic> data) async {
    await _firestore.collection("Company").doc(data["company_id"]).set(data);
  }

  Future<void> storeCandidateDetail(Map<String, dynamic> data) async {
    await _firestore
        .collection("Company")
        .doc(currentUserId())
        .collection("Candidates")
        .add(data)
        .then(
          (value) => value.update(
            {
              "candidate_id": value.id,
              "registered_date": DateTime.now(),
              "profile_pic":
                  "https://firebasestorage.googleapis.com/v0/b/p-report-c7ffc.appspot.com/o/avatar.png?alt=media&token=8f763984-d43a-4e41-b341-c7398a232e2d",
            },
          ),
        );
  }

  Stream<List<Candidate>> getCandidates() {
    return _firestore
        .collection("Company")
        .doc(currentUserId())
        .collection("Candidates")
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (document) => Candidate.fromJson(
                  document.data(),
                ),
              )
              .toList(growable: true),
        );
  }

  Future<CurrentCompany> getCompanyDetail() async {
    return _firestore.collection("Company").doc(currentUserId()).get().then(
          (value) => CurrentCompany.fromJson(value.data()!),
        );
  }
}
