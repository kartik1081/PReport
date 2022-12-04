// ignore_for_file: file_names, must_call_super

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preport/services/models/beem/quality.dart';
import 'package:preport/services/models/beem/yarn.dart';
import 'package:preport/services/models/company_candidate.dart';
import 'package:preport/services/models/current.dart';
import 'package:preport/services/models/prod/book.dart';

import '../constant.dart';
import '../models/beem/beem.dart';
import '../models/beem/warpar.dart';
import '../models/prod/company.dart';
import '../models/prod/party.dart';

class ListProvider with ChangeNotifier {
  List<Candidate> _candidateList = [];
  List<Warpar> _warparList = [];
  List<Quality> _qualityList = [];
  List<Yarn> _yarnList = [];
  List<Beem> _totalBeem = [];
  List<Beem> _runningBeem = [];
  List<Beem> _usedBeem = [];
  List<Book> _bookList = [];
  List<Party> _partyList = [];
  List<Company> _companyList = [];

  Warpar _selectedWarpar = Warpar();
  Quality _selectedQuality = Quality();
  Yarn _selectedYarn = Yarn();
  Beem _selectedBeem = Beem();
  Book _selectedBook = Book();
  Party _selectedParty = Party();
  Company _selectedCompany = Company();

  List<Candidate> get candidateList => _candidateList;
  List<Warpar> get warparList => _warparList;
  List<Quality> get qualityList => _qualityList;
  List<Yarn> get yarnList => _yarnList;
  List<Beem> get totalBeem => _totalBeem;
  List<Beem> get runningBeem => _runningBeem;
  List<Beem> get usedBeem => _usedBeem;
  List<Book> get bookList => _bookList;
  List<Party> get partyList => _partyList;
  List<Company> get companyList => _companyList;

  Warpar get selectedWarpar => _selectedWarpar;
  Quality get selectedQuality => _selectedQuality;
  Yarn get selectedYarn => _selectedYarn;
  Beem get selectedBeem => _selectedBeem;
  Book get selectedBook => _selectedBook;
  Party get selectedParty => _selectedParty;
  Company get selectedCompany => _selectedCompany;

  @override
  void dispose() {}

  Future<void> getWarparList() async {
    firestore
        .collection("Company")
        .doc(auth.currentUser!.uid)
        .collection("Lists")
        .doc("Details")
        .collection("Warpar List")
        .orderBy("code", descending: false)
        .get()
        .then(
          (snapshot) => snapshot.docs
              .map(
                (document) => Warpar.fromJson(
                  document.data(),
                ),
              )
              .toList(),
        )
        .then(
      (warparList) {
        _warparList = warparList;
        notifyListeners();
      },
    );
  }

  Future<void> selectWarpar(Warpar wrapar) async {
    _selectedWarpar = wrapar;
    notifyListeners();
  }

  Future<void> getQualityList() async {
    firestore
        .collection("Company")
        .doc(auth.currentUser!.uid)
        .collection("Lists")
        .doc("Details")
        .collection("Quality List")
        .orderBy("code", descending: false)
        .get()
        .then(
          (snapshot) => snapshot.docs
              .map(
                (document) => Quality.fromJson(
                  document.data(),
                ),
              )
              .toList(growable: true),
        )
        .then(
      (qualityList) {
        _qualityList = qualityList;
        notifyListeners();
      },
    );
  }

  Future<void> selectQuality(Quality quality) async {
    _selectedQuality = quality;
    notifyListeners();
  }

  Future<void> getYarnList() async {
    firestore
        .collection("Company")
        .doc(auth.currentUser!.uid)
        .collection("Lists")
        .doc("Details")
        .collection("Yarn List")
        .orderBy("code", descending: false)
        .get()
        .then(
          (snapshot) => snapshot.docs
              .map(
                (document) => Yarn.fromJson(
                  document.data(),
                ),
              )
              .toList(growable: true),
        )
        .then(
      (yarnList) {
        _yarnList = yarnList;
        notifyListeners();
      },
    );
  }

  Future<void> selectYarn(Yarn yarn) async {
    _selectedYarn = yarn;
    notifyListeners();
  }

  Future<void> getTotalBeem() async {
    firestore
        .collection("Company")
        .doc(auth.currentUser!.uid)
        .collection("Beem")
        .doc("BeemList")
        .collection("Total")
        .orderBy("arriving_time", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (document) => Beem.fromJson(
                  document.data(),
                ),
              )
              .toList(growable: true),
        )
        .listen((totalList) {
      _totalBeem = totalList;
      notifyListeners();
    });
  }

  Future<void> getRunningBeem() async {
    firestore
        .collection("Company")
        .doc(auth.currentUser!.uid)
        .collection("Beem")
        .doc("BeemList")
        .collection("Running")
        .orderBy("arriving_time", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (document) => Beem.fromJson(
                  document.data(),
                ),
              )
              .toList(growable: true),
        )
        .listen((runningList) {
      _runningBeem = runningList;
      notifyListeners();
    });
  }

  Future<void> selectRunningBeem(Beem beem) async {
    _selectedBeem = beem;
    notifyListeners();
  }

  Future<void> getUsedBeem() async {
    firestore
        .collection("Company")
        .doc(auth.currentUser!.uid)
        .collection("Beem")
        .doc("BeemList")
        .collection("Used")
        .orderBy("arriving_time", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (document) => Beem.fromJson(
                  document.data(),
                ),
              )
              .toList(growable: true),
        )
        .listen((usedList) {
      _usedBeem = usedList;
      notifyListeners();
    });
  }

  Future<void> getBookList() async {
    await firestore
        .collection("Company")
        .doc(auth.currentUser!.uid)
        .collection("Lists")
        .doc("Details")
        .collection("Book List")
        .get()
        .then(
          (snapshot) => snapshot.docs
              .map(
                (document) => Book.fromJson(
                  document.data(),
                ),
              )
              .toList(growable: true),
        )
        .then((bookList) {
      _bookList = bookList;
      notifyListeners();
    });
  }

  Future<void> selectBook(Book book) async {
    _selectedBook = book;
    notifyListeners();
  }

  Future<void> getPartyList() async {
    await firestore
        .collection("Company")
        .doc(auth.currentUser!.uid)
        .collection("Lists")
        .doc("Details")
        .collection("Party List")
        .get()
        .then(
          (snapshot) => snapshot.docs
              .map(
                (document) => Party.fromJson(
                  document.data(),
                ),
              )
              .toList(growable: true),
        )
        .then((partyList) {
      _partyList = partyList;
      notifyListeners();
    });
  }

  Future<void> selectParty(Party party) async {
    _selectedParty = party;
    notifyListeners();
  }

  Future<void> getCompanyList() async {
    await firestore
        .collection("Company")
        .doc(auth.currentUser!.uid)
        .collection("Companies")
        .get()
        .then((snapshot) => snapshot.docs
            .map((document) => Company.fromJson(document.data()))
            .toList(growable: true))
        .then((companyList) {
      _companyList = companyList;
      notifyListeners();
    });
  }

  void selecteSellingCompany(Company company) {
    _selectedCompany = company;
    notifyListeners();
  }
}
