import 'package:flutter/material.dart';

import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

Map<int, Color> color = {
  50: const Color(0XFF063340),
  100: const Color(0XFF063340),
  200: const Color(0XFF063340),
  300: const Color(0XFF063340),
  500: const Color(0XFF063340),
  600: const Color(0XFF063340),
  700: const Color(0XFF063340),
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0XFF063340, color);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      home: const Home(),
    );
  }
}