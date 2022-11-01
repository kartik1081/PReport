import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_dial_code/country_dial_code.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

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
}
