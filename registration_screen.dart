import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hydroponics/screens/login_Screen.dart';

import '../constants/constants.dart';
import '../widgets/show_dialog_widget.dart';
import 'home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "registration_screen";
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  static const String _title = 'Hydroponic App';

  late String email;
  late String password;
  late String username;

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewPortConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: viewPortConstraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Smart Farm',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      ),
                    ),
                    Text(
                      'Register Account',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        username = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your username'),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your email'),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your password'),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Material(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30.0),
                        elevation: 5.0,
                        child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              final newUser =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: email, password: password);
                              if (newUser != null) {
                                // Navigator.pushNamed(context, ChatScreen.id);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Home_Screen(),
                                ));
                              } else {
                                ShowDialog().showMyDialog(
                                    'Ooops! Error 102',
                                    'A problem occurred while trying to create your account',
                                    'Ok',
                                    context);
                              }
                            } catch (e) {
                              print(e);
                              ShowDialog().showMyDialog(
                                  'Ooops! Error 101',
                                  'A problem occurred while trying to create your account',
                                  'Ok',
                                  context);
                            } finally {
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          },
                          minWidth: 200.0,
                          height: 42.0,
                          child: Text(
                            'Create Account',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: RichText(
                          text: TextSpan(
                            style:
                                TextStyle(color: Colors.grey, fontSize: 20.0),
                            children: <TextSpan>[
                              TextSpan(text: 'Already have an account '),
                              TextSpan(
                                  text: 'Sign in',
                                  style: TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              LoginScreen.id,
                                              (Route<dynamic> route) => false);
                                    })
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
