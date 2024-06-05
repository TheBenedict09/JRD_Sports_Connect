import 'package:flutter/material.dart';
import 'package:jrd_s_c/pages/get_started_page.dart';
import 'package:jrd_s_c/pages/login_page.dart';
import 'package:jrd_s_c/pages/registration_page.dart';
import 'package:jrd_s_c/utilities/bottom_navbar.dart';
import 'package:jrd_s_c/utilities/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: c5),
          useMaterial3: true,
          textTheme:
              const TextTheme(bodyLarge: TextStyle(fontFamily: 'MyFont'))),
      home: const BottomNavBarPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
