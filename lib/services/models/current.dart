import '../constant.dart';
import 'company_candidate.dart';

class CurrentCompany {
  String? companyId,
      dialCode,
      email,
      foundingDate,
      name,
      phoneNumber,
      city,
      country,
      landmark,
      postalCode,
      state,
      street;

  CurrentCompany({
    this.companyId,
    this.dialCode,
    this.email,
    this.foundingDate,
    this.name,
    this.phoneNumber,
    this.city,
    this.country,
    this.landmark,
    this.postalCode,
    this.state,
    this.street,
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
      foundingDate: service.getDateMonth(json["founding_date"]),
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
  String? birthDate,
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
      landmark,
      postalCode,
      state,
      street;

  CurrentCandidate({
    this.birthDate,
    this.candidatId,
    this.dialCode,
    this.email,
    this.gender,
    this.name,
    this.password,
    this.phoneNumber,
    this.position,
    this.profilePic,
    this.city,
    this.country,
    this.landmark,
    this.postalCode,
    this.state,
    this.street,
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
