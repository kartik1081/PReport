// ignore_for_file: file_names

class CountryModel {
  String name;
  String code;
  String dialCode;
  String flagUri;

  CountryModel(
      {required this.name,
      required this.code,
      required this.dialCode,
      required this.flagUri});

  factory CountryModel.init() {
    return CountryModel(
        code: "In", dialCode: "+91", name: "India", flagUri: "");
  }
}
