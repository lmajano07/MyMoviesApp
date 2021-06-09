import 'package:flutter/material.dart';

import 'package:mymovies_app/src/shared_preferences/shared_preferences.dart';
import 'package:mymovies_app/src/theme/theme.dart';

import 'package:mymovies_app/src/pages/login_page.dart';
import 'package:mymovies_app/src/pages/home_page.dart';
 
void main() async {
  // Initialize user preferences from startup
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = new UserPreferences();
  await preferences.initPrefs();

  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _preferences = new UserPreferences();

    return MaterialApp(
      title: 'My Movies',
      
      // Using routes to navigate through pages
      initialRoute: _preferences.token != '' ? 'home' : 'login', // ** PARA NO VOLVER AL LOGIN **
      routes: {
        'login' : (BuildContext context) => LoginPage(),
        'home'  : (BuildContext context) => HomePage()
      },
      
      theme: myTheme
    );
  }
}