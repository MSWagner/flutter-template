import 'package:flutter/material.dart';
import 'package:flutter_template/util/license.dart';
import 'package:flutter_template/navigation/navigators/back_navigator.dart';

class LicenseViewModel with ChangeNotifier {
  LicenseNavigator _navigator;

  List<License> get licenses => LicenseUtil.getLicenses();

  Future<void> init(LicenseNavigator navigator) async {
    _navigator = navigator;
  }

  void onBackClicked() => _navigator.goBack();
}

abstract class LicenseNavigator with BackNavigator {}
