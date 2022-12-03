import 'package:preport/services/basic.dart';

import '../../constant.dart';

class Party {
  String? addedBy, addedTime, code, id, name;

  Party({
    this.addedBy,
    this.addedTime,
    this.code,
    this.id,
    this.name,
  });

  factory Party.fromJson(Map<String, dynamic> json) {
    return Party(
      addedBy: json["added_by"],
      addedTime: service
          .getDateMonthYear(service.timeStampToDateTime(json["added_time"])),
      code: json["code"],
      id: json["id"],
      name: json["name"],
    );
  }
}
