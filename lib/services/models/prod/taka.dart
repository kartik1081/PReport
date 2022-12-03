import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:preport/services/models/prod/company.dart';

class Taka {
  String? addedBy,
      beemNo,
      bookCode,
      bookName,
      design,
      id,
      machineNo,
      meters,
      partyCode,
      partyName,
      pcs,
      price,
      qualityCode,
      qualityName,
      soldPrice,
      soldToCode,
      soldToName,
      takaNo;

  Timestamp? addedTime, soldTime;

  Taka({
    this.addedBy,
    this.addedTime,
    this.beemNo,
    this.bookCode,
    this.bookName,
    this.design,
    this.id,
    this.machineNo,
    this.meters,
    this.partyCode,
    this.partyName,
    this.pcs,
    this.qualityCode,
    this.qualityName,
    this.soldPrice,
    this.soldTime,
    this.soldToCode,
    this.soldToName,
    this.takaNo,
  });

  factory Taka.fromJson(Map<String, dynamic> json) {
    return Taka(
        addedBy: json["added_by"],
        addedTime: json["added_time"],
        beemNo: json["beem_no"],
        bookCode: json['book_code'],
        bookName: json["book_name"],
        design: json["design"],
        id: json["id"],
        machineNo: json["machine_no"],
        meters: json["meters"],
        partyCode: json["party_code"],
        partyName: json["party_name"],
        pcs: json["pcs"],
        qualityCode: json["quality_code"],
        qualityName: json["quality_name"],
        soldPrice: json["sold_price"],
        soldTime: json["sold_time"],
        soldToCode: json["sold_to_code"],
        soldToName: json["sold_to_name"],
        takaNo: json["taka_no"]);
  }

  Future<Map<String, dynamic>> takaToMap(
      Taka taka, Company company, String soldPrice, DateTime soldTime) async {
    return {
      "added_by": taka.addedBy,
      "added_time": taka.addedTime,
      "beem_no": taka.beemNo,
      "book_code": taka.bookCode,
      "book_name": taka.bookName,
      "design": taka.design,
      "id": taka.id,
      "machine_no": taka.machineNo,
      "meters": taka.meters,
      "party_code": taka.partyCode,
      "party_name": taka.partyName,
      "pcs": taka.pcs,
      "quality_code": taka.qualityCode,
      "quality_name": taka.qualityName,
      "sold_price": soldPrice,
      "sold_time": soldTime,
      "sold_to_code": company.code,
      "sold_to_name": company.name,
      "taka_no": taka.takaNo,
    };
  }
}
