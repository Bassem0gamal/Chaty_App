import 'package:chaty_app/components/rounded_button.dart';
import 'package:chaty_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chaty_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  static String id = 'registration_screen';

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset('images/logo.png', height: 100.0),
              const SizedBox(
                height: 48.0,
              ),
              Form(
                autovalidateMode: AutovalidateMode.always,
                child: TextFormField(
                    validator: validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your email')),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Form(
                autovalidateMode: AutovalidateMode.always,
                child: TextFormField(
                  validator: validatePassword,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password'),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.blue,
                text: 'Register',
                onPressed: () async {
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      setState(() {
                        showSpinner = true;
                      });

                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Enter user and password')));
                    //print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
