import '../../constant.dart';

class Warpar {
  String? addedBy, addedTime, code, id, name;

  Warpar({
    this.addedBy,
    this.addedTime,
    this.code,
    this.id,
    this.name,
  });

  factory Warpar.fromJson(Map<String, dynamic> json) {
    return Warpar(
        addedBy: json["added_by"],
        addedTime: service
            .getDateMonthYear(service.timeStampToDateTime(json["added_time"])),
        code: json["code"],
        id: json["id"],
        name: json["name"]);
  }
}
