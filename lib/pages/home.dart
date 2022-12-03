import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:preport/pages/beem/beems.dart';
import 'package:preport/pages/taka/dailyTaka.dart';
import 'package:preport/services/basic.dart';
import 'package:preport/services/constant.dart';
import 'package:preport/services/fire.dart';

import '../services/models/current.dart';

class Home extends StatelessWidget {
  Home(
      {required this.currentCompany,
      required this.currentCandidate,
      super.key});
  CurrentCompany currentCompany;
  CurrentCandidate currentCandidate;

  final _isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_isDialOpen.value) {
          _isDialOpen.value = false;
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: appbar,
          title: Text(currentCompany.name),
          actions: [switchAccount(context)],
        ),
        body: Center(
          child: Text(currentCandidate.name),
        ),
        floatingActionButton: floatingButtons(context),
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

  Widget floatingButtons(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20.0,
        right: 20.0,
      ),
      child: SpeedDial(
        icon: Icons.add,
        // animatedIcon: AnimatedIcons.close_menu,
        backgroundColor: button,
        overlayColor: Colors.black,
        overlayOpacity: 0.6,
        spaceBetweenChildren: 5.0,
        openCloseDial: _isDialOpen,
        children: [
          SpeedDialChild(
            label: "Taka Production",
            labelStyle: const TextStyle(fontSize: 15.0),
            child: const Icon(Icons.production_quantity_limits),
            onTap: () => service.navigat(
              context,
              DailyTaka(
                currentCandidate: currentCandidate,
              ),
            ),
          ),
          SpeedDialChild(
            label: "Bims",
            labelStyle: const TextStyle(fontSize: 15.0),
            child: const Icon(Icons.production_quantity_limits),
            onTap: () {
              service.navigat(
                context,
                Beems(currentCandidate: currentCandidate),
              );
            },
          ),
        ],
      ),
    );
  }
}
