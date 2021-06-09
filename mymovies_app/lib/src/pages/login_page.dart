import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:mymovies_app/src/model/login_model.dart';
import 'package:mymovies_app/src/services/user_service.dart';
import 'package:animate_do/animate_do.dart';

import 'package:mymovies_app/src/theme/theme.dart';
import 'package:mymovies_app/src/widgets/alert.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserService userService = new UserService();

  // Model that will be sent to the API
  LoginRequestModel requestModel = new LoginRequestModel();
  
  String email = '';
  String password = '';
  
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _createBackground(_size),
            _logInForm(_size, context)            
          ]
        )
      )
    );
  }

  Widget _createBackground(Size size) {
    final purpleBackgroud = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0)
          ]
        )
      )
    );
    
    final circle = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      )
    );

    return Stack(
      children: [
        purpleBackgroud,
        Positioned(top: 90.0, left: 30.0, child: circle),
        Positioned(top: -40.0, right: -30.0, child: circle),
        Positioned(bottom: -50.0, right: -10.0, child: circle),
        Positioned(bottom: 120.0, right: 20.0, child: circle),
        Positioned(bottom: -50.0, left: -20.0, child: circle),

        Container(
          padding: EdgeInsets.only(top: 70.0),
          child: Column(
            children: [
              Hero(
                tag: 'logo',
                child: Image(height: size.height * 0.12, image: AssetImage('assets/img/logo_transparent.png'))
              ),
              SizedBox(height: 10.0, width: double.infinity,),
              BounceInDown(child: Text('My Movies', style: TextStyle(color: Colors.white, fontSize: 38.0, fontWeight: FontWeight.bold)))
            ]
          )
        )
      ]
    );
  }

  Widget _logInForm(Size size, BuildContext context) {
    return SingleChildScrollView(
      child: FadeIn(
        duration: Duration(milliseconds: 1000),
        child: Column(
          children: [
            SafeArea(child: Container(height: size.height * 0.27)),

            Container(
              width: size.width * 0.75,
              margin: EdgeInsets.symmetric(vertical: 30.0),
              padding: EdgeInsets.symmetric(vertical: 50.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0
                  )
                ]
              ),
       
              child: Column(
                children: [
                  Text('Log In', style: Theme.of(context).textTheme.headline5),
                  SizedBox(height: 50.0),
                  
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        icon: Icon(Icons.alternate_email, color: myTheme.primaryColor),
                        hintText: 'example@domain.com',
                        labelText: 'E-mail',
                      ),
                      onChanged: (value) {
                        setState(() => email = value);
                      }
                    )
                  ),
                    
                  SizedBox(height: 50.0),
                    
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock_outline, color: myTheme.primaryColor),
                        hintText: '**********',
                        labelText: 'Password',
                      ),
                      onChanged: (value) {
                        setState(() => password = value);
                      }             
                    )
                  ),
                  
                  SizedBox(height: 50.0),
                  
                  _sendButton()
                ],
              )
            )
          ]
        )
      )
    );
  }

  Widget _sendButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 60.0),
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: myTheme.primaryColor
      ),
      child: TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.login_outlined, color: Colors.white),
            SizedBox(width: 15.0),
            Text('Enter', style: TextStyle(color: Colors.white, fontSize: 16.0))
          ],
        ),
        onPressed: () => _logIn()
      )
    );
  }

  void _logIn() async {
    // Create regEx
    final mailCheck = new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    
    // Check if empty    
    if (email.length == 0 || password.length == 0) {
      showAlert(context, 'Blank spaces are not allowed');
    
    // Check for email's format
    } else if (!mailCheck.hasMatch(email)) {
      showAlert(context, 'Mail format is incorrect');
    
    } else {
      // Set data into the request model
      requestModel.email    = email;
      requestModel.password = password;

      // Call the service
      userService.logIn(requestModel).then((value) {
        if (value.token!.isNotEmpty) {
          // If the response brings a token it's saved and app continues to next page
          Navigator.pushReplacementNamed(context, 'home');
        } else {
          showAlert(context, 'Email or password are incorrect\n${value.error}');
        }
      });
    }
  }
}