import 'package:flutter/material.dart';
import 'package:preport/services/constant.dart';
import 'package:preport/services/models/beem/beem.dart';
import 'package:provider/provider.dart';

import '../../services/basic.dart';
import '../../services/fire.dart';

class StokeBeems extends StatelessWidget {
  StokeBeems({super.key});

  final TextStyle _key = const TextStyle(color: Colors.black45, fontSize: 13.0);
  final TextStyle _value = const TextStyle(fontWeight: FontWeight.w500);
  final TextOverflow _textOverflow = TextOverflow.ellipsis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: appbar,
        title: const Text("Stoke Beems"),
      ),
      body: StreamProvider<List<Beem>>(
        create: (context) => fire.getStokeBeem(),
        initialData: [],
        builder: (context, _) {
          List<Beem> stokeBeems = Provider.of<List<Beem>>(context);
          return ListView.builder(
            itemCount: stokeBeems.length,
            shrinkWrap: true,
            itemBuilder: (context, index) =>
                listTile(context, stokeBeems[index]),
          );
        },
      ),
    );
  }

  Widget listTile(BuildContext context, Beem beem) {
    return InkWell(
      // onTap: () => showRecord(context, beem),
      child: Card(
        elevation: 5.0,
        borderOnForeground: true,
        color: listtile,
        margin: const EdgeInsets.only(top: 7.0, right: 10.0, left: 10.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
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
              loadButton(context, beem),
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
        )
      ],
    );
  }

  Widget secondColumn(BuildContext context, Beem beem) {
    return Column();
  }

  Widget loadButton(BuildContext context, Beem beem) {
    return TextButton(
        onPressed: () => fire.loadBeem(beem), child: const Text("Load"));
  }
}
