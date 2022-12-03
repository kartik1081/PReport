// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:preport/services/constant.dart';

import '../../services/models/beem/beem.dart';

class TotalBeems extends StatelessWidget {
  TotalBeems({required this.totalBeems, super.key});
  List<Beem> totalBeems;

  final TextStyle _key = const TextStyle(color: Colors.black45, fontSize: 13.0);
  final TextStyle _value = const TextStyle(fontWeight: FontWeight.w500);
  final TextOverflow _textOverflow = TextOverflow.ellipsis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: appbar,
        title: const Text("Total Beems"),
      ),
      body: ListView.builder(
        itemCount: totalBeems.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => listTile(context, totalBeems[index]),
      ),
    );
  }

  Widget listTile(BuildContext context, Beem beem) {
    return InkWell(
      // onTap: () => showRecord(context, beem),
      child: Card(
        margin: const EdgeInsets.only(top: 7.0, right: 10.0, left: 10.0),
        elevation: 5.0,
        borderOnForeground: true,
        color: listtile,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          width: MediaQuery.of(context).size.width,
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
              "A.T.: ",
              style: _key,
              overflow: _textOverflow,
            ),
            Text(
              service.getDateMonthYear(
                  service.timeStampToDateTime(beem.arrivingDate!)),
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
              beem.loadingDate != null
                  ? service.getDateMonthYear(
                      service.timeStampToDateTime(beem.arrivingDate!))
                  : "Yet to load",
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
