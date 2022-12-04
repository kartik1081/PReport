// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:preport/pages/beem/beemAdd.dart';
import 'package:preport/pages/beem/runningBeems.dart';
import 'package:preport/pages/beem/stokeBeems.dart';
import 'package:preport/pages/beem/totalBeems.dart';
import 'package:preport/pages/beem/usedBeems.dart';
import 'package:preport/services/constant.dart';
import 'package:preport/services/models/current.dart';
import 'package:preport/services/providers/listProvider.dart';
import 'package:provider/provider.dart';

class Beems extends StatelessWidget {
  Beems({required this.currentCandidate, super.key});
  CurrentCandidate currentCandidate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: appBar(context),
      body: body(context),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: appbar,
      title: const Text("Beems"),
      leading: backButton(context),
      actions: [addBeem(context)],
    );
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ChangeNotifierProvider<ListProvider>(
        create: (context) => ListProvider(),
        builder: (context, child) => Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              totalBeems(context),
              sizeBox(10.0, null),
              stokeBeems(context),
              sizeBox(10.0, null),
              runningBeems(context),
              sizeBox(10.0, null),
              usedBeems(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget addBeem(BuildContext context) {
    return InkWell(
      onTap: () =>
          service.navigat(context, BeemAdd(currentCandidate: currentCandidate)),
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [Icon(Icons.add), Text("Add Beem")],
        ),
      ),
    );
  }

  Widget totalBeems(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 10.0,
        borderOnForeground: true,
        color: listtile,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Consumer<ListProvider>(
          builder: (context, listProvider, child) {
            listProvider.getTotalBeem();
            return InkWell(
              onTap: () => service.navigat(
                context,
                TotalBeems(
                  totalBeems: listProvider.totalBeem,
                ),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(child: Text("Total Beems")),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget stokeBeems(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 10.0,
        borderOnForeground: true,
        color: listtile,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: InkWell(
          onTap: () => service.navigat(context, const StokeBeems()),
          child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const Center(child: Text("Stoke Beems"))),
        ),
      ),
    );
  }

  Widget runningBeems(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 10.0,
        borderOnForeground: true,
        color: listtile,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Consumer<ListProvider>(
          builder: (context, listProvider, child) {
            listProvider.getRunningBeem();
            return InkWell(
              onTap: () => service.navigat(
                  context,
                  RunningBeems(
                    runningBeems: listProvider.runningBeem,
                  )),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(child: Text("Running Beems"))),
            );
          },
        ),
      ),
    );
  }

  Widget usedBeems(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 10.0,
        borderOnForeground: true,
        color: listtile,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Consumer<ListProvider>(
          builder: (context, listProvider, child) {
            listProvider.getUsedBeem();
            return InkWell(
              onTap: () => service.navigat(
                  context,
                  UsedBeems(
                    usedBeems: listProvider.usedBeem,
                  )),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(child: Text("Used Beems"))),
            );
          },
        ),
      ),
    );
  }

  Widget sizeBox(double? height, double? width) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
