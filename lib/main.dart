import 'package:flutter/material.dart';
import 'misc/theme.dart';
import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {'/': (context) => const PrimaryPage()},
      title: 'Flutter Demo',
      theme: appTheme(),
    );
  }
}
