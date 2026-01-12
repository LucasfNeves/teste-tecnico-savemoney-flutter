import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const String _tokenKey = 'auth_token';
  static String? _cachedToken;
  static final _storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
    _cachedToken = token;
  }

  static String? getToken() {
    return _cachedToken;
  }

  static Future<void> loadToken() async {
    _cachedToken = await _storage.read(key: _tokenKey);
  }

  static Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
    _cachedToken = null;
  }

  static bool get hasToken => _cachedToken != null;
}
