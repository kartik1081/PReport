import 'package:flutter/material.dart';
import 'package:preport/pages/beem/beems.dart';
import 'package:preport/services/ValueListener/listListener.dart';
import 'package:preport/services/basic.dart';
import 'package:preport/services/fire.dart';
import 'package:preport/services/models/current.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../services/constant.dart';
import '../../services/models/lists.dart';
import '../../services/providers/listProvider.dart';

class BeemAdd extends StatelessWidget {
  BeemAdd({required this.currentCandidate, super.key});
  CurrentCandidate currentCandidate;

  final TextEditingController _addDetailName = TextEditingController();
  final TextEditingController _addDetailCode = TextEditingController();
  final TextEditingController _beemNo = TextEditingController();
  final TextEditingController _tar = TextEditingController();
  final TextEditingController _totalMeter = TextEditingController();
  final TextEditingController _avgMeter = TextEditingController();
  final TextEditingController _totalTaka = TextEditingController();
  final TextEditingController _yarnDenier = TextEditingController();
  final TextEditingController _grossWt = TextEditingController();
  final TextEditingController _pipeWt = TextEditingController();
  final TextEditingController _yarnNetWt = TextEditingController();
  final TextEditingController _pipeNo = TextEditingController();
  final TextEditingController _beemSize = TextEditingController();
  final TextEditingController _rpm = TextEditingController();
  final TextEditingController _pick = TextEditingController();
  final TextEditingController _minSrtg = TextEditingController();
  final TextEditingController _totalConsum = TextEditingController();
  final TextEditingController _remarks = TextEditingController();
  final TextEditingController _wraperRate = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _loadingDate = TextEditingController();
  final TextEditingController _loomNo = TextEditingController();
  final TextEditingController _yarnLotNo = TextEditingController();
  final TextEditingController _recMeter = TextEditingController();
  final TextEditingController _balMeter = TextEditingController();
  final TextEditingController _recTaka = TextEditingController();
  final TextEditingController _lastYearRecMeter = TextEditingController();
  final TextEditingController _totalMeter2 = TextEditingController();
  final TextEditingController _recTaka2 = TextEditingController();
  final FocusNode _detailNameFocus = FocusNode();
  final FocusNode _detailCodeFocus = FocusNode();
  final FocusNode _beemNoFocus = FocusNode();
  final FocusNode _tarFocus = FocusNode();
  final FocusNode _totalMeterFocus = FocusNode();
  final FocusNode _avgMeterFocus = FocusNode();
  final FocusNode _totalTakaFocus = FocusNode();
  final FocusNode _yarnDenierFocus = FocusNode();
  final FocusNode _grossWtFocus = FocusNode();
  final FocusNode _pipeWtFocus = FocusNode();
  final FocusNode _yarnNetWtFocuse = FocusNode();
  final FocusNode _pipeNoFocus = FocusNode();
  final FocusNode _beemSizeFocuse = FocusNode();
  final FocusNode _rpmFocus = FocusNode();
  final FocusNode _pickFocus = FocusNode();
  final FocusNode _minSrtgFocus = FocusNode();
  final FocusNode _totalConsumFocus = FocusNode();
  final FocusNode _remarksFocus = FocusNode();
  final FocusNode _wraperRateFocus = FocusNode();
  final FocusNode _amountFocus = FocusNode();
  final FocusNode _loomNoFocus = FocusNode();
  final FocusNode _yarnLotNoFocus = FocusNode();
  bool _warparName = false;
  bool _quality = false;
  bool _yarnQuality = false;
  Map<String, dynamic> mapData = {};
  Map<String, dynamic> mapSubDetail = {};

