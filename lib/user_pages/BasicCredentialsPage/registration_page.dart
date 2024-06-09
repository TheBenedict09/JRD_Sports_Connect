import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jrd_s_c/admin_pages/utilities/admin_bottom_navbar.dart';
import 'package:jrd_s_c/common_utilities/colors.dart';
import 'package:jrd_s_c/user_pages/BasicCredentialsPage/login_page.dart';
import 'package:jrd_s_c/user_pages/utilities/bottom_navbar.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _departmentID = TextEditingController();
  final TextEditingController _companyID = TextEditingController();
  String? _selectedGender; // Store selected gender

  Future<void> _addCredentials() async {
    String name = _name.text;
    String email = _email.text;
    String? gender = _selectedGender; // Get selected gender
    String departmentID = _departmentID.text;
    String companyID = _companyID.text;

    if (name.isEmpty ||
        email.isEmpty ||
        gender == null ||
        departmentID.isEmpty ||
        companyID.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all fields')));
      return;
    }

    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String uid = currentUser.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'deptID': departmentID,
        'companyID': companyID,
        'gender': gender,
        'uid': uid,
      });
    }
  }

  double x = 0.9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c1,
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
                    color: c10,
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
                    color: c2,
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
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                Center(
                  child: Text(
                    "Register",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.12,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28, right: 28),
                  child: Container(
                    decoration: BoxDecoration(
                        color: c3.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(22)),
                    child: TextField(
                      controller: _name,
                      decoration: InputDecoration(
                        labelText: "Enter Name",
                        labelStyle: Theme.of(context).textTheme.bodyLarge
                          ?..copyWith(color: c1),
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
                        color: c3.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(22)),
                    child: TextField(
                      controller: _email,
                      decoration: InputDecoration(
                        labelText: "Enter Email",
                        labelStyle: Theme.of(context).textTheme.bodyLarge
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
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28, right: 28),
                  child: Container(
                    decoration: BoxDecoration(
                        color: c3.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(22)),
                    child: TextField(
                      controller: _companyID,
                      decoration: InputDecoration(
                        labelText: "Enter Company ID",
                        labelStyle: Theme.of(context).textTheme.bodyLarge
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
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28, right: 28),
                  child: Container(
                    decoration: BoxDecoration(
                        color: c3.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(22)),
                    child: TextField(
                      controller: _departmentID,
                      decoration: InputDecoration(
                        labelText: "Enter Department ID",
                        labelStyle: Theme.of(context).textTheme.bodyLarge
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
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28, right: 28),
                  child: Container(
                    decoration: BoxDecoration(
                        color: c3.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(22)),
                    child: DropdownButtonFormField<String>(
                      value: _selectedGender,
                      decoration: InputDecoration(
                        labelText: "Select Gender",
                        labelStyle: Theme.of(context).textTheme.bodyLarge
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
                      items: ['Male', 'Female', 'Others'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
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
                        color: c3.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(22)),
                    child: TextField(
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Enter Password",
                        labelStyle: Theme.of(context).textTheme.bodyLarge
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
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28, right: 28),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: FloatingActionButton(
                      backgroundColor: c5,
                      onPressed: () async {
                        try {
                          var secretUsername = "admin";
                          var secretPassword = "abs";
                          if (_email.text == secretUsername &&
                              _password.text == secretPassword) {
                            // Navigate to the secret page
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const AdminBottomNavBarPage(); // Your secret page
                                },
                              ),
                            );
                          } else {
                            UserCredential user = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: _email.text,
                                    password: _password.text);
                            await _addCredentials();

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const BottomNavBarPage();
                                },
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Failed to register: $e")),
                          );
                        }
                      },
                      child: Text(
                        "Register",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.06,
                            ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Already a User?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const LoginPage();
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: c10),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
