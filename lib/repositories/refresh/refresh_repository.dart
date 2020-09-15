import 'package:dio/dio.dart';
import 'package:flutter_template/models/exceptions/un_authorized_error.dart';
import 'package:flutter_template/repositories/refresh/refresh_repo.dart';
import 'package:flutter_template/repositories/secure_storage/auth/auth_storing.dart';
import 'package:flutter_template/util/logger/flutter_template_logger.dart';
import 'package:synchronized/synchronized.dart' as synchronized;

class Refreshrepositories extends RefreshRepo {
  final AuthStoring _authStoring;
  final _lock = synchronized.Lock();
  bool _failure = false;

  Refreshrepositories(this._authStoring);

  @override
  void resetFailure() {
    _failure = false;
  }

  @override
  Future refresh(DioError err) async {
    final accessToken = await _authStoring.getAccessToken();
    await _lock.synchronized(() async {
      final newAccessToken = await _authStoring.getAccessToken();
      if (accessToken != newAccessToken) {
        FlutterTemplateLogger.logDebug('ACCESS TOKEN was already renewed');
        return;
      }
      if (_failure) {
        throw UnAuthorizedError(err);
      }
      try {
         await _authStoring.getRefreshToken();
         // TODO implement refresh call
         // await _authStoring.saveRefreshToken(refreshToken: result.refreshToken, accessToken: result.accessToken);
        throw UnimplementedError('No implementatino for the refresh in the refresh repositories');
      } catch (e) {
        _failure = true;
        if (logoutCallback != null) {
          await _authStoring.clear();
          logoutCallback();
        }
        rethrow;
      }
    });
  }
}
