// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:preport/pages/taka/addTaka.dart';
import 'package:preport/services/models/current.dart';
import 'package:preport/services/providers/listProvider.dart';
import 'package:provider/provider.dart';

import '../../services/constant.dart';
import '../../services/models/prod/taka.dart';

class DailyTaka extends StatelessWidget {
  DailyTaka({required this.currentCandidate, super.key});
  CurrentCandidate currentCandidate;

  final TextEditingController _sellingAmount = TextEditingController();

  final TextStyle _key = const TextStyle(color: Colors.black45, fontSize: 13.0);
  final TextStyle _value = const TextStyle(fontWeight: FontWeight.w500);
  final TextOverflow _textOverflow = TextOverflow.ellipsis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: appbar,
        actions: [
          addTaka(context),
        ],
      ),
      body: StreamProvider<List<Taka>>(
        create: (context) => fire.getTaka(),
        initialData: const [],
        builder: (context, child) {
          List<Taka> takaList = Provider.of<List<Taka>>(context);
          return ListView.builder(
            itemCount: takaList.length,
            itemBuilder: (context, index) => listTile(context, takaList[index]),
          );
        },
      ),
    );
  }

  Widget addTaka(BuildContext context) {
    return InkWell(
      onTap: () => service.navigat(
        context,
        AddTaka(
          currentCandidate: currentCandidate,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [Icon(Icons.add), Text("Add Beem")],
        ),
      ),
    );
  }

  Widget listTile(BuildContext context, Taka taka) {
    return InkWell(
      onLongPress: () => sell(context, taka),
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Row(
          children: [
            firstColumn(context, taka),
            secondColumn(context, taka),
            thirdColumn(context, taka)
          ],
        ),
      ),
    );
  }

  Widget firstColumn(BuildContext context, Taka taka) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Taka No. ",
                style: _key,
              ),
              Expanded(
                child: Text(
                  "${taka.takaNo}",
                  style: _value,
                  overflow: _textOverflow,
                ),
              )
            ],
          ),
          sizeBox(4.0, null),
          Row(
            children: [
              Text(
                "Meters ",
                style: _key,
              ),
              Expanded(
                child: Text(
                  "${taka.meters}",
                  style: _value,
                  overflow: _textOverflow,
                ),
              )
            ],
          ),
          sizeBox(4.0, null),
          Row(
            children: [
              Text(
                "Beem No. ",
                style: _key,
              ),
              Expanded(
                child: Text(
                  "${taka.beemNo}",
                  style: _value,
                  overflow: _textOverflow,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget secondColumn(BuildContext context, Taka taka) {
    return Expanded(
        flex: 1,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Design ",
                  style: _key,
                ),
                Expanded(
                  child: Text(
                    "${taka.design}",
                    style: _value,
                    overflow: _textOverflow,
                  ),
                )
              ],
            ),
            sizeBox(4.0, null),
            Row(
              children: [
                Text(
                  "PCS ",
                  style: _key,
                ),
                Expanded(
                  child: Text(
                    "${taka.pcs}",
                    style: _value,
                    overflow: _textOverflow,
                  ),
                )
              ],
            ),
            sizeBox(4.0, null),
            Row(
              children: [
                Text(
                  "McNo. ",
                  style: _key,
                ),
                Expanded(
                  child: Text(
                    "${taka.machineNo}",
                    style: _value,
                    overflow: _textOverflow,
                  ),
                )
              ],
            )
          ],
        ));
  }

  Widget thirdColumn(BuildContext context, Taka taka) {
    return Expanded(
        flex: 1,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Book ",
                  style: _key,
                ),
                Expanded(
                  child: Text(
                    "${taka.bookName}",
                    style: _value,
                    overflow: _textOverflow,
                  ),
                )
              ],
            ),
            sizeBox(4.0, null),
            Row(
              children: [
                Text(
                  "Quality ",
                  style: _key,
                ),
                Expanded(
                  child: Text(
                    "${taka.qualityName}",
                    style: _value,
                    overflow: _textOverflow,
                  ),
                )
              ],
            ),
            sizeBox(4.0, null),
            Row(
              children: [
                Text(
                  "Time ",
                  style: _key,
                ),
                Expanded(
                  child: Text(
                    service.getDateMonthYear(
                        service.timeStampToDateTime(taka.addedTime!)),
                    style: _value,
                    overflow: _textOverflow,
                  ),
                )
              ],
            )
          ],
        ));
  }

  Widget sizeBox(double? height, double? width) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  void sell(BuildContext context, Taka taka) {
    showDialog(
      context: context,
      builder: (context) => ChangeNotifierProvider<ListProvider>(
        create: (context) => ListProvider(),
        builder: (context, child) => AlertDialog(
          title: const Text("Sell Taka"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 30.0,
                decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Consumer<ListProvider>(
                    builder: (context, listProvider, child) {
                  listProvider.getCompanyList();
                  return PopupMenuButton(
                    itemBuilder: (context) => listProvider.companyList
                        .map(
                          (company) => PopupMenuItem(
                            value: company,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${company.code}"),
                                Expanded(
                                  child: Text(
                                    company.name!,
                                    softWrap: false,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Icon(Icons.arrow_drop_down),
                        Text(
                          listProvider.selectedCompany.code ?? "-- Select ",
                        ),
                        sizeBox(null, 5.0),
                        Expanded(
                          flex: 7,
                          child: Text(
                            listProvider.selectedCompany.name ?? "Company --",
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                    onSelected: (selectedCompany) =>
                        listProvider.selecteSellingCompany(selectedCompany),
                  );
                }),
              ),
              sizeBox(5.0, null),
              TextFormField(
                controller: _sellingAmount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Selling Amount",
                  hintStyle:
                      const TextStyle(color: Colors.grey, fontSize: 14.0),
                  fillColor: Colors.black12,
                  filled: true,
                  // isDense: true,
                  constraints: const BoxConstraints(
                    maxHeight: 30.0,
                  ),
                  contentPadding:
                      const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 0.0000000001, color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 0.0000000001, color: Colors.black12),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _sellingAmount.clear();
                },
                child: const Text("cancle")),
            Consumer<ListProvider>(
              builder: (context, listProvider, child) => TextButton(
                  onPressed: () => fire
                          .sellTaka(taka, listProvider.selectedCompany,
                              _sellingAmount.text)
                          .whenComplete(() {
                        Navigator.pop(context);
                        _sellingAmount.clear();
                      }),
                  child: const Text("Ok")),
            )
          ],
        ),
      ),
    );
  }
}
