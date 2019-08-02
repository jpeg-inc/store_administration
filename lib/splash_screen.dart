import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:store_administration/log_in_screen.dart';
import 'themes/helpers/buttons.dart';
import 'themes/helpers/fonts.dart';
import 'themes/helpers/splash_screen_plugin.dart';
import 'themes/helpers/theme_colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenStyles(
      seconds: 3,
      navigateAfterSeconds: LoginScreen(),
      imageBackground: AssetImage('assets/images/splash_screen.jpg'),
      title: Column(
        children: <Widget>[
          Text(
            'Mickey & Honey',
            style: TextStyle(
              fontFamily: 'Realistica',
              color: whiteColor,
              fontSize: 40,
            ),
          ),
          Text(
            'Admin',
            style: TextStyle(
              fontFamily: 'Realistica',
              color: whiteColor,
              fontSize: 40,
            ),
          ),
        ],
      ),
      loaderColor: Colors.transparent,
    );
  }
}

class DecisionRoute extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('store_stockroom'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(64.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 50.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: AutoSizeText(
                          'No Internet Connection!',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Avenir',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                        child: AutoSizeText(
                          'Please check your internet connection and try again.',
                          style: font15Grey,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  CustomButton(
                    textButton: 'Exit',
                    colorButton: removeColor,
                    onPressed: () {
                      exit(0);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}