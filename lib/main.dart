import 'package:flutter/material.dart';
import 'package:jrd_s_c/user_pages/BasicCredentialsPage/get_started_page.dart';
import 'package:jrd_s_c/user_pages/BasicCredentialsPage/login_page.dart';
import 'package:jrd_s_c/user_pages/BasicCredentialsPage/registration_page.dart';
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
