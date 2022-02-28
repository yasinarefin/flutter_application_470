import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageServices {
  static final secureStorage = FlutterSecureStorage();
  static const tokenKey = 'token';
  static Future setToken({required String token}) async {
    await secureStorage.write(key: tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    String? token = await secureStorage.read(key: tokenKey);
    return token;
  }

  static Future deleteToken() async {
    await secureStorage.delete(key: tokenKey);
  }
}
