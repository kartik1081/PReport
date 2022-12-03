import '../constant.dart';

class Compnay {
  String companyId,
      dialCode,
      email,
      foundingDate,
      name,
      phoneNumber,
      city,
      country,
      postalCode,
      state,
      street;
  String? landmark;

  Compnay({
    required this.companyId,
    required this.dialCode,
    required this.email,
    required this.foundingDate,
    required this.name,
    required this.phoneNumber,
    required this.city,
    required this.country,
    this.landmark,
    required this.postalCode,
    required this.state,
    required this.street,
  });

  factory Compnay.fromJson(Map<String, dynamic> json) {
    return Compnay(
      companyId: json["company_id"],
      dialCode: json["dial_code"],
      email: json["email"],
      foundingDate: json["founding_date"],
      name: json["name"],
      phoneNumber: json["phone_number"],
      city: json["address"]["city"],
      country: json["address"]["country"],
      landmark: json["address"]["landmark"],
      postalCode: json["address"]["postal_code"],
      state: json["address"]["state"],
      street: json["address"]["street"],
    );
  }
}

class Candidate {
  String birthDate,
      candidatId,
      dialCode,
      email,
      gender,
      name,
      password,
      phoneNumber,
      position,
      profilePic,
      registeredDate,
      city,
      country,
      postalCode,
      state,
      street;
  String? landmark;
  bool admin;

  Candidate({
    required this.birthDate,
    required this.candidatId,
    required this.dialCode,
    required this.email,
    required this.gender,
    required this.name,
    required this.password,
    required this.phoneNumber,
    required this.position,
    required this.profilePic,
    required this.registeredDate,
    required this.city,
    required this.country,
    this.landmark,
    required this.postalCode,
    required this.state,
    required this.street,
    required this.admin,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      birthDate: service.getDateMonth(json["birth_date"]),
      candidatId: json["candidate_id"],
      dialCode: json["dial_code"],
      email: json["email"],
      gender: json["gender"],
      name: json["name"],
      password: json["password"],
      phoneNumber: json["phone_number"],
      position: json["position"],
      profilePic: json["profile_pic"],
      registeredDate: service.getDateMonthYear(
        service.timeStampToDateTime(
          json["registered_date"],
        ),
      ),
      city: json["address"]["city"],
      country: json["address"]["country"],
      landmark: json["address"]["landmark"],
      postalCode: json["address"]["postal_code"],
      state: json["address"]["state"],
      street: json["address"]["street"],
      admin: json["admin"],
    );
  }
}
