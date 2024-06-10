import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jrd_s_c/common_utilities/colors.dart';
import 'package:jrd_s_c/user_pages/BasicCredentialsPage/get_started_page.dart';
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
      home: const AuthHandler(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthHandler extends StatefulWidget {
  const AuthHandler({Key? key}) : super(key: key);

  @override
  State<AuthHandler> createState() => _AuthHandlerState();
}

class _AuthHandlerState extends State<AuthHandler> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    if (user != null && user?.uid != "eMiTSDMNKYQGRDqD8diP7WB1Glp2") {
      return const BottomNavBarPage();
    } else {
      return const GetStartedPage();
    }
  }
}
