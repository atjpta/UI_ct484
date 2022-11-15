class AuthToken {
  final String _token;
  final String _userId;
  final String _username;

  AuthToken({
    token,
    userId,
    username,
  })  : _token = token,
        _userId = userId,
        _username = username;

  String get userId {
    return _userId;
  }

  String get username {
    return _username;
  }

  String get token {
    return _token;
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': _token,
      'id': _userId,
      'username': _username,
    };
  }

  static AuthToken fromJson(Map<String, dynamic> json) {
    return AuthToken(
      token: json['accessToken'],
      userId: json['id'],
      username: json['username'],
    );
  }
}
