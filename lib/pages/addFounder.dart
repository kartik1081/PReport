// ignore_for_file: file_names, must_be_immutable

import 'dart:async';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:preport/pages/chooseUser.dart';
import 'package:preport/pages/splash.dart';
import 'package:preport/services/ValueListener/registrationListener.dart';
import 'package:preport/services/constant.dart';

class AddFounder extends StatelessWidget {
  AddFounder({required this.fromRegister, super.key});
  bool fromRegister;

  final _formKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
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
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final RegistrationListener _registrationListener = RegistrationListener();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _pNumberFocus = FocusNode();
  final FocusNode _streetFocus = FocusNode();
  final FocusNode _landmarkFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _postalCodeFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  Map<String, dynamic> data = {"address": {}};

  @override
  Widget build(BuildContext context) {
    data["admin"] = fromRegister;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:background,
      appBar: AppBar(
        backgroundColor:appbar,
        title: const Text("Register Founder"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                positionRadio(context),
                sizedBox(),
                const Divider(height: 2.0, thickness: 2.0),
                sizedBox(),
                nameText(context),
                sizedBox(),
                emailText(context),
                sizedBox(),
                phoneNumberText(context),
                sizedBox(),
                genderRadio(context),
                sizedBox(),
                birthDateText(context),
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
                registerCandidate(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget positionRadio(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: _registrationListener.position,
      builder: (context, value, child) {
        mapDetail(data, "position", value!.toUpperCase().trim());
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "As: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Radio(
                  groupValue: value,
                  value: "Owner",
                  onChanged: (position) {
                    _registrationListener.selectPosition(position!);
                  },
                  activeColor: Colors.redAccent,
                ),
                const Text("Onwer")
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  groupValue: value,
                  value: "Master",
                  onChanged: (position) {
                    _registrationListener.selectPosition(position!);
                  },
                  activeColor: Colors.redAccent,
                ),
                const Text("Master")
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  groupValue: value,
                  value: "Worker",
                  onChanged: (position) {
                    _registrationListener.selectPosition(position!);
                  },
                  activeColor: Colors.redAccent,
                ),
                const Text("Worker")
              ],
            ),
          ],
        );
      },
    );
  }

  Widget genderRadio(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: _registrationListener.gender,
      builder: (context, value, child) {
        mapDetail(data, "gender", value!.toUpperCase().trim());
        return Row(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  groupValue: value,
                  value: "Male",
                  onChanged: (gender) {
                    _registrationListener.selectGender(gender!);
                  },
                  activeColor: Colors.redAccent,
                ),
                const Text("Male")
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  groupValue: value,
                  value: "Female",
                  onChanged: (gender) {
                    _registrationListener.selectGender(gender!);
                  },
                  activeColor: Colors.redAccent,
                ),
                const Text("Female")
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  groupValue: value,
                  value: "Other",
                  onChanged: (gender) {
                    _registrationListener.selectGender(gender!);
                  },
                  activeColor: Colors.redAccent,
                ),
                const Text("Other")
              ],
            ),
          ],
        );
      },
    );
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
            ? mapDetail(data, "name", name.toUpperCase().trim()).whenComplete(
                () => _emailFocus.requestFocus(),
              )
            : _nameFocus.requestFocus(),
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        hintText: "Name",
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
      enableSuggestions: true,
      autocorrect: true,
      focusNode: _emailFocus,
      keyboardType: TextInputType.emailAddress,
      onFieldSubmitted: (email) => emailValidate(context, email).then(
        (value) => value
            ? mapDetail(data, "email", email.trim()).whenComplete(
                () => _pNumberFocus.requestFocus(),
              )
            : _emailFocus.requestFocus(),
      ),
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
            : _pNumberFocus.requestFocus(),
      ),
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

  Widget birthDateText(BuildContext context) {
    return TextFormField(
      controller: _date,
      enableSuggestions: true,
      autocorrect: true,
      readOnly: true,
      onTap: () => service.selectDate(context).then((value) {
        _date.text = value["String"];
        mapDetail(data, "birth_date", value["DateTime"]);
      }),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.date_range),
        hintText: "-- Select Birth Date --",
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
          service.getCountryDetail(context, value.countryCode).then(
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

  Widget registerCandidate(BuildContext context) {
    return InkWell(
      onTap: () => validate(context),
      child: SizedBox(
        child: Container(
          height: 44.0,
          width: 187.0,
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          decoration: const BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: const Center(
            child: Text(
              "Register Founder",
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
                ? foundingDateValidate(context, _date.text).then((value) => value
                    ? streetValidate(context, _street.text).then((value) => value
                        ? cityValidate(context, _city.text).then((value) => value
                            ? postalCodeValidate(context, _postalCode.text).then((value) => value ? stateValidate(context, _state.text).then((value) => value ? countryValidate(context, _country.text).then((value) => value ? setUserPassword(context) : null) : null) : null)
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
    mapDetail(data, "name", name.toUpperCase().trim());
    return true;
  }

  Future<bool> emailValidate(BuildContext context, String email) async {
    if (email.isEmpty) {
      toast(context, "Please enter Email");
      return false;
    }
    if (!service.emailRegex.hasMatch(email)) {
      toast(context, "Please enter valid Email");
      return false;
    }
    mapDetail(data, "email", email.trim());
    return true;
  }

  Future<bool> phoneNumberValidate(BuildContext context, String pNumber) async {
    if (pNumber.isEmpty) {
      toast(context, "Please enter Phone Number");
      return false;
    } else if (!service.phoneRegex.hasMatch(pNumber)) {
      toast(context, "Please enter valid Phone Number");
      return false;
    }
    mapDetail(data, "phone_number", pNumber.trim());
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
    mapAddress(data, "street", street);
    return true;
  }

  Future<bool> cityValidate(BuildContext context, String city) async {
    if (city.isEmpty) {
      toast(context, "Please enter City");
      return false;
    }
    mapAddress(data, "landmark", _landmark.text);
    mapAddress(data, "city", city);
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
    mapAddress(data, "postal_code", postalCode);
    return true;
  }

  Future<bool> stateValidate(BuildContext context, String state) async {
    if (state.isEmpty) {
      toast(context, "Please enter State");
      return false;
    }
    mapAddress(data, "state", state);
    return true;
  }

  Future<bool> countryValidate(BuildContext context, String country) async {
    if (country.isEmpty) {
      toast(context, "Please enter Country");
      return false;
    }
    mapAddress(data, "country", country);
    return true;
  }

  Future<bool> passwordValidate(BuildContext context, String password,
      bool confirm, String? confirmPassword) async {
    if (confirm) {
      if (confirmPassword!.isEmpty) {
        toast(context, "Please enter Confirmation Password");
        return false;
      }
      if (password != confirmPassword) {
        toast(context, "Please enter same password");
        return false;
      }
    }
    if (password.isEmpty) {
      toast(context, "Please enter Password");
      return false;
    }
    if (password.length < 8) {
      toast(context, "Please enter strong password");
      return false;
    }
    return true;
  }

  Future<void> mapDetail(
      Map<String, dynamic> data, String key, dynamic value) async {
    data[key] = value;
  }

  Future<void> mapAddress(
      Map<String, dynamic> data, String key, dynamic value) async {
    data["address"][key] = value;
  }

  Future<void> setUserPassword(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Set Password for User"),
        content: Form(
          key: _passwordKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _password,
                focusNode: _passwordFocus,
                keyboardType: TextInputType.visiblePassword,
                onFieldSubmitted: (password) =>
                    passwordValidate(context, password, false, null).then(
                        (value) => value
                            ? _confirmPasswordFocus.requestFocus()
                            : _passwordFocus),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  hintText: "Enter Password",
                  hintStyle:
                      const TextStyle(color: Colors.grey, fontSize: 14.0),
                  fillColor: Colors.white,
                  filled: true,
                  constraints: const BoxConstraints(
                    maxHeight: 40.0,
                  ),
                  contentPadding:
                      const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 0.0000000001, color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 0.0000000001, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              TextFormField(
                controller: _confirmPassword,
                focusNode: _confirmPasswordFocus,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                onFieldSubmitted: (confirmPassword) => passwordValidate(
                        context, _password.text, true, confirmPassword)
                    .then(
                  (value) => value
                      ? mapDetail(data, "password", confirmPassword)
                      : null,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  hintText: "Re-Enter Password",
                  hintStyle:
                      const TextStyle(color: Colors.grey, fontSize: 14.0),
                  fillColor: Colors.white,
                  filled: true,
                  constraints: const BoxConstraints(
                    maxHeight: 40.0,
                  ),
                  contentPadding:
                      const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 0.0000000001, color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 0.0000000001, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              )
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              clearePassword();
            },
            child: const Text("cancle"),
          ),
          TextButton(
            onPressed: () =>
                passwordValidate(context, _password.text, false, null).then(
                    (value) => value
                        ? passwordValidate(context, _password.text, true,
                                _confirmPassword.text)
                            .then((value) {
                            if (value) {
                              mapDetail(data, "password", _confirmPassword.text)
                                  .then(
                                (value) =>
                                    fire.storeCandidateDetail(data).then(
                                  (value) {
                                    clearTextField();
                                    Navigator.pop(context);
                                  },
                                ),
                              )
                                  .whenComplete(
                                () {
                                  clearePassword();
                                  !fromRegister
                                      ? service.navigat(
                                          context,
                                          ChooseUser(),
                                        )
                                      : addCandidate(context);
                                },
                              );
                            } else {
                              _confirmPassword.clear();
                            }
                          })
                        : _passwordFocus.requestFocus()),
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }

  Future<void> addCandidate(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Candidate is Registered"),
        content: const Text("Want add Candidate..?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                service
                    .navigat(
                      context,
                      const Splash(),
                    )
                    .whenComplete(
                      () => fire.signOut(context),
                    );
              },
              child: const Text("No")),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10.0),
              height: 40.0,
              width: 80.0,
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: const Center(
                child: Text("Add"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void toast(BuildContext context, String error) {
    Fluttertoast.showToast(msg: error);
  }

  void clearePassword() {
    _password.clear();
    _confirmPassword.clear();
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
