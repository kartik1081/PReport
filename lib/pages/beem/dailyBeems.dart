// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:preport/services/constant.dart';
import 'package:preport/services/models/current.dart';
import 'package:preport/services/providers/listProvider.dart';
import 'package:provider/provider.dart';

import '../../services/models/beem/beem.dart';
import 'beemAdd.dart';

class DailyBeems extends StatelessWidget {
  DailyBeems({required this.currentCandidate, required this.id, super.key});
  CurrentCandidate currentCandidate;
  String id;

  final TextStyle _key = const TextStyle(color: Colors.black45, fontSize: 15.0);
  final TextStyle _value = const TextStyle(fontWeight: FontWeight.w500);
  final TextOverflow _textOverflow = TextOverflow.ellipsis;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListProvider>(
      create: (context) => ListProvider(),
      builder: (context, child) => Consumer<ListProvider>(
        builder: (context, listProvider, child) {
          listProvider.getTotalBeem();
          return Scaffold(
            backgroundColor: Colors.lightBlueAccent,
            appBar: AppBar(
              backgroundColor: Colors.redAccent,
              title: Text(id),
              actions: [addBeem(context)],
            ),
          );
        },
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

  Widget listTile(BuildContext context, Beem beem) {
    return InkWell(
      onTap: () => showRecord(context, beem),
      child: Container(
        margin: const EdgeInsets.only(top: 5.0, right: 10.0, left: 10.0),
        padding: const EdgeInsets.all(5.0),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            firstColumn(context, beem),
            secondColumn(context, beem),
            thirdColumn(context, beem),
          ],
        ),
      ),
    );
  }

  Widget firstColumn(BuildContext context, Beem beem) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Beem No.",
                style: _key,
              ),
              Text(
                beem.beemNo.toString(),
                style: _value,
                overflow: _textOverflow,
              ),
            ],
          ),
          // Row(
          //   children: [
          //     Text(
          //       "L.D.: ",
          //       style: _key,
          //     ),
          //     Text(
          //       beem.loadingDate!,
          //       style: _value,
          //       overflow: _textOverflow,
          //     ),
          //   ],
          // ),
          Row(
            children: [
              Text(
                "E.D.: ",
                style: _key,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget secondColumn(BuildContext context, Beem beem) {
    return Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  "Mc No.: ",
                  style: _key,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "TotMtrs: ",
                  style: _key,
                ),
                Text(
                  beem.totalMetr.toString(),
                  style: _value,
                  overflow: _textOverflow,
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "BalMtrs: ",
                  style: _key,
                ),
              ],
            )
          ],
        ));
  }

  Widget thirdColumn(BuildContext context, Beem beem) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Quality: ",
                style: _key,
              ),
              Text(
                "${beem.qualityCode} ${beem.qualityName}",
                style: _value,
                overflow: _textOverflow,
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Yarn: ",
                style: _key,
              ),
              Text(
                "${beem.yarnCode} ${beem.yarnName}",
                style: _value,
                overflow: _textOverflow,
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Party: ",
                style: _key,
              ),
              Text(
                "${beem.warparCode} ${beem.warparName}",
                style: _value,
                overflow: _textOverflow,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget sizeBox(double? height, double? width) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  void showRecord(BuildContext context, Beem beem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Beem No.: ${beem.beemNo}"),
        content: Column(
          children: [
            Row(
              children: [
                Text(
                  "Warpar: ",
                  style: _key,
                ),
                container(
                  Text(
                    "${beem.warparCode} ${beem.warparName}",
                    style: _value,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Quality: ",
                  style: _key,
                ),
                container(
                  Text("${beem.qualityCode} ${beem.qualityName}"),
                ),
              ],
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Ok"),
          )
        ],
      ),
    );
  }

  Widget container(Widget widget) {
    return Container(
        padding: const EdgeInsets.all(5.0),
        decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: widget);
  }
}
