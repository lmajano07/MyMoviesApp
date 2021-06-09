import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mymovies_app/src/shared_preferences/shared_preferences.dart';
import 'package:mymovies_app/src/theme/theme.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

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
    // Set allowed orientations
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    final _preferences = new UserPreferences();

    return MaterialApp(
      // Uncomment the line below to take away the debug label on the top right corner
      // debugShowCheckedModeBanner: false,
      title: 'My Movies',
      home: AnimatedSplashScreen(
        duration: 2000,
        splashTransition: SplashTransition.fadeTransition, 
        backgroundColor: myTheme.primaryColor,
        splash: Hero(
          tag: 'logo',
          child: Image(image: AssetImage('assets/img/logo_transparent.png'))
        ),
        splashIconSize: 250,
        nextScreen: _preferences.token != '' ? HomePage() : LoginPage() // Cheks if there's a token
      ),
      
      // Using routes to navigate through pages
      routes: {
        'login' : (BuildContext context) => LoginPage(),
        'home'  : (BuildContext context) => HomePage()
      },
      
      // Set a custom theme
      theme: myTheme
    );
  }
}