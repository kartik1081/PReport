// ignore_for_file: empty_catches

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:preport/pages/registration.dart';
import 'package:preport/pages/splash.dart';
import 'package:preport/services/models/current.dart';
import 'package:preport/services/models/prod/taka.dart';

import 'constant.dart';
import 'models/beem/beem.dart';
import 'models/company_candidate.dart';
import 'models/prod/company.dart';

class Fire {
  final Taka _taka = Taka();

  String currentUserId() {
    return auth.currentUser!.uid;
  }

  Stream<bool> checkCurrentUser() {
    return auth.authStateChanges().map((event) => event != null ? true : false);
  }

  Future<void> signIn(
      BuildContext context, String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (value) =>
                firestore.collection("Company").doc(value.user!.uid).update(
              {
                "signIn": DateTime.now(),
              },
            ),
          );
    } on FirebaseAuthException {}
  }

  Future<void> signUp(
      BuildContext context, String email, String password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => service
                .navigat(
                  context,
                  Registration(user: value.user!),
                )
                .whenComplete(
                  () =>
                      firestore.collection("Company").doc(value.user!.uid).set(
                    {
                      "signUp": DateTime.now(),
                      "singIn": DateTime.now(),
                    },
                  ),
                ),
          );
    } on FirebaseAuthException {}
    return;
  }

  Future<void> signOut(BuildContext context) async {
    auth.signOut().whenComplete(() => service.navigat(context, const Splash()));
  }

  Future<void> registrationAbort(BuildContext context) async {
    firestore.collection("Company").doc(currentUserId()).delete().whenComplete(
          () => auth.currentUser!.delete(),
        );
  }

  Future<void> storeCompanyDetail(Map<String, dynamic> data) async {
    await firestore.collection("Company").doc(data["company_id"]).set(data);
  }

  Future<void> storeCandidateDetail(Map<String, dynamic> data) async {
    await firestore
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
    return firestore
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
    return firestore.collection("Company").doc(currentUserId()).get().then(
          (value) => CurrentCompany.fromJson(value.data()!),
        );
  }

  Future<void> storeBeemDetail(Map<String, dynamic> data, String code) async {
    await firestore
        .collection("Company")
        .doc(currentUserId())
        .collection("Lists")
        .doc("Details")
        .collection(code == "0"
            ? "Warpar List"
            : code == "1"
                ? "Quality List"
                : "Yarn List")
        .doc(data["id"])
        .set(data);
  }

  Future<void> storeProdDetail(Map<String, dynamic> data, String code) async {
    await firestore
        .collection("Company")
        .doc(currentUserId())
        .collection("Lists")
        .doc("Details")
        .collection(code == "0"
            ? "Book List"
            : code == "1"
                ? "Party List"
                : "Quality List")
        .doc(data["id"])
        .set(data);
  }

  Future<void> storeBeem(
      BuildContext context, Map<String, dynamic> data) async {
    firestore
        .collection("Company")
        .doc(currentUserId())
        .collection("Beem")
        .doc("BeemList")
        .collection("Total")
        .doc(data["id"])
        .set(data)
        .whenComplete(() => firestore
            .collection("Company")
            .doc(currentUserId())
            .collection("Beem")
            .doc("BeemList")
            .collection("Stoke")
            .doc(data["id"])
            .set(data)
            .whenComplete(
                () => service.toast(context, "Beem store successfully")));
  }

  Future<void> storeTaka(Map<String, dynamic> data) async {
    await firestore
        .collection("Company")
        .doc(currentUserId())
        .collection("Prod")
        .doc("Taka")
        .collection("Total")
        .doc(data["id"])
        .set(data)
        .whenComplete(() async => await firestore
            .collection("Company")
            .doc(currentUserId())
            .collection("Prod")
            .doc("Taka")
            .collection("Stoke")
            .doc(data["id"])
            .set(data));
  }

  Stream<List<Beem>> getStokeBeem() {
    return firestore
        .collection("Company")
        .doc(currentUserId())
        .collection("Beem")
        .doc("BeemList")
        .collection("Stoke")
        .orderBy("arriving_time", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (document) => Beem.fromJson(
                  document.data(),
                ),
              )
              .toList(growable: true),
        );
  }

  Future<void> loadBeem(Beem beem) async {
    firestore
        .collection("Company")
        .doc(currentUserId())
        .collection("Beem")
        .doc("BeemList")
        .collection("Stoke")
        .doc(beem.id)
        .delete()
        .whenComplete(
          () => service.beemToMap(beem).then(
            (map) {
              firestore
                  .collection("Company")
                  .doc(currentUserId())
                  .collection("Beem")
                  .doc("BeemList")
                  .collection("Total")
                  .doc(beem.id)
                  .update({"loading_date": map["loading_date"]}).whenComplete(
                      () => firestore
                          .collection("Company")
                          .doc(currentUserId())
                          .collection("Beem")
                          .doc("BeemList")
                          .collection("Running")
                          .doc(beem.id)
                          .set(map));
            },
          ),
        );
  }

  Stream<List<Taka>> getTaka() {
    return firestore
        .collection("Company")
        .doc(auth.currentUser!.uid)
        .collection("Prod")
        .doc("Taka")
        .collection("Total")
        .orderBy("added_time", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => Taka.fromJson(document.data()))
            .toList(growable: true));
  }

  Future<void> sellTaka(Taka taka, Company company, String soldPrice) async {
    DateTime now = DateTime.now();

    firestore
        .collection("Company")
        .doc(currentUserId())
        .collection("Prod")
        .doc("Taka")
        .collection("Total")
        .doc(taka.id)
        .update({
      "sold_to_code": company.code,
      "sold_to_name": company.name,
      "sold_price": soldPrice,
      "sold_time": now
    }).whenComplete(() => firestore
            .collection("Company")
            .doc(currentUserId())
            .collection("Prod")
            .doc("Taka")
            .collection("Stoke")
            .doc(taka.id)
            .delete()
            .whenComplete(() async => _taka
                .takaToMap(taka, company, soldPrice, now)
                .then((data) async => await firestore
                    .collection("Company")
                    .doc(currentUserId())
                    .collection("Prod")
                    .doc("Taka")
                    .collection("Sold")
                    .doc(taka.id)
                    .set(data)
                    .whenComplete(() => firestore
                        .collection("Company")
                        .doc(currentUserId())
                        .collection("Companies")
                        .doc(company.id)
                        .collection("Sell History")
                        .add(data)))));
  }
}
