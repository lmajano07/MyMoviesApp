import 'package:flutter/material.dart';

import 'package:mymovies_app/src/shared_preferences/shared_preferences.dart';
import 'package:mymovies_app/src/theme/theme.dart';

import 'package:mymovies_app/src/pages/home_page.dart';
 
void main() async {
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Movies',
      initialRoute: 'home',
      // Using routes to navigate through pages
      routes: {
        'home'  : (BuildContext context) => HomePage()
      },
      theme: myTheme,
    );
  }
}