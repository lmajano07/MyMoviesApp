import 'package:shared_preferences/shared_preferences.dart';

// Shared preferences class - This will be used to store information on the device
class UserPreferences {
  static final UserPreferences? _instance = new UserPreferences._internal();

  factory UserPreferences() {
    return _instance!;
  }

  UserPreferences._internal();
  SharedPreferences? _preferences;

  initPrefs() async {
    this._preferences = await SharedPreferences.getInstance();
  }

  // Token getter - setter
  get token {
    return _preferences!.getString('token') ?? '';
  }
  set token(value) {
    _preferences!.setString('token', value);
  }
}