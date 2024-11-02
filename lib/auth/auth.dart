import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _isLoggedInKey = 'isLoggedIn';
  static const _registeredEmailKey = 'registeredEmail';
  static const _registeredPasswordKey = 'registeredPassword';

  /// Menyimpan data email dan password di SharedPreferences saat registrasi
  Future<void> register(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_registeredEmailKey, email);
    await prefs.setString(_registeredPasswordKey, password);
  }

  /// Fungsi untuk login dan menyimpan status login jika berhasil
  Future<bool> login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? registeredEmail = prefs.getString(_registeredEmailKey);
    String? registeredPassword = prefs.getString(_registeredPasswordKey);

    if (email == registeredEmail && password == registeredPassword) {
      await prefs.setBool(_isLoggedInKey, true);
      return true;
    }
    return false;
  }

  /// Mengecek status login dari SharedPreferences
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  /// Fungsi untuk logout dan menghapus status login dari SharedPreferences
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
  }
}
