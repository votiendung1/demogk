import 'package:demo_gk/firebase_options.dart';
import 'package:demo_gk/pages/home_page.dart';
import 'package:demo_gk/services/auth/auth_gate.dart';
import 'package:demo_gk/services/auth/login_or_register.dart';
import 'package:demo_gk/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        // chủ đề
        ChangeNotifierProvider(create: (context) => ThemeProvider()),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      // initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginOrRegister(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}