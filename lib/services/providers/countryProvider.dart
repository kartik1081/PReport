import 'package:country_dial_code/country_dial_code.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:preport/models/countryModel.dart';

class CountryProvider extends ChangeNotifier {
  late CountryDialCode _countryDialCode;

  CountryModel _myCountryDetail = CountryModel.init();
  CountryModel get myCountryDetail => _myCountryDetail;
}
