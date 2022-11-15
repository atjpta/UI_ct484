import 'package:flutter/foundation.dart';

import '../models/auth_token.dart';

abstract class ApiService {
  String? _token;
  String? _userId;

  ApiService([AuthToken? authToken])
      : _token = authToken?.username,
        _userId = authToken?.userId;

  set authToken(AuthToken? authToken) {
    _token = authToken?.username;
    _userId = authToken?.userId;
  }

  @protected
  String? get token => _token;

  @protected
  String? get userId => _userId;
}
