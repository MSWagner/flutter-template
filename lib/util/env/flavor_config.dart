import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

enum Flavor {
  TEST,
  DUMMY,
  DEV, //We use DEV instead of DEBUG because android already has a release type Debug.
  STAGING,
  PROD,
}

class FlavorValues {
  final String baseUrl;
  final bool logNetworkInfo;

  const FlavorValues({@required this.baseUrl, @required this.logNetworkInfo});
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final Color color;
  final FlavorValues values;
  static FlavorConfig _instance;

  factory FlavorConfig({
    @required Flavor flavor,
    @required String name,
    @required Color color,
    @required FlavorValues values,
  }) =>
      _instance = FlavorConfig._internal(flavor, name, color, values);

  FlavorConfig._internal(this.flavor, this.name, this.color, this.values);

  static FlavorConfig get instance => _instance;

  static bool isProd() => _instance.flavor == Flavor.PROD;

  static bool isStaging() => _instance.flavor == Flavor.STAGING;

  static bool isDev() => _instance.flavor == Flavor.DEV;

  static bool isInTest() => _instance.flavor == Flavor.TEST;

  static bool isDummy() => _instance.flavor == Flavor.DUMMY;
}
