import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_dial_code/country_dial_code.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'models/beem/beem.dart';

class BasicService {
  final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  final RegExp phoneRegex = RegExp(r'^[6-9]\d{9}$');

  Future<void> navigat(BuildContext context, Widget widget) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  Future<Map<String, dynamic>> selectDate(BuildContext context) async {
    Map<String, dynamic> date = {"DateTime": DateTime.now(), "String": ""};
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
      helpText: "SELECT FOUNDING DATE",
      cancelText: "NOT NOW",
      confirmText: "SELECT",
      fieldHintText: "DATE/MONTH/YEAR",
      fieldLabelText: "FOUNDING DATE",
    );
    if (selected != null && selected != DateTime.now()) {
      date["DateTime"] = selected;
      date["String"] =
          "${selected.toLocal().day}/${selected.toLocal().month}/${selected.toLocal().year}";
    }
    return date;
  }

  Future<CountryDialCode> getCountryDetail(
      BuildContext context, String countryCode) async {
    return CountryDialCode.fromCountryCode(countryCode);
  }

  DateTime timeStampToDateTime(Timestamp timestamp) {
    DateTime dateTime;
    dateTime =
        DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);
    return dateTime;
  }

  String getDateTime(Timestamp timestamp) {
    DateTime dateTime = timeStampToDateTime(timestamp);
    DateTime current = DateTime.now();
    Duration differance = current.difference(dateTime);
    return DateFormat(differance.inHours > 24 ? "dd MMM" : "HH:mm")
        .format(dateTime);
  }

  String getTime(DateTime dateTime) {
    return DateFormat("HH:mm").format(dateTime);
  }

  String getDateMonth(Timestamp timestamp) {
    DateTime dateTime = timeStampToDateTime(timestamp);
    return DateFormat("dd MMM").format(dateTime);
  }

  String getDateMonthYear(DateTime datetime) {
    return DateFormat("dd MMM yyy").format(datetime);
  }

  void toast(BuildContext context, String error) {
    Fluttertoast.showToast(msg: error);
  }

  Future<Map<String, dynamic>> beemToMap(Beem beem) async {
    return {
      "added_by": beem.addedBy,
      "amount": beem.amount,
      "arriving_time": beem.arrivingDate,
      "bal_meter": beem.balMeter,
      "beem_no": beem.beemNo,
      "beem_size": beem.beemSize,
      "end_date": beem.endDate,
      "gross_wt": beem.grossWt,
      "id": beem.id,
      "last_year_rec_meter": beem.lastYearRecMeter,
      "loading_date": DateTime.now(),
      "loom_no": beem.loomNo,
      "min_strg": beem.minStrg,
      "name": beem.name,
      "pick": beem.pick,
      "pipe_no": beem.pipeNo,
      "pipe_wt": beem.pipeWt,
      "pno": beem.pno,
      "quality_code": beem.qualityCode,
      "quality_name": beem.qualityName,
      "rec_taka2": beem.reTaka2,
      "rec_meter": beem.recMeter,
      "rec_taka": beem.recTaka,
      "remark": beem.remark,
      "rpm": beem.rpm,
      "tar": beem.tar,
      "total_meter2": beem.totalMeter2,
      "total_meter_consum": beem.totalMeterConsum,
      "total_meter": beem.totalMetr,
      "total_taka": beem.totalTaka,
      "warpar_code": beem.warparCode,
      "warpar_name": beem.warparName,
      "warpar_rate": beem.warparRate,
      "yarn_code": beem.yarnCode,
      "yarn_lot_no": beem.yarnLotNo,
      "yarn_name": beem.yarnName,
      "yarn_net_wt": beem.yarnNetWt,
    };
  }
}
