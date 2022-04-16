/*
Here, all the storage services are kept. 
*/

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageServices {
  static final secureStorage = FlutterSecureStorage();
  static const tokenKey = 'token';

  // this method stores the auth token into storage to achieve persistent login
  static Future setToken({required String token}) async {
    await secureStorage.write(key: tokenKey, value: token);
  }

  // this method loads the auth token into storage to achieve persistent login
  static Future<String?> getToken() async {
    String? token = await secureStorage.read(key: tokenKey);
    return token;
  }

  // this method deletes the token when the user logs out
  static Future deleteToken() async {
    await secureStorage.delete(key: tokenKey);
  }
}
