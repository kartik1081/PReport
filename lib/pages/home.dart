import 'package:flutter/material.dart';
import 'package:preport/services/basic.dart';
import 'package:preport/services/fire.dart';

import '../services/models/current.dart';

class Home extends StatelessWidget {
  Home(
      {required this.currentCompany,
      required this.currentCandidate,
      super.key});
  CurrentCompany currentCompany;
  CurrentCandidate currentCandidate;

  final BasicService _service = BasicService();

  @override
  Widget build(BuildContext context) {
    final Fire fire = Fire();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
        title: Text(currentCompany.name),
        actions: [switchAccount(context)],
      ),
      body: Center(
        child: Text(currentCandidate.name),
      ),
    );
  }

  Widget switchAccount(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10.0),
      child: Row(
        children: const [
          Icon(Icons.keyboard_arrow_down),
          Text(
            "Switch Account",
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
