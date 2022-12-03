import '../../constant.dart';

class Quality {
  String? addedBy, addedTime, code, id, name;

  Quality({
    this.addedBy,
    this.addedTime,
    this.code,
    this.id,
    this.name,
  });

  factory Quality.fromJson(Map<String, dynamic> json) {
    return Quality(
        addedBy: json["added_by"],
        addedTime: service
            .getDateMonthYear(service.timeStampToDateTime(json["added_time"])),
        code: json["code"],
        id: json["id"],
        name: json["name"]);
  }
}
