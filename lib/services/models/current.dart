import 'package:preport/services/basic.dart';

import 'company_candidate.dart';

final BasicService _service = BasicService();

class CurrentCompany {
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

  CurrentCompany({
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

  factory CurrentCompany.init() {
    return CurrentCompany(
        companyId: "",
        dialCode: "",
        email: "",
        foundingDate: "",
        name: "",
        phoneNumber: "",
        city: "",
        country: "",
        postalCode: "",
        state: "",
        street: "");
  }

  factory CurrentCompany.fromJson(Map<String, dynamic> json) {
    return CurrentCompany(
      companyId: json["company_id"],
      dialCode: json["dial_code"],
      email: json["email"],
      foundingDate: _service.getDateMonth(json["founding_date"]),
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

class CurrentCandidate {
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
      city,
      country,
      postalCode,
      state,
      street;
  String? landmark;

  CurrentCandidate({
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
    required this.city,
    required this.country,
    this.landmark,
    required this.postalCode,
    required this.state,
    required this.street,
  });

  factory CurrentCandidate.init() {
    return CurrentCandidate(
        birthDate: "",
        candidatId: "",
        dialCode: "",
        email: "",
        gender: "",
        name: "",
        password: "",
        phoneNumber: "",
        position: "",
        profilePic: "",
        city: "",
        country: "",
        landmark: "",
        postalCode: "",
        state: "",
        street: "");
  }

  factory CurrentCandidate.fromCandidate(Candidate candidate) {
    return CurrentCandidate(
        birthDate: candidate.birthDate,
        candidatId: candidate.candidatId,
        dialCode: candidate.dialCode,
        email: candidate.email,
        gender: candidate.gender,
        name: candidate.name,
        password: candidate.password,
        phoneNumber: candidate.phoneNumber,
        position: candidate.position,
        profilePic: candidate.profilePic,
        city: candidate.city,
        country: candidate.country,
        landmark: candidate.landmark,
        postalCode: candidate.postalCode,
        state: candidate.state,
        street: candidate.street);
  }
}
