import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:preport/pages/addFounder.dart';
import 'package:preport/pages/splash.dart';
import 'package:preport/services/basic.dart';
import 'package:preport/services/fire.dart';

class Registration extends StatelessWidget {
  Registration({required this.user, super.key});
  User user;

  final _formKey = GlobalKey<FormState>();
  final Fire _fire = Fire();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pNumber = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _landmark = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _pNumberFocus = FocusNode();
  final FocusNode _streetFocus = FocusNode();
  final FocusNode _landmarkFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _postalCodeFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final BasicService _service = BasicService();
  Map<String, dynamic> data = {"address": {}};

  @override
  Widget build(BuildContext context) {
    _email.text = user.email!;
    mapDetail(data, "email", user.email!);
    mapDetail(data, "company_id", user.uid);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          leading: leadingAppBar(context),
          title: const Text("Registration"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  dataCollectingImage(),
                  nameText(context),
                  sizedBox(),
                  emailText(context),
                  sizedBox(),
                  phoneNumberText(context),
                  sizedBox(),
                  foundingDateText(context),
                  const SizedBox(
                    height: 5.0,
                  ),
                  sizedBox(),
                  const Divider(
                    color: Colors.black54,
                    thickness: 0.5,
                  ),
                  addressText(context),
                  streetText(context),
                  sizedBox(),
                  landmarkText(context),
                  sizedBox(),
                  cityText(context),
                  sizedBox(),
                  postalText(context),
                  sizedBox(),
                  stateText(context),
                  sizedBox(),
                  countryText(context),
                  sizedBox(),
                  addFounderButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dataCollectingImage() {
    return const SizedBox(
      height: 170,
      width: 170,
      child: Image(
        image: AssetImage("assets/Data Collecting.png"),
      ),
    );
  }

  Widget leadingAppBar(BuildContext context) {
    return IconButton(
        onPressed: () {
          _fire.registrationAbort(context).whenComplete(
                () => _service.navigat(
                  context,
                  const Splash(),
                ),
              );
        },
        icon: const Icon(Icons.arrow_back));
  }

  Widget nameText(BuildContext context) {
    return TextFormField(
      controller: _name,
      enableSuggestions: true,
      autocorrect: true,
      focusNode: _nameFocus,
      keyboardType: TextInputType.name,
      onFieldSubmitted: (name) => nameValidate(context, name).then(
        (value) => value
            ? mapDetail(data, "name", name.toUpperCase().trim()).then(
                (value) => _pNumberFocus.requestFocus(),
              )
            : _nameFocus.requestFocus(),
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        hintText: "Comapany Name",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
        fillColor: Colors.white,
        filled: true,
        // isDense: true,
        constraints: const BoxConstraints(
          maxHeight: 30.0,
        ),
        contentPadding: const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget emailText(BuildContext context) {
    return TextFormField(
      controller: _email,
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail),
        hintText: "Email",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        constraints: const BoxConstraints(
          maxHeight: 30.0,
        ),
        contentPadding: const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget phoneNumberText(BuildContext context) {
    return TextFormField(
      controller: _pNumber,
      enableSuggestions: true,
      autocorrect: true,
      focusNode: _pNumberFocus,
      keyboardType: TextInputType.phone,
      onFieldSubmitted: (pNumber) => phoneNumberValidate(context, pNumber).then(
          (value) => value
              ? mapDetail(data, "phone_number", pNumber.trim())
              : _pNumberFocus.requestFocus()),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.phone_android),
        hintText: "Mobile Number",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        constraints: const BoxConstraints(
          maxHeight: 30.0,
        ),
        contentPadding: const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget foundingDateText(BuildContext context) {
    return TextFormField(
      controller: _date,
      enableSuggestions: true,
      autocorrect: true,
      readOnly: true,
      onTap: () => _service.selectDate(context).then((value) {
        _date.text = value["String"];
        mapDetail(data, "founding_date", value["DateTime"]);
      }),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.date_range),
        hintText: "-- Select Founding Date --",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        constraints: const BoxConstraints(
          maxHeight: 30.0,
        ),
        contentPadding: const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget addressText(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5.0),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
      child: const Text(
        "Address:",
        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
      ),
    );
  }

  Widget streetText(BuildContext context) {
    return TextFormField(
      controller: _street,
      enableSuggestions: true,
      autocorrect: true,
      focusNode: _streetFocus,
      keyboardType: TextInputType.streetAddress,
      onFieldSubmitted: (street) => streetValidate(context, street).then(
        (value) => value
            ? mapAddress(data, "street", street.toUpperCase().trim()).then(
                (value) => _landmarkFocus.requestFocus(),
              )
            : _streetFocus.requestFocus(),
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        hintText: "House No. / Street",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        constraints: const BoxConstraints(
          maxHeight: 30.0,
        ),
        contentPadding: const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget landmarkText(BuildContext context) {
    return TextFormField(
      controller: _landmark,
      enableSuggestions: true,
      autocorrect: true,
      focusNode: _landmarkFocus,
      keyboardType: TextInputType.streetAddress,
      onFieldSubmitted: (landmark) =>
          mapAddress(data, "landmark", landmark.toUpperCase().trim()).then(
        (value) => _cityFocus.requestFocus(),
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.location_on),
        hintText: "Landmark (Optional)",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        constraints: const BoxConstraints(
          maxHeight: 30.0,
        ),
        contentPadding: const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget cityText(BuildContext context) {
    return TextFormField(
      controller: _city,
      enableSuggestions: true,
      autocorrect: true,
      focusNode: _cityFocus,
      keyboardType: TextInputType.name,
      onFieldSubmitted: (city) => cityValidate(context, city).then(
        (value) => value
            ? mapAddress(data, "city", city).then(
                (value) => _postalCodeFocus.requestFocus(),
              )
            : _cityFocus.requestFocus(),
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.location_city),
        hintText: "City",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        constraints: const BoxConstraints(
          maxHeight: 30.0,
        ),
        contentPadding: const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget postalText(BuildContext context) {
    return TextFormField(
      controller: _postalCode,
      enableSuggestions: true,
      autocorrect: true,
      focusNode: _postalCodeFocus,
      keyboardType: TextInputType.number,
      onFieldSubmitted: (postalCode) =>
          postalCodeValidate(context, postalCode).then(
        (value) => value
            ? mapAddress(data, "postal_code", postalCode.toUpperCase().trim())
                .then(
                (value) => _stateFocus.requestFocus(),
              )
            : _postalCodeFocus.requestFocus(),
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.location_on),
        hintText: "Postal Code",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        constraints: const BoxConstraints(
          maxHeight: 30.0,
        ),
        contentPadding: const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget stateText(BuildContext context) {
    return TextFormField(
      controller: _state,
      enableSuggestions: true,
      autocorrect: true,
      focusNode: _stateFocus,
      keyboardType: TextInputType.name,
      onFieldSubmitted: (state) => stateValidate(context, state).then(
        (value) => value
            ? mapAddress(data, "state", state.toUpperCase().trim())
            : _stateFocus.requestFocus(),
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.location_on),
        hintText: "State",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        constraints: const BoxConstraints(
          maxHeight: 30.0,
        ),
        contentPadding: const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget countryText(BuildContext context) {
    return TextFormField(
      controller: _country,
      enableSuggestions: true,
      autocorrect: true,
      keyboardType: TextInputType.name,
      readOnly: true,
      onTap: () => showCountryPicker(
        context: context,
        onSelect: (value) {
          _service.getCountryDetail(context, value.countryCode).then(
            (value) {
              mapAddress(data, "country", value.name.toUpperCase().trim())
                  .whenComplete(
                      () => mapDetail(data, "dial_code", value.dialCode))
                  .whenComplete(() => _country.text = value.name);
            },
          );
        },
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.language_rounded),
        hintText: "-- Select Country --",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        constraints: const BoxConstraints(
          maxHeight: 30.0,
        ),
        contentPadding: const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0000000001, color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget sizedBox() {
    return const SizedBox(
      height: 10.0,
    );
  }

  Widget addFounderButton(BuildContext context) {
    return InkWell(
      onTap: () => validate(context),
      child: SizedBox(
        child: Container(
          height: 44.0,
          width: 156.0,
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          decoration: const BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: const Center(
            child: Text(
              "Add Founder",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validate(BuildContext context) {
    nameValidate(context, _name.text).then((value) => value
        ? emailValidate(context, _email.text).then((value) => value
            ? phoneNumberValidate(context, _pNumber.text).then((value) => value
                ? foundingDateValidate(context, _date.text).then((value) =>
                    value
                        ? streetValidate(context, _street.text).then((value) =>
                            value
                                ? cityValidate(context, _city.text).then(
                                    (value) => value
                                        ? postalCodeValidate(
                                                context, _postalCode.text)
                                            .then((value) => value
                                                ? stateValidate(
                                                        context, _state.text)
                                                    .then((value) => value
                                                        ? countryValidate(
                                                                context,
                                                                _country.text)
                                                            .then((value) =>
                                                                value
                                                                    ? _fire
                                                                        .storeCompanyDetail(
                                                                            data)
                                                                        .then(
                                                                        (value) {
                                                                          clearTextField();
                                                                          return _service
                                                                              .navigat(
                                                                            context,
                                                                            AddFounder(fromRegister: true),
                                                                          );
                                                                        },
                                                                      )
                                                                    : null)
                                                        : null)
                                                : null)
                                        : null)
                                : null)
                        : null)
                : null)
            : null)
        : null);
  }

  Future<bool> nameValidate(BuildContext context, String name) async {
    if (name.isEmpty) {
      toast(context, "Please enter Name");
      return false;
    }
    return true;
  }

  Future<bool> emailValidate(BuildContext context, String email) async {
    if (email.isEmpty) {
      toast(context, "Please enter Email");
      return false;
    }
    // if (_service.emailRegex.hasMatch(email)) {
    //   toast(context, "Please enter valid Email");
    //   return false;
    // }
    return true;
  }

  Future<bool> phoneNumberValidate(BuildContext context, String pNumber) async {
    if (pNumber.isEmpty) {
      toast(context, "Please enter Phone Number");
      return false;
    } else if (!_service.phoneRegex.hasMatch(pNumber)) {
      toast(context, "Please enter valid Phone Number");
      return false;
    }
    return true;
  }

  Future<bool> foundingDateValidate(
      BuildContext context, String foundingDate) async {
    if (foundingDate.isEmpty) {
      toast(context, "Please enter Founding Date");
      return false;
    }
    return true;
  }

  Future<bool> streetValidate(BuildContext context, String street) async {
    if (street.isEmpty) {
      toast(context, "Please enter Street");
      return false;
    }
    return true;
  }

  Future<bool> cityValidate(BuildContext context, String city) async {
    if (city.isEmpty) {
      toast(context, "Please enter City");
      return false;
    }
    return true;
  }

  Future<bool> postalCodeValidate(
      BuildContext context, String postalCode) async {
    if (postalCode.isEmpty) {
      toast(context, "Please enter Postal Code");
      return false;
    }
    if (postalCode.length < 6 || postalCode.length > 6) {
      toast(context, "Please enter valid Postal Code");
      return false;
    }
    return true;
  }

  Future<bool> stateValidate(BuildContext context, String state) async {
    if (state.isEmpty) {
      toast(context, "Please enter State");
      return false;
    }
    return true;
  }

  Future<bool> countryValidate(BuildContext context, String country) async {
    if (country.isEmpty) {
      toast(context, "Please enter Country");
      return false;
    }
    return true;
  }

  Future<void> mapDetail(
      Map<String, dynamic> data, String key, dynamic value) async {
    data[key] = value;
    print(data[key]);
  }

  Future<void> mapAddress(
      Map<String, dynamic> data, String key, dynamic value) async {
    data["address"][key] = value;
    print(data["address"][key]);
  }

  void toast(BuildContext context, String error) {
    Fluttertoast.showToast(msg: error);
  }

  void clearTextField() {
    _name.clear();
    _email.clear();
    _pNumber.clear();
    _date.clear();
    _street.clear();
    _landmark.clear();
    _city.clear();
    _postalCode.clear();
    _state.clear();
    _country.clear();
  }
}