  @override
  Widget build(BuildContext context) {
    print(currentCandidate.candidatId);
    return Scaffold(
      backgroundColor: background,
      appBar: appBar(context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
          child: ChangeNotifierProvider<ListProvider>(
            create: (context) => ListProvider(),
            builder: (context, child) => Column(
              children: [
                beemNoText(context),
                height(10.0),
                wrapperDropDown(context),
                height(10.0),
                qualityDropDown(context),
                height(10.0),
                yarnDropDown(context),
                height(10.0),
                divider(),
                height(10.0),
                Row(
                  children: [
                    tarText(context),
                    width(5.0),
                    pnoText(context),
                  ],
                ),
                height(10.0),
                Row(
                  children: [
                    totalMeter(context),
                    width(5.0),
                    avgMeter(context)
                  ],
                ),
                height(10.0),
                Row(
                  children: [
                    totalTakaText(context),
                    width(5.0),
                    denierText(context),
                  ],
                ),
                height(10.0),
                Row(
                  children: [
                    yarnNetWt(context),
                    width(5.0),
                    pick(context),
                  ],
                ),
                height(10.0),
                Row(
                  children: [pipeNo(context), width(5.0), beemSize(context)],
                ),
                height(10.0),
                Row(
                  children: [
                    rpm(context),
                    width(5.0),
                    pipeWtText(context),
                  ],
                ),
                height(10.0),
                Row(
                  children: [
                    minStrg(context),
                    width(5.0),
                    totalConsum(context),
                  ],
                ),
                height(10.0),
                Row(
                  children: [
                    warparRate(context),
                    width(5.0),
                    amount(context),
                  ],
                ),
                height(10.0),
                Row(
                  children: [
                    loadingDate(context),
                    width(5.0),
                    loomNo(context),
                  ],
                ),
                height(10.0),
                Row(
                  children: [
                    yarnLotNo(context),
                    width(5.0),
                    remark(context),
                  ],
                ),
                height(10.0),
                beemGrossWtText(context),
                height(10.0),
                sumbitButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return const Divider(
      color: Colors.black38,
      height: 1.0,
      thickness: 1.0,
    );
  }

  Widget sumbitButton(BuildContext context) {
    return InkWell(
      onTap: () => validate(context),
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
                color: white,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget denierText(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextFormField(
        controller: _yarnDenier,
        enableSuggestions: true,
        autocorrect: true,
        focusNode: _yarnDenierFocus,
        keyboardType: TextInputType.number,
        onChanged: (yarnDenier) {
          _yarnNetWt.text = (int.parse(_tar.text) *
                  int.parse(_totalMeter.text) *
                  int.parse(yarnDenier == "" ? "1" : yarnDenier) /
                  9000000)
              .toString();
        },
        onFieldSubmitted: (yarnDenier) => {},
        decoration: InputDecoration(
          hintText: "yarn Denier",
          hintStyle: const TextStyle(color: black, fontSize: 14.0),
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
      ),
    );
  }

  Widget yarnLotNo(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextFormField(
        controller: _yarnLotNo,
        enableSuggestions: true,
        autocorrect: true,
        focusNode: _yarnLotNoFocus,
        keyboardType: TextInputType.number,
        onChanged: (yarnLotNo) =>
            mapBeem(mapData, "yarn_lot_no", int.parse(yarnLotNo)),
        onFieldSubmitted: (yarnLotNo) => _remarksFocus.requestFocus(),
        decoration: InputDecoration(
          hintText: "Yarn Lot No.",
          hintStyle: const TextStyle(color: black, fontSize: 14.0),
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
      ),
    );
  }

  Widget loomNo(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextFormField(
        controller: _loomNo,
        enableSuggestions: true,
        autocorrect: true,
        focusNode: _loomNoFocus,
        keyboardType: TextInputType.number,
        onFieldSubmitted: (loomNo) => loomNoValidate(context, loomNo).then(
          (value) => value
              ? _yarnLotNoFocus.requestFocus()
              : _loomNoFocus.requestFocus(),
        ),
        decoration: InputDecoration(
          hintText: "Loom No.",
          hintStyle: const TextStyle(color: black, fontSize: 14.0),
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
      ),
    );
  }

  Widget loadingDate(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextFormField(
        controller: _loadingDate,
        enableSuggestions: true,
        autocorrect: true,
        readOnly: true,
        onTap: () => service.selectDate(context).then((value) {
          _loadingDate.text = value["String"];
          mapBeem(mapData, "arriving_time", value["DateTime"]);
        }),
        decoration: InputDecoration(
          hintText: "Arriving Date",
          hintStyle: const TextStyle(color: black, fontSize: 14.0),
          fillColor: listtile,
          filled: true,
          isDense: true,
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
      ),
    );
  }

  Widget amount(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextFormField(
        controller: _amount,
        enableSuggestions: true,
        autocorrect: true,
        focusNode: _amountFocus,
        keyboardType: TextInputType.number,
        onChanged: (amount) => mapBeem(mapData, "amount", int.parse(amount)),
        onFieldSubmitted: (amount) {},
        decoration: InputDecoration(
          hintText: "Amount",
          hintStyle: const TextStyle(color: black, fontSize: 14.0),
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
      ),
    );
  }

  Widget warparRate(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextFormField(
        controller: _wraperRate,
        enableSuggestions: true,
        autocorrect: true,
        focusNode: _wraperRateFocus,
        keyboardType: TextInputType.number,
        onChanged: (warparRate) =>
            mapBeem(mapData, "warpar_rate", int.parse(warparRate)),
        onFieldSubmitted: (warparRate) => _amountFocus.requestFocus(),
        decoration: InputDecoration(
          hintText: "Warpar Rate",
          hintStyle: const TextStyle(color: black, fontSize: 14.0),
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
      ),
    );
  }

  Widget remark(BuildContext context) {
    return Expanded(
      flex: 2,
      child: TextFormField(
        controller: _remarks,
        enableSuggestions: true,
        autocorrect: true,
        focusNode: _remarksFocus,
        keyboardType: TextInputType.text,
        onChanged: (remark) => mapBeem(mapData, "remark", remark),
        decoration: InputDecoration(
          hintText: "Remarks",
          hintStyle: const TextStyle(color: black, fontSize: 14.0),
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
      ),
    );
  }

  Widget totalConsum(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextFormField(
        controller: _totalConsum,
        enableSuggestions: true,
        autocorrect: true,
        focusNode: _totalConsumFocus,
        keyboardType: TextInputType.number,
        onChanged: (totalConsum) =>
            mapBeem(mapData, "total_meter_consum", int.parse(totalConsum)),
        onFieldSubmitted: (totalConsum) => _wraperRateFocus.requestFocus(),
        decoration: InputDecoration(
          hintText: "Tot.Mtrs Consume%",
          hintStyle: const TextStyle(color: black, fontSize: 14.0),
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
      ),
    );
  }

  Widget minStrg(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextFormField(
        controller: _minSrtg,
        enableSuggestions: true,
        autocorrect: true,
        focusNode: _minSrtgFocus,
        keyboardType: TextInputType.number,
        onChanged: (minStrg) =>
            mapBeem(mapData, "min_strg", int.parse(minStrg)),
        onFieldSubmitted: (minStrg) => _totalConsumFocus.requestFocus(),
        decoration: InputDecoration(
          hintText: "Min.Strg%",
          hintStyle: const TextStyle(color: black, fontSize: 14.0),
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
      ),
    );
  }

  Widget pick(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextFormField(
        controller: _pick,
        enableSuggestions: true,
        autocorrect: true,
        focusNode: _pickFocus,
        keyboardType: TextInputType.number,
        onFieldSubmitted: (pick) => pickValidate(context, pick).then(
          (value) =>
              value ? _minSrtgFocus.requestFocus() : _pickFocus.requestFocus(),
        ),
        decoration: InputDecoration(
          hintText: "Pick",
          hintStyle: const TextStyle(color: black, fontSize: 14.0),
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
      ),
    );
  }

  Widget rpm(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextFormField(
        controller: _rpm,
        enableSuggestions: true,
        autocorrect: true,
        focusNode: _rpmFocus,
        keyboardType: TextInputType.number,
        onChanged: (rpm) => mapBeem(mapData, "rpm", int.parse(rpm)),
        onFieldSubmitted: (rpm) => _pickFocus.requestFocus(),
        decoration: InputDecoration(
          hintText: "R.P.M.",
          hintStyle: const TextStyle(color: black, fontSize: 14.0),
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
      ),
    );
  }

  Widget beemSize(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextFormField(
        controller: _beemSize,
        enableSuggestions: true,
        autocorrect: true,
        focusNode: _beemSizeFocuse,
        keyboardType: TextInputType.number,
        onChanged: (beemSize) =>
            mapBeem(mapData, "beem_size", int.parse(beemSize)),
        onFieldSubmitted: (beemSize) => _rpmFocus.requestFocus(),
        decoration: InputDecoration(
          hintText: "Beem Size",
          hintStyle: const TextStyle(color: black, fontSize: 14.0),
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
      ),
    );
  }

  Widget pipeNo(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextFormField(
        controller: _pipeNo,
        enableSuggestions: true,
        autocorrect: true,
        focusNode: _pipeNoFocus,
        keyboardType: TextInputType.number,
        onChanged: (pipeNo) => mapBeem(mapData, "pipe_no", int.parse(pipeNo)),
        onFieldSubmitted: (pipeNo) => _beemSizeFocuse.requestFocus(),
        decoration: InputDecoration(
          hintText: "Pipe No.",
          hintStyle: const TextStyle(color: black, fontSize: 14.0),
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
      ),
    );
  }

  Widget yarnNetWt(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextFormField(
        controller: _yarnNetWt,
        enableSuggestions: true,
        autocorrect: true,
        focusNode: _yarnNetWtFocuse,
        keyboardType: TextInputType.number,
        onFieldSubmitted: (yarnNetWt) =>
            yarnNetWtValidate(context, yarnNetWt).then(
          (value) => value
              ? _pipeNoFocus.requestFocus()
              : _yarnNetWtFocuse.requestFocus(),
        ),
        decoration: InputDecoration(
          hintText: "Yarn Net Wt",
          hintStyle: const TextStyle(color: black, fontSize: 14.0),
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
      ),
    );
  }

  Widget pipeWtText(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextFormField(
        controller: _pipeWt,
        enableSuggestions: true,
        autocorrect: true,
        focusNode: _pipeWtFocus,
        keyboardType: TextInputType.number,
        onChanged: (pipeWt) =>
            mapBeem(mapData, "pipe_wt", int.parse(pipeWt == "" ? "0" : pipeWt)),
        onFieldSubmitted: (pipeWt) => _pipeNoFocus.requestFocus(),
        decoration: InputDecoration(
          hintText: "Pipe Wt",
          hintStyle: const TextStyle(color: black, fontSize: 14.0),
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
      ),
    );
  }

  Widget beemGrossWtText(BuildContext context) {
    return TextFormField(
      controller: _grossWt,
      enableSuggestions: true,
      autocorrect: true,
      focusNode: _grossWtFocus,
      keyboardType: TextInputType.number,
      onFieldSubmitted: (grossWt) {
        mapBeem(mapData, "gross_wt", grossWt == null ? "" : int.parse(grossWt));
        _pipeWtFocus.requestFocus();
      },
      decoration: InputDecoration(
        hintText: "Gross Wt",
        hintStyle: const TextStyle(color: black, fontSize: 14.0),
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

  Widget totalTakaText(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextFormField(
        controller: _totalTaka,
        enableSuggestions: true,
        autocorrect: true,
        readOnly: true,
        keyboardType: TextInputType.number,
        onFieldSubmitted: (totalTaka) => totalTakaValidate(context, totalTaka),
        decoration: InputDecoration(
          hintText: "Total Taka",
          hintStyle: const TextStyle(color: black, fontSize: 14.0),
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
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: appbar,
      title: const Text("Beem Detail"),
      leading: backButton(context),
      actions: [
        addBeemDetail(context),
      ],
    );
  }

  Widget backButton(BuildContext context) {
    return IconButton(
      onPressed: () => service.navigat(
        context,
        Beems(currentCandidate: currentCandidate),
      ),
      icon: const Icon(Icons.arrow_back),
    );
  }

  Widget addBeemDetail(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => lists.beemDropDownList
          .map(
            (addDetail) => PopupMenuItem(
              value: addDetail,
              child: Text(addDetail),
            ),
          )
          .toList(),
      onSelected: (addDetail) => addDetail == "Add Warpar"
          ? addDetial(context, "0")
          : addDetail == "Add Quality"
              ? addDetial(context, "1")
              : addDetial(context, "2"),
    );
  }

  Widget beemNoText(BuildContext context) {
    return TextFormField(
      controller: _beemNo,
      enableSuggestions: true,
      autocorrect: true,
      focusNode: _beemNoFocus,
      keyboardType: TextInputType.number,
      onFieldSubmitted: (beemNo) => beemNoValidate(context, beemNo).then(
        (value) => value ? null : _beemNoFocus.requestFocus(),
      ),
      decoration: InputDecoration(
        hintText: "Beem No.",
        hintStyle: const TextStyle(color: black, fontSize: 14.0),
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

  Widget wrapperDropDown(BuildContext contexts) {
    return Consumer<ListProvider>(
      builder: (context, listProvider, child) {
        listProvider.getWarparList();
        return SizedBox(
          height: 30.0,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: const BoxDecoration(
              color: listtile,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: PopupMenuButton(
              itemBuilder: (context) => listProvider.warparList
                  .map(
                    (warper) => PopupMenuItem(
                      value: warper,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${warper.code}  -  "),
                          Expanded(
                            child: Text(
                              warper.name!,
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
                    "${listProvider.selectedWarpar.code ?? "Warpar Code"} - ",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  width(5.0),
                  Expanded(
                    flex: 7,
                    child: Text(
                      listProvider.selectedWarpar.name ?? "Warpar Name",
                      softWrap: false,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
              onSelected: (warper) {
                _warparName = true;
                mapBeem(mapData, "warpar_name", warper.name).whenComplete(
                  () =>
                      mapBeem(mapData, "warpar_code", warper.code).whenComplete(
                    () => listProvider.selectWarpar(warper),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget qualityDropDown(BuildContext context) {
    return Consumer<ListProvider>(
      builder: (context, listProvider, child) {
        listProvider.getQualityList();
        return SizedBox(
          height: 30.0,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: const BoxDecoration(
              color: listtile,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
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
                  const Icon(Icons.arrow_drop_down),
                  Text(
                    "${listProvider.selectedQuality.code ?? "Quality Code"} - ",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      listProvider.selectedQuality.name ?? "Quality Name",
                      softWrap: false,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
              onSelected: (quality) {
                _quality = true;
                mapBeem(mapData, "quality_name", quality.name).whenComplete(
                  () => mapBeem(mapData, "quality_code", quality.code)
                      .whenComplete(
                    () => listProvider.selectQuality(quality),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget yarnDropDown(BuildContext context) {
    return Consumer<ListProvider>(
      builder: (context, listProvider, child) {
        listProvider.getYarnList();
        return SizedBox(
          height: 30.0,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: const BoxDecoration(
              color: listtile,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: PopupMenuButton(
              itemBuilder: (context) => listProvider.yarnList
                  .map(
                    (yarn) => PopupMenuItem(
                      value: yarn,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${yarn.code} - "),
                          Expanded(
                            child: Text(
                              yarn.name!,
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
                    "${listProvider.selectedYarn.code ?? "Yarn Code"} - ",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  width(5.0),
                  Expanded(
                    flex: 4,
                    child: Text(
                      listProvider.selectedYarn.name ?? "Yarn Quality",
                      softWrap: false,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
              onSelected: (yarn) {
                _yarnQuality = true;
                mapBeem(mapData, "yarn_name", yarn.name).whenComplete(
                  () => mapBeem(mapData, "yarn_code", yarn.code).whenComplete(
                    () => listProvider.selectYarn(yarn),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget tarText(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextFormField(
        controller: _tar,
        enableSuggestions: true,
        autocorrect: true,
        focusNode: _tarFocus,
        keyboardType: TextInputType.number,
        onFieldSubmitted: (tar) => tarValidate(context, tar).then(
          (value) => value ? null : _tarFocus.requestFocus(),
        ),
        decoration: InputDecoration(
          hintText: "Tar",
          hintStyle: const TextStyle(color: black, fontSize: 14.0),
          fillColor: listtile,
          filled: true,
          // isDense: true,
          constraints: const BoxConstraints(
            maxHeight: 30.0,
          ),
          contentPadding: const EdgeInsets.fromLTRB(13.0, 10.0, 13.0, 10.0),
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
      ),
    );
  }

  Widget pnoText(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 30.0, minHeight: 30.0),
        child: Container(
          decoration: BoxDecoration(
              color: listtile,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(
                  strokeAlign: StrokeAlign.inside, color: Colors.black38)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("PNO: "),
              ValueListenableBuilder<String>(
                valueListenable: listListener.pno,
                builder: (context, value, child) {
                  mapBeem(mapData, "pno", int.parse(value));
                  return Container(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: PopupMenuButton(
                      itemBuilder: (context) => lists.pnoList
                          .map(
                            (pno) => PopupMenuItem(
                              value: pno,
                              child: Text(pno),
                            ),
                          )
                          .toList(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(value),
                          Container(
                              margin: const EdgeInsets.only(left: 20.0),
                              decoration: const BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    5.0,
                                  ),
                                ),
                              ),
                              child: const Icon(Icons.arrow_drop_down)),
                        ],
                      ),
                      onSelected: (pno) => listListener.setPno(pno),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget totalMeter(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextFormField(
        controller: _totalMeter,
        enableSuggestions: true,
        autocorrect: true,
        focusNode: _totalMeterFocus,
        keyboardType: TextInputType.number,
        onFieldSubmitted: (totalMeter) =>
            totalMeterValidate(context, totalMeter).then(
          (value) => value
              ? _avgMeterFocus.requestFocus()
              : _totalMeterFocus.requestFocus(),
        ),
        decoration: InputDecoration(
          hintText: "Total Meter",
          hintStyle: const TextStyle(color: black, fontSize: 14.0),
          fillColor: listtile,
          filled: true,
          // isDense: true,
          constraints: const BoxConstraints(
            maxHeight: 30.0,
          ),
          contentPadding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
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
      ),
    );
  }

  Widget avgMeter(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextFormField(
        controller: _avgMeter,
        enableSuggestions: true,
        autocorrect: true,
        focusNode: _avgMeterFocus,
        keyboardType: TextInputType.number,
        onChanged: (avgMeter) => _totalTaka.text =
            (int.parse(_totalMeter.text) /
                    int.parse(avgMeter == '' ? "1" : avgMeter))
                .toString(),
        onFieldSubmitted: (avgMeter) =>
            avgMeterValidate(context, avgMeter).then(
          (value) => value
              ? _grossWtFocus.requestFocus()
              : _avgMeterFocus.requestFocus(),
        ),
        decoration: InputDecoration(
          hintText: "Avg. Meter",
          hintStyle: const TextStyle(color: black, fontSize: 14.0),
          fillColor: listtile,
          filled: true,
          // isDense: true,
          constraints: const BoxConstraints(
            maxHeight: 30.0,
          ),
          contentPadding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
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
      ),
    );
  }

  void addDetial(BuildContext context, String number) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(number == "0"
            ? "Add Wrapper"
            : number == "1"
                ? "Add Quality"
                : "Add Yarn"),
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
                hintStyle: const TextStyle(color: black, fontSize: 14.0),
                fillColor: background,
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
                      const BorderSide(width: 0.0000000001, color: black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            height(4.0),
            TextFormField(
              controller: _addDetailCode,
              focusNode: _detailCodeFocus,
              maxLength: 4,
              keyboardType: TextInputType.number,
              onFieldSubmitted: (code) => codeValidate(context, code).then(
                  (value) => value ? null : _detailCodeFocus.requestFocus()),
              decoration: InputDecoration(
                hintText: "Enter Code",
                hintStyle: const TextStyle(color: black, fontSize: 14.0),
                fillColor: background,
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
                      const BorderSide(width: 0.0000000001, color: black),
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
                                  .storeBeemDetail(mapSubDetail, number)
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

  Future<bool> loadingDateValidate(BuildContext context) async {
    if (_loadingDate.text.isEmpty) {
      mapBeem(mapData, "loading_date", DateTime.now());
    }
    return true;
  }

  Future<bool> yarnNetWtValidate(BuildContext context, String yarnNetWt) async {
    if (yarnNetWt.isEmpty) {
      service.toast(context, "Please enter yarn net weight");
      return false;
    }
    mapBeem(mapData, "yarn_net_wt", int.parse(yarnNetWt));
    return true;
  }

  Future<bool> rpmValidate(BuildContext context, String rpm) async {
    if (rpm.isEmpty) {
      service.toast(context, "Please enter R.P.M.");
      return false;
    }

    return true;
  }

  Future<bool> pickValidate(BuildContext context, String pick) async {
    if (pick.isEmpty) {
      service.toast(context, "Please enter pick");
      return false;
    }
    mapBeem(mapData, "pick", int.parse(pick));
    return true;
  }

  Future<bool> totalConsumValidate(
      BuildContext context, String totalConsum) async {
    if (totalConsum.isEmpty) {
      service.toast(context, "Please enter total meter consume");
      return false;
    }

    return true;
  }

  Future<bool> loomNoValidate(BuildContext context, String loomNo) async {
    if (loomNo.isEmpty) {
      service.toast(context, "Please enter loom no.");
      return false;
    }
    mapBeem(mapData, "loom_no", int.parse(loomNo));
    return true;
  }

  Future<bool> pipeWtValidate(BuildContext context, String pipeWt) async {
    if (pipeWt.isEmpty) {
      service.toast(context, "Please enter pipe weight");
      return false;
    }

    return true;
  }

  Future<bool> gorssWtValidate(BuildContext context, String grossWt) async {
    if (grossWt.isEmpty) {
      service.toast(context, "Please enter gross weight");
      return false;
    }

    return true;
  }

  Future<bool> totalTakaValidate(BuildContext context, String totalTaka) async {
    if (totalTaka.isEmpty) {
      service.toast(context, "Please enter total taka");
      return false;
    }
    mapBeem(mapData, "total_taka", int.parse(totalTaka));
    return true;
  }

  Future<bool> beemNoValidate(BuildContext context, String beemNo) async {
    if (beemNo.isEmpty) {
      service.toast(context, "Please enter Beem No.");
      return false;
    }
    mapBeem(mapData, "beem_no", int.parse(beemNo));
    return true;
  }

  Future<bool> tarValidate(BuildContext context, String tar) async {
    if (tar.isEmpty) {
      service.toast(context, "Please enter tar");
      return false;
    }
    mapBeem(mapData, "tar", int.parse(tar.trim()));
    return true;
  }

  Future<bool> pnoValidate(BuildContext context, String pno) async {
    if (pno.isEmpty) {
      service.toast(context, "Please enter pno");
      return false;
    }
    return true;
  }

  Future<bool> totalMeterValidate(
      BuildContext context, String totalMeter) async {
    if (totalMeter.isEmpty) {
      service.toast(context, "Please enter total meter");
      return false;
    }
    mapBeem(mapData, "total_meter", int.parse(totalMeter.trim()));
    return true;
  }

  Future<bool> nameValidate(BuildContext context, String name) async {
    if (name.isEmpty) {
      service.toast(context, "Please enter name");
      return false;
    }
    mapDetail(mapSubDetail, "name", name);
    return true;
  }

  Future<bool> codeValidate(BuildContext context, String code) async {
    if (code.isEmpty) {
      service.toast(context, "Please enter code");
      return false;
    }
    if (code.length < 4) {
      service.toast(context, "Please enter 4 digit");
      return false;
    }
    mapDetail(mapSubDetail, "code", code);
    mapDetail(mapSubDetail, "added_by", currentCandidate.candidatId);
    mapDetail(mapSubDetail, "added_time", DateTime.now());
    mapDetail(mapSubDetail, "id", const Uuid().v1());
    return true;
  }

  Future<bool> avgMeterValidate(BuildContext context, String avgMeter) async {
    if (avgMeter.isEmpty) {
      service.toast(context, "Please enter average meter");
      return false;
    }
    mapBeem(mapData, "name", int.parse(avgMeter.trim()));
    return true;
  }

  Future<void> mapBeem(
      Map<String, dynamic> data, String key, dynamic value) async {
    data[key] = value;
  }

  Future<void> mapDetail(
      Map<String, dynamic> addDetail, String key, dynamic value) async {
    addDetail[key] = value;
  }

  void validate(BuildContext context) {
    showConfirmation(context);
  }

  void showConfirmation(BuildContext context) {
    _recMeter.text = "0";
    _balMeter.text = "0";
    _recTaka.text = "0";
    _lastYearRecMeter.text = "0";
    _totalMeter2.text = "0";
    _recTaka2.text = "0";
    mapBeem(mapData, "rec_meter",
        int.parse(_recMeter.text)); //after production entry;
    mapBeem(mapData, "bal_meter",
        int.parse(_balMeter.text)); // after production entry
    mapBeem(mapData, "rec_taka", int.parse(_recTaka.text));
    mapBeem(mapData, "last_year_rec_meter", int.parse(_lastYearRecMeter.text));
    mapBeem(mapData, "total_meter2", int.parse(_totalMeter2.text));
    mapBeem(mapData, "rec_taka2", int.parse(_recTaka2.text));
    mapBeem(mapData, "added_by", currentCandidate.candidatId);
    mapBeem(mapData, "id", const Uuid().v1());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Detail"),
        content: confirmData(context),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Edit"),
          ),
          TextButton(
            onPressed: () => fire.storeBeem(context, mapData).whenComplete(() {
              Navigator.pop(context);
              Navigator.pop(context);
            }),
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }

  Widget confirmData(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        recMeter(context),
        height(5.0),
        balMeter(context),
        height(5.0),
        recTaka(context),
        height(5.0),
        totMtrs(context),
        height(5.0),
        recTaka2(context),
        height(5.0),
        lastYearRecMtrs(context),
      ],
    );
  }

  Widget recMeter(BuildContext context) {
    return Row(
      children: [
        const Text("Rec. Mtrs"),
        width(3.0),
        Expanded(
          child: TextFormField(
            controller: _recMeter,
            readOnly: true,
            decoration: InputDecoration(
              hintText: "Rec. Mtrs",
              hintStyle: const TextStyle(color: black, fontSize: 14.0),
              fillColor: Colors.black12,
              filled: true,
              // isDense: true,
              constraints: const BoxConstraints(
                maxHeight: 30.0,
              ),
              contentPadding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 0.0000000001, color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 0.0000000001, color: Colors.black12),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget balMeter(BuildContext context) {
    return Row(
      children: [
        const Text("Bal. Mtrs"),
        width(3.0),
        Expanded(
          child: TextFormField(
            controller: _balMeter,
            readOnly: true,
            decoration: InputDecoration(
              hintText: "Bal. Mtrs",
              hintStyle: const TextStyle(color: black, fontSize: 14.0),
              fillColor: Colors.black12,
              filled: true,
              // isDense: true,
              constraints: const BoxConstraints(
                maxHeight: 30.0,
              ),
              contentPadding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 0.0000000001, color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 0.0000000001, color: Colors.black12),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget recTaka(BuildContext context) {
    return Row(
      children: [
        const Text("Rec. Taka"),
        width(3.0),
        Expanded(
          child: TextFormField(
            controller: _recTaka,
            readOnly: true,
            decoration: InputDecoration(
              hintText: "Rec. Taka",
              hintStyle: const TextStyle(color: black, fontSize: 14.0),
              fillColor: Colors.black12,
              filled: true,
              // isDense: true,
              constraints: const BoxConstraints(
                maxHeight: 30.0,
              ),
              contentPadding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 0.0000000001, color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 0.0000000001, color: Colors.black12),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget lastYearRecMtrs(BuildContext context) {
    return Row(
      children: [
        const Text("Last Year Rec. Mtrs"),
        width(3.0),
        Expanded(
          child: TextFormField(
            controller: _lastYearRecMeter,
            readOnly: true,
            decoration: InputDecoration(
              hintText: "Last Year Rec. Mtrs",
              hintStyle: const TextStyle(color: black, fontSize: 14.0),
              fillColor: Colors.black12,
              filled: true,
              // isDense: true,
              constraints: const BoxConstraints(
                maxHeight: 30.0,
              ),
              contentPadding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 0.0000000001, color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 0.0000000001, color: Colors.black12),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget totMtrs(BuildContext context) {
    return Row(
      children: [
        const Text("Tot. Mtrs"),
        width(3.0),
        Expanded(
          child: TextFormField(
            controller: _totalMeter2,
            readOnly: true,
            decoration: InputDecoration(
              hintText: "Tot. Mtrs",
              hintStyle: const TextStyle(color: black, fontSize: 14.0),
              fillColor: Colors.black12,
              filled: true,
              // isDense: true,
              constraints: const BoxConstraints(
                maxHeight: 30.0,
              ),
              contentPadding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 0.0000000001, color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 0.0000000001, color: Colors.black12),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget recTaka2(BuildContext context) {
    return Row(
      children: [
        const Text("Rec. Taka"),
        width(3.0),
        Expanded(
          child: TextFormField(
            controller: _recTaka2,
            readOnly: true,
            decoration: InputDecoration(
              hintText: "Rec. Taka",
              hintStyle: const TextStyle(color: black, fontSize: 14.0),
              fillColor: Colors.black12,
              filled: true,
              // isDense: true,
              constraints: const BoxConstraints(
                maxHeight: 30.0,
              ),
              contentPadding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 0.0000000001, color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 0.0000000001, color: Colors.black12),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
