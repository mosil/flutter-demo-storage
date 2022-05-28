import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/constant/app_key.dart';

class AuthProvider extends ChangeNotifier {
  final SharedPreferences prefs;
  String email = '';

  AuthProvider({
    required this.prefs,
  });

  Future<bool> isLogin() async {
    email = prefs.getString(AppKey.kEmail) ?? '';
    return email.isNotEmpty;
  }

  Future<void> login(String email) async {
    this.email = email;
    prefs.setString(AppKey.kEmail, email);
  }

  Future<bool> logout() async {
    email = '';
    prefs.setString(AppKey.kEmail, '');
    return true;
  }
}
