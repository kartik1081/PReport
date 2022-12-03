import 'package:flutter/cupertino.dart';
import 'package:preport/services/fire.dart';

import '../constant.dart';
import '../models/company_candidate.dart';
import '../models/current.dart';

class CurrentProvider with ChangeNotifier {
  CurrentCandidate _currentCandidate = CurrentCandidate.init();
  CurrentCompany _currentCompany = CurrentCompany.init();
  CurrentCandidate get currentCandidate => _currentCandidate;
  CurrentCompany get currentCompany => _currentCompany;

  @override
  void dispose() {}

  Future<void> currentCandidateDetail(Candidate candidate) async {
    _currentCandidate = CurrentCandidate.fromCandidate(candidate);
    notifyListeners();
  }

  Future<void> getCompanyDetail() async {
    await fire.getCompanyDetail().then((value) => _currentCompany = value);
  }
}
