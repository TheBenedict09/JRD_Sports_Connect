import 'package:flutter/material.dart';
import 'package:jrd_s_c/colors.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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
                    color: c4,
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
                    color: c5,
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.17,
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
                height: MediaQuery.of(context).size.height * 0.13,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28, right: 28),
                child: Container(
                  decoration: BoxDecoration(
                      color: c3.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(22)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Username",
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
                    onPressed: () {},
                    child: Text(
                      "Register",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.06,
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
                    const Text("Already a User?"),
                    TextButton(onPressed: () {}, child: const Text("Login"))
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
