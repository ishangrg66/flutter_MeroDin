import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final SharedPreferences prefs;
  AuthService(this.prefs);

  String? get token => prefs.getString('token');

  Future<void> saveToken(String token) async {
    await prefs.setString('token', token);
  }

  Future<void> saveUserGroup(String group) async =>
      await prefs.setString('user_group', group);

  Future<void> clearToken() async {
    await prefs.remove('token');
    await prefs.remove('user_group');
    await prefs.remove('user_id');
  }

  Future<void> saveUserId(String userId) async {
    await prefs.setString('user_id', userId);
  }

  bool get hasToken => token != null && token!.isNotEmpty;
  String? get userGroup => prefs.getString('user_group');
  String? get userId => prefs.getString('user_id');
}
