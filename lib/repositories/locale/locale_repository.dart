import 'package:flutter/widgets.dart';
import 'package:flutter_template/repositories/locale/locale_repo.dart';
import 'package:flutter_template/repositories/shared_prefs/shared_prefs_storing.dart';

class Localerepositories extends LocaleRepo {
  static const _STORE_LOCALE = 'locale';

  final SharedPrefsStoring _sharedPrefs;

  Localerepositories(this._sharedPrefs);

  @override
  Future<void> setCustomLocale(Locale locale) async {
    if (locale == null) {
      await _sharedPrefs.deleteKey(_STORE_LOCALE);
    } else {
      await _sharedPrefs.saveString(key: _STORE_LOCALE, value: locale.languageCode);
    }
  }

  @override
  Locale getCustomLocale() {
    final localeCode = _sharedPrefs.getString(_STORE_LOCALE);
    if (localeCode == null || localeCode.isEmpty) return null;
    return Locale(localeCode);
  }
}
