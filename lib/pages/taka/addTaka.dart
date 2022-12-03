import 'package:flutter/material.dart';
import 'package:preport/services/ValueListener/takaListener.dart';
import 'package:preport/services/basic.dart';
import 'package:preport/services/constant.dart';
import 'package:preport/services/fire.dart';
import 'package:preport/services/models/current.dart';
import 'package:preport/services/models/lists.dart';
import 'package:preport/services/providers/listProvider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddTaka extends StatelessWidget {
  AddTaka({required this.currentCandidate, super.key});
  CurrentCandidate currentCandidate;

  final TextEditingController _addDetailName = TextEditingController();
  final TextEditingController _addDetailCode = TextEditingController();
  final TextEditingController _takaNo = TextEditingController();
  final TextEditingController _meters = TextEditingController();
  final TextEditingController _pcs = TextEditingController();
  final TextEditingController _mcNo = TextEditingController();
  final TextEditingController _beemNo = TextEditingController();
  final FocusNode _detailNameFocus = FocusNode();
  final FocusNode _detailCodeFocus = FocusNode();
  final FocusNode _takaNoFocus = FocusNode();
  final FocusNode _metersFocus = FocusNode();
  final FocusNode _pcsFocus = FocusNode();
  final FocusNode _mcNoFocus = FocusNode();
  final FocusNode _beemNoFocus = FocusNode();
  Map<String, dynamic> taka = {};
  Map<String, dynamic> details = {};

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
      title: const Text("Add Taka"),
      actions: [addDetail(context)],
    );
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ChangeNotifierProvider<ListProvider>(
        create: (context) => ListProvider(),
        builder: (context, child) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              bookDropDown(context),
              sizedBox(7.0, null),
              partyDropDown(context),
              sizedBox(10.0, null),
              takaNo(context),
              sizedBox(5.0, null),
              meters(context),
              sizedBox(5.0, null),
              pcs(context),
              sizedBox(5.0, null),
              mcNo(context),
              sizedBox(10.0, null),
              boomNoDropDown(context),
              sizedBox(14.0, null),
              const Divider(height: 2.0, thickness: 2.0),
              designRadio(context),
              const Divider(height: 2.0, thickness: 2.0),
              sizedBox(14.0, null),
              qualityDropDown(context),
              sizedBox(14.0, null),
              addTakaButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget addDetail(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => lists.prodDropDownList
          .map(
            (item) => PopupMenuItem(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onSelected: (item) => item == "Add Book"
          ? addDetial(context, "0")
          : item == "Add Party"
              ? addDetial(context, "1")
              : addDetial(context, "2"),
    );
  }

  void addDetial(BuildContext context, String number) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(number == "0"
            ? "Add Book"
            : number == "1"
                ? "Add Party"
                : "Add Quality"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _addDetailName,
              focusNode: _detailNameFocus,
              keyboardType: TextInputType.name,
              onFieldSubmitted: (name) => nameValidate(context, name).then(
                  (value) => value
                      ? _detailCodeFocus.requestFocus()
                      : _detailNameFocus.requestFocus()),
              decoration: InputDecoration(
                hintText: "Enter Name",
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
                fillColor: listtile,
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
            sizedBox(5.0, null),
            TextFormField(
              controller: _addDetailCode,
              focusNode: _detailCodeFocus,
              maxLength: 4,
              keyboardType: TextInputType.number,
              onFieldSubmitted: (code) => codeValidate(context, code).then(
                  (value) => value ? null : _detailCodeFocus.requestFocus()),
              decoration: InputDecoration(
                hintText: "Enter Code",
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
                fillColor: listtile,
                filled: true,
                constraints: const BoxConstraints(
                  maxHeight: 57.0,
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
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _addDetailName.clear();
              _addDetailCode.clear();
              Navigator.pop(context);
            },
            child: const Text("cancle"),
          ),
          TextButton(
            onPressed: () =>
                nameValidate(context, _addDetailName.text).then((value) => value
                    ? codeValidate(context, _addDetailCode.text).then(
                        (value) {
                          value
                              ? fire
                                  .storeProdDetail(details, number)
                                  .whenComplete(
                                  () {
                                    _addDetailName.clear();
                                    _addDetailCode.clear();
                                    Navigator.pop(context);
                                  },
                                )
                              : _detailCodeFocus.requestFocus();
                        },
                      )
                    : null),
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }

  Widget bookDropDown(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Consumer<ListProvider>(
        builder: (context, listProvider, child) {
          listProvider.getBookList();
          return PopupMenuButton(
            itemBuilder: (context) => listProvider.bookList
                .map((book) => PopupMenuItem(
                      value: book,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${book.code}  -  "),
                          Expanded(
                            child: Text(
                              book.name!,
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 35.0,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(
                    color: listtile,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_drop_down),
                      Text(
                        listProvider.selectedBook.code ?? "Book Code",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                sizedBox(null, 5.0),
                Expanded(
                  flex: 7,
                  child: Container(
                    height: 35.0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 9.0),
                    decoration: const BoxDecoration(
                      color: listtile,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Text(
                      listProvider.selectedBook.name ?? "Book Name",
                      softWrap: false,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            onSelected: (book) {
              mapTaka(taka, "book_code", book.code).whenComplete(() =>
                  mapTaka(taka, "book_name", book.name)
                      .whenComplete(() => listProvider.selectBook(book)));
            },
          );
        },
      ),
    );
  }

  Widget partyDropDown(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Consumer<ListProvider>(
        builder: (context, listProvider, child) {
          listProvider.getPartyList();
          return PopupMenuButton(
            itemBuilder: (context) => listProvider.partyList
                .map((party) => PopupMenuItem(
                      value: party,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${party.code}  -  "),
                          Expanded(
                            child: Text(
                              party.name!,
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(growable: true),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 35.0,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(
                    color: listtile,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_drop_down),
                      Text(
                        listProvider.selectedParty.code ?? "Party Code",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                sizedBox(null, 5.0),
                Expanded(
                  flex: 7,
                  child: Container(
                    height: 35.0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 9.0),
                    decoration: const BoxDecoration(
                      color: listtile,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Text(
                      listProvider.selectedParty.name ?? "Party Name",
                      softWrap: false,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            onSelected: (party) {
              mapTaka(taka, "party_code", party.code).whenComplete(() =>
                  mapTaka(taka, "party_name", party.name)
                      .whenComplete(() => listProvider.selectParty(party)));
            },
          );
        },
      ),
    );
  }

  Widget takaNo(BuildContext context) {
    return TextFormField(
      controller: _takaNo,
      enableSuggestions: true,
      autocorrect: true,
      focusNode: _takaNoFocus,
      keyboardType: TextInputType.number,
      onChanged: (takaNo) => mapTaka(taka, "taka_no", takaNo),
      onEditingComplete: () => _metersFocus.requestFocus(),
      decoration: InputDecoration(
        hintText: "Taka No.",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
        fillColor: listtile,
        filled: true,
        // isDense: true,
        constraints: const BoxConstraints(
          maxHeight: 30.0,
        ),
        contentPadding: const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.0000000001, color: listtile),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget meters(BuildContext context) {
    return TextFormField(
      controller: _meters,
      enableSuggestions: true,
      autocorrect: true,
      focusNode: _metersFocus,
      keyboardType: TextInputType.number,
      onChanged: (meters) => mapTaka(taka, "meters", meters),
      onEditingComplete: () => _pcsFocus.requestFocus(),
      decoration: InputDecoration(
        hintText: "Meters",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
        fillColor: listtile,
        filled: true,
        // isDense: true,
        constraints: const BoxConstraints(
          maxHeight: 30.0,
        ),
        contentPadding: const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.0000000001, color: listtile),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget pcs(BuildContext context) {
    return TextFormField(
      controller: _pcs,
      enableSuggestions: true,
      autocorrect: true,
      focusNode: _pcsFocus,
      keyboardType: TextInputType.number,
      onChanged: (pcs) => mapTaka(taka, "pcs", pcs),
      onEditingComplete: () => _mcNoFocus.requestFocus(),
      decoration: InputDecoration(
        hintText: "PCS",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
        fillColor: listtile,
        filled: true,
        // isDense: true,
        constraints: const BoxConstraints(
          maxHeight: 30.0,
        ),
        contentPadding: const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.0000000001, color: listtile),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget mcNo(BuildContext context) {
    return TextFormField(
      controller: _mcNo,
      enableSuggestions: true,
      autocorrect: true,
      focusNode: _mcNoFocus,
      keyboardType: TextInputType.number,
      onChanged: (mcNo) => mapTaka(taka, "machine_no", mcNo),
      decoration: InputDecoration(
        hintText: "McNo.",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
        fillColor: listtile,
        filled: true,
        // isDense: true,
        constraints: const BoxConstraints(
          maxHeight: 30.0,
        ),
        contentPadding: const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.0000000001, color: listtile),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget boomNoDropDown(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Consumer<ListProvider>(
        builder: (context, listProvider, child) {
          listProvider.getRunningBeem();
          return PopupMenuButton(
            itemBuilder: (context) => listProvider.runningBeem
                .map(
                  (runningBeem) => PopupMenuItem(
                    value: runningBeem,
                    child: Text("${runningBeem.beemNo}"),
                  ),
                )
                .toList(growable: true),
            child: Container(
              height: 35.0,
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: const BoxDecoration(
                color: listtile,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.arrow_drop_down),
                  Text("${listProvider.selectedBeem.beemNo ?? "Beem No."}"),
                ],
              ),
            ),
            onSelected: (selectedBeem) {
              mapTaka(taka, "beem_no", selectedBeem.beemNo.toString())
                  .whenComplete(
                      () => listProvider.selectRunningBeem(selectedBeem));
            },
          );
        },
      ),
    );
  }

  Widget designRadio(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: takaListener.design,
      builder: (context, design, child) {
        mapTaka(taka, "design", design);
        return Row(
          children: [
            const Text("Design:"),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  groupValue: design,
                  value: "T.P.",
                  onChanged: (design) {
                    takaListener.selectDesign(design);
                  },
                  activeColor: button,
                ),
                const Text("T.P.")
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  groupValue: design,
                  value: null,
                  onChanged: (design) {
                    takaListener.selectDesign(design);
                  },
                  activeColor: button,
                ),
                const Text("Other")
              ],
            ),
          ],
        );
      },
    );
  }

  Widget qualityDropDown(BuildContext context) {
    return Consumer<ListProvider>(
      builder: (context, listProvider, child) {
        listProvider.getQualityList();
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: PopupMenuButton(
              itemBuilder: (context) => listProvider.qualityList
                  .map(
                    (quality) => PopupMenuItem(
                      value: quality,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${quality.code} - "),
                          Expanded(
                            child: Text(
                              quality.name!,
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
                  Container(
                    height: 35.0,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: const BoxDecoration(
                      color: listtile,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_drop_down),
                        Text(
                          listProvider.selectedQuality.code ?? "Quality Code",
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  sizedBox(null, 5.0),
                  Expanded(
                    flex: 7,
                    child: Container(
                      height: 35.0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 9.0),
                      decoration: const BoxDecoration(
                        color: listtile,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Text(
                        listProvider.selectedQuality.name ?? "Quality Name",
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
              onSelected: (quality) {
                mapTaka(taka, "quality_code", quality.code).whenComplete(() =>
                    mapTaka(taka, "quality_name", quality.name)
                        .whenComplete(() {
                      mapTaka(taka, "id", const Uuid().v4());
                      mapTaka(taka, "added_by", currentCandidate.candidatId);
                      mapTaka(taka, "added_time", DateTime.now());
                    }).whenComplete(() => listProvider.selectQuality(quality)));
              },
            ),
          ),
        );
      },
    );
  }

  Widget addTakaButton(BuildContext context) {
    return InkWell(
      onTap: () =>
          fire.storeTaka(taka).whenComplete(() => Navigator.pop(context)),
      child: SizedBox(
        child: Container(
          height: 44.0,
          width: 156.0,
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          decoration: const BoxDecoration(
            color: button,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: const Center(
            child: Text(
              "Submit",
              style: TextStyle(
                color: listtile,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> takaNoValidate(BuildContext context, String takaNo) async {
    if (takaNo.isEmpty) {
      service.toast(context, "Please enter taka no");
      return false;
    }
    return true;
  }

  Future<bool> pcsValidate(BuildContext context, String pcs) async {
    if (pcs.isEmpty) {
      service.toast(context, "Please enter pcs");
      return false;
    }
    return true;
  }

  Future<bool> meterValidate(BuildContext context, String meters) async {
    if (meters.isEmpty) {
      service.toast(context, "Please enter meters");
      return false;
    }
    return true;
  }

  Future<bool> mcNoValidate(BuildContext context, String mcNo) async {
    if (mcNo.isEmpty) {
      service.toast(context, "Please enter machine no.");
      return false;
    }
    return true;
  }

  Future<bool> nameValidate(BuildContext context, String name) async {
    if (name.isEmpty) {
      service.toast(context, "Please enter name");
      return false;
    }
    // mapDetail(details, "name", name);
    return true;
  }

  Future<bool> codeValidate(BuildContext context, String code) async {
    if (code.isEmpty) {
      service.toast(context, "Please enter code");
      return false;
    }
    if (code.length < 4) {
      service.toast(context, "Please enter 4 digit code");
      return false;
    }
    // mapDetail(details, "code", code);
    // mapDetail(details, "added_by", currentCandidate.candidatId);
    // mapDetail(details, "added_time", DateTime.now());
    // mapDetail(details, "id", const Uuid().v1());
    return true;
  }

  Future<void> mapTaka(
      Map<String, dynamic> addDetail, String key, dynamic value) async {
    taka[key] = value;
    print(taka);
  }

  Future<void> mapDetail(
      Map<String, dynamic> addDetail, String key, dynamic value) async {
    addDetail[key] = value;
  }

  Widget sizedBox(double? height, double? width) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
