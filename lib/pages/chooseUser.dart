// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:preport/pages/home.dart';
import 'package:preport/services/constant.dart';
import 'package:preport/services/providers/currentProvider.dart';
import 'package:provider/provider.dart';
import '../services/models/company_candidate.dart';

class ChooseUser extends StatelessWidget {
  ChooseUser({required this.candidateList, super.key});
  List<Candidate> candidateList;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: appbar,
          automaticallyImplyLeading: false,
          title: const Text("Choose User"),
          actions: const [],
        ),
        body: candidateStream(context),
      ),
    );
  }

  Widget candidateStream(BuildContext context) {
    return ListView.builder(
      itemCount: candidateList.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(10.0),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => userTile(context, candidateList[index]),
    );
  }

  Widget userTile(BuildContext context, Candidate candidate) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5.0),
      decoration: const BoxDecoration(
        color: listtile,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: ListTile(
        minVerticalPadding: 10.0,
        onTap: () => enterPassword(context, candidate),
        title: Text(
          candidate.name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          candidate.position,
          style: const TextStyle(fontSize: 12.0),
        ),
        leading: Image(
          image: NetworkImage(candidate.profilePic),
        ),
      ),
    );
  }

  void enterPassword(BuildContext context, Candidate candidate) {
    showDialog(
      context: context,
      builder: (context) => ChangeNotifierProvider<CurrentProvider>(
        create: (context) => CurrentProvider(),
        builder: (context, child) => AlertDialog(
          title: const Text("Enter Password"),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _password,
              obscureText: true,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                hintText: "Enter Password",
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
                fillColor: Colors.white,
                filled: true,
                constraints: const BoxConstraints(
                  maxHeight: 40.0,
                ),
                contentPadding: const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 10.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 0.0000000001, color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 0.0000000001, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                dismissDialog(context);
              },
              child: const Text('cancle'),
            ),
            Consumer<CurrentProvider>(
              builder: (context, currentProvider, child) => TextButton(
                onPressed: () {
                  currentProvider.currentCandidateDetail(candidate).then(
                        (value) => currentProvider.getCompanyDetail().then(
                              (value) => passwordValidate(
                                context,
                                _password.text,
                                currentProvider.currentCandidate.password!,
                              ).then(
                                (value) {
                                  if (value) {
                                    dismissDialog(context);
                                    service.navigat(
                                      context,
                                      Home(
                                        currentCompany:
                                            currentProvider.currentCompany,
                                        currentCandidate:
                                            currentProvider.currentCandidate,
                                        candidateList: candidateList,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                      );
                },
                child: const Text('Ok'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void dismissDialog(BuildContext context) {
    Navigator.pop(context);
    _password.clear();
  }

  Future<bool> passwordValidate(
      BuildContext context, String password, String candidatePassword) async {
    if (password.isEmpty) {
      service.toast(context, "Please enter password");
      return false;
    }
    if (password != candidatePassword) {
      service.toast(context, "Please enter valid password");
      return false;
    }
    return true;
  }
}
