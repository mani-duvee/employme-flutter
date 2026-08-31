import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  TokenStorage._();

  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  /// Save access token and refresh token directly
  static Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
    }
  }

  /// Extract and save tokens automatically from API login response payload
  /// Expects response["data"]["accessToken"] and response["data"]["refreshToken"]
  static Future<void> saveTokensFromResponse(dynamic response) async {
    if (response is Map && response['data'] is Map) {
      final data = response['data'] as Map;
      final String? accessToken =
          data['accessToken']?.toString() ?? data['authtoken']?.toString();
      final String? refreshToken = data['refreshToken']?.toString();

      if (accessToken != null && accessToken.isNotEmpty) {
        await saveTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
      }
    }
  }

  /// Read stored access token
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  /// Read stored refresh token
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  /// Delete tokens (e.g. on logout)
  static Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }
}
