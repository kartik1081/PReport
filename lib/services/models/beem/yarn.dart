import 'package:preport/services/basic.dart';

import '../../constant.dart';

class Yarn {
  String? addedBy, addedTime, code, id, name;

  Yarn({
    this.addedBy,
    this.addedTime,
    this.code,
    this.id,
    this.name,
  });

  factory Yarn.fromJson(Map<String, dynamic> json) {
    return Yarn(
        addedBy: json["added_by"],
        addedTime: service
            .getDateMonthYear(service.timeStampToDateTime(json["added_time"])),
        code: json["code"],
        id: json["id"],
        name: json["name"]);
  }
}
