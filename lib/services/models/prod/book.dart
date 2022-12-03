import 'package:preport/services/basic.dart';

import '../../constant.dart';

class Book {
  String? addedBy, addedTime, code, id, name;

  Book({
    this.addedBy,
    this.addedTime,
    this.code,
    this.id,
    this.name,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      addedBy: json["added_by"],
      addedTime: service
          .getDateMonthYear(service.timeStampToDateTime(json["added_time"])),
      code: json["code"],
      id: json["id"],
      name: json["name"],
    );
  }
}
