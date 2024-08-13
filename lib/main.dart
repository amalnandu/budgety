import 'package:budget/creditpage.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';


import 'debitpage.dart';

void main() async {

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
theme: ThemeData(
  // useMaterial3: true,
  brightness: Brightness.dark,

  ),
debugShowCheckedModeBanner: false,
      routes: {
        'home': (context) => const Home(),
        'creditpage': (context) => const Creditpage(),
        'debitpage': (context) => const Debitpage(),
      },
      home: const Home(),
    );
  }
}
