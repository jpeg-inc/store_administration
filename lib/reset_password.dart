import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:recase/recase.dart';

import 'Functions/authentication.dart';
import 'dialogs/email_not_found_dialog.dart';
import 'successful_reset.dart';
import 'themes/helpers/theme_colors.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<ResetPasswordScreen> {
  TextEditingController _email = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: blackColor,
          title: Text('Setting'),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 200.0, right: 30.0, left: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Reset Password',
                    style: TextStyle(
                        fontFamily: 'Realistica',
                        fontSize: 30.0,
                        color: blackColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      controller: _email,
                      validator: (value) {
                        if (value.isEmpty) {
                          return ReCase(
                            'please enter your email address',
                          ).sentenceCase;
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            )),
                            textColor: Colors.white,
                            color: Colors.black,
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                  "Reset",
                                ),
                                Icon(Icons.arrow_forward)
                              ],
                            ),
                            onPressed: () async {
                              if (_email.text != '' || _email != null) {
                                bool isSuccess = await Authentication()
                                    .resetPassword(
                                        email: _email.text
                                          ..toLowerCase().trim());
                                if (isSuccess == true) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SuccessResetScreen()),
                                      (Route<dynamic> route) => false);
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return EmailNotFoundDialog();
                                      });
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
