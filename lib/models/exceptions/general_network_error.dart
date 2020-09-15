import 'package:flutter_template/models/exceptions/flutter_template_error.dart';
import 'package:flutter_template/util/locale/localization_keys.dart';

class GeneralError with FlutterTemplateError {
  GeneralError() : super();

  @override
  String getLocalizedKey() => LocalizationKeys.errorGeneral;
}
