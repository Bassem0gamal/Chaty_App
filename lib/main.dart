import 'package:flutter/material.dart';
import 'package:chaty_app/screens/login_screen.dart';
import 'package:chaty_app/screens/welcome_screen.dart';
import 'package:chaty_app/screens/registration_screen.dart';
import 'package:chaty_app/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const ChatyApp());
}

class ChatyApp extends StatelessWidget {
  const ChatyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
      },
    );
  }
}
