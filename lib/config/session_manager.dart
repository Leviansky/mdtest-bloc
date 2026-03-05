// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManager {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> setSession(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<void> setString(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<void> setListString(String key, List<String> value) async {
    await storage.write(key: key, value: value.join(","));
  }

  Future<String?> getSession(String key) async {
    String? value = await storage.read(key: key);
    return value;
  }

  Future<List<String?>> getListString(String key) async {
    String? value = await storage.read(key: key);
    if (value == null) return [];
    return value.split(",");
  }

  static Future<String?> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? value = await secureStorage.read(key: "token");
    return value;
  }

  Future<void> clearLoginSession() async {
    await storage.delete(key: "token");
    await storage.delete(key: "refreshToken");
    await storage.delete(key: "userEmail");
    await storage.delete(key: "userProfile");
  }

  Future<void> clearAll() async {
    await storage.deleteAll();
  }
}
