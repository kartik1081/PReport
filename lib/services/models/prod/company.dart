class Company {
  String? addedBy,
      addedTime,
      street,
      landmark,
      city,
      postalCode,
      state,
      country,
      code,
      id,
      name;

  Company({
    this.addedBy,
    this.addedTime,
    this.city,
    this.code,
    this.country,
    this.id,
    this.landmark,
    this.name,
    this.postalCode,
    this.state,
    this.street,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      addedBy: json["added_by"],
      addedTime: json["added_time"],
      city: json["city"],
      code: json["code"],
      country: json["country"],
      id: json["id"],
      landmark: json["landmark"],
      name: json["name"],
      postalCode: json["postal_code"],
      state: json["state"],
      street: json["street"],
    );
  }
}
