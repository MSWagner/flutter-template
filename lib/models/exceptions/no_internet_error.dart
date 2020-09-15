import 'package:dio/dio.dart';
import 'package:flutter_template/models/exceptions/network_error.dart';
import 'package:flutter_template/util/locale/localization_keys.dart';

class NoInternetError extends NetworkError {
  NoInternetError(DioError dioError) : super(dioError);

  @override
  String getLocalizedKey() => LocalizationKeys.errorNoNetwork;
}

class NoNetworkError extends Error {}
