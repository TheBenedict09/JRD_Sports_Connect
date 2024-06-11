// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jrd_s_c/admin_pages/EventsPage/event_page.dart';
import 'package:jrd_s_c/admin_pages/utilities/admin_bottom_navbar.dart';
import 'package:jrd_s_c/common_utilities/colors.dart';
import 'package:jrd_s_c/common_utilities/firebase_options.dart';
import 'package:jrd_s_c/user_pages/BasicCredentialsPage/registration_page.dart';
import 'package:jrd_s_c/user_pages/HomePage/home_page.dart';
import 'package:jrd_s_c/user_pages/MyServicesPage/my_services_page.dart';
import 'package:jrd_s_c/user_pages/ProfilePage/profile_page.dart';
import 'package:jrd_s_c/user_pages/utilities/bottom_navbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  double x = 0.9;
  bool check = false;

  Future<void> _login() async {
    try {
      var sun = A.part1 + B.part2 + C.part3 + D.part4;
      var sp = E.p1 + F.p2;

      if (_email.text == sun && _password.text == sp) {
        FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email.text, password: _password.text);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const AdminBottomNavBarPage();
            },
          ),
        );
      } else {
        setState(() {
          check = true;
        });
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text,
          password: _password.text,
        );
        setState(() {
          check = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const BottomNavBarPage();
            },
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        default:
          message = 'An unknown error occurred.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        check = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An unknown error occurred.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c2,
      body: Stack(
        children: [
          Stack(
            children: [
              Positioned(
                top: -MediaQuery.of(context).size.height * x / 2.2,
                left: MediaQuery.of(context).size.width * (1 - x) / 1.5,
                child: Container(
                  height: MediaQuery.of(context).size.height * x * 1.1,
                  width: MediaQuery.of(context).size.width * x * 1.1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: c1,
                  ),
                ),
              ),
              Positioned(
                bottom: -MediaQuery.of(context).size.height * x / 2.2,
                right: -MediaQuery.of(context).size.width * x / 2.2,
                child: Container(
                  height: MediaQuery.of(context).size.height * x,
                  width: MediaQuery.of(context).size.width * x,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: c4,
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.17,
                ),
                Center(
                  child: Text(
                    "Login",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: c3,
                          fontSize: MediaQuery.of(context).size.width * 0.12,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.13,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28, right: 28),
                  child: Container(
                    decoration: BoxDecoration(
                        color: c3.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(22)),
                    child: TextField(
                      controller: _email,
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        hintStyle: Theme.of(context).textTheme.bodyLarge
                          ?..copyWith(color: c3),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: c3, width: 3),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(color: c3, width: 2.3),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28, right: 28),
                  child: Container(
                    decoration: BoxDecoration(
                        color: c3.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(22)),
                    child: TextField(
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        hintStyle: Theme.of(context).textTheme.bodyLarge
                          ?..copyWith(color: Colors.white),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: c3, width: 1.3),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(color: c3, width: 2.3),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28, right: 28),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: FloatingActionButton(
                      backgroundColor: c5,
                      onPressed: _login,
                      child: check
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              "Login",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.06,
                                  ),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.24,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("New User?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const RegistrationPage();
                                },
                              ),
                            );
                          },
                          child: const Text("Register"))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
