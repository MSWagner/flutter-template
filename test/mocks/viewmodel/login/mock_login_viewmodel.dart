import 'package:flutter/cupertino.dart';
import 'package:flutter_template/features/login/viewmodels/login_viewmodel.dart';
import 'package:mockito/mockito.dart';

class MockLoginViewModel extends Mock with ChangeNotifier implements LoginViewModel {}
