// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:preport/services/constant.dart';
import 'package:preport/services/models/beem/beem.dart';

class RunningBeems extends StatelessWidget {
  RunningBeems({required this.runningBeems, super.key});
  List<Beem> runningBeems;

  final TextStyle _key = const TextStyle(color: Colors.black45, fontSize: 13.0);
  final TextStyle _value = const TextStyle(fontWeight: FontWeight.w500);
  final TextOverflow _textOverflow = TextOverflow.ellipsis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: appbar,
        title: const Text("Running Beems"),
      ),
      body: ListView.builder(
        itemCount: runningBeems.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => listTile(context, runningBeems[index]),
      ),
    );
  }

  Widget listTile(BuildContext context, Beem beem) {
    return InkWell(
      // onTap: () => showRecord(context, beem),
      child: Card(
        elevation: 5.0,
        borderOnForeground: true,
        margin: const EdgeInsets.only(top: 5.0, right: 10.0, left: 10.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: listtile,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              firstColumn(context, beem),
              secondColumn(context, beem),
            ],
          ),
        ),
      ),
    );
  }

  Widget firstColumn(BuildContext context, Beem beem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Beem No.: ",
              style: _key,
              overflow: _textOverflow,
            ),
            Text(
              beem.beemNo.toString(),
              style: _value,
              overflow: _textOverflow,
            )
          ],
        ),
        height(5.0),
        Row(
          children: [
            Text(
              "L.T.: ",
              style: _key,
              overflow: _textOverflow,
            ),
            Text(
              service.getDateMonthYear(
                  service.timeStampToDateTime(beem.loadingDate!)),
              style: _value,
              overflow: _textOverflow,
            )
          ],
        )
      ],
    );
  }

  Widget secondColumn(BuildContext context, Beem beem) {
    return Column();
  }
}
