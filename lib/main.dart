import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jrd_s_c/admin_pages/utilities/admin_bottom_navbar.dart';
import 'package:jrd_s_c/common_utilities/colors.dart';
import 'package:jrd_s_c/user_pages/BasicCredentialsPage/registration_page.dart';
import 'package:jrd_s_c/user_pages/MyServicesPage/available_subs.dart';
import 'package:jrd_s_c/user_pages/utilities/bottom_navbar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: const RegistrationPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
