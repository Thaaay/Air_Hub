import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_page.dart';
import 'firebase_options.dart'; // gerado automaticamente pelo Firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AirHub Social',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),

      // 🌍 Suporte a múltiplos idiomas
      supportedLocales: const [
        Locale('en', ''), // Inglês
        Locale('pt', ''), // Português
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('en', ''), // idioma padrão
    );
  }
}
