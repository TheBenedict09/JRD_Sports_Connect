import 'package:flutter/material.dart';
import 'package:jrd_s_c/pages/HomePage/home_page_updates.dart';
import 'package:jrd_s_c/utilities/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String greetingMessage = "";
  double x = 1.2;
  @override
  void initState() {
    super.initState();
    _setGreetingMessage();
  }

  void _setGreetingMessage() {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      greetingMessage = "Good\nMorning,";
    } else if (hour < 17) {
      greetingMessage = "Good\nAfternoon,";
    } else {
      greetingMessage = "Good\nEvening,";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Positioned(
                top: -MediaQuery.of(context).size.height * x / 2.2,
                left: -MediaQuery.of(context).size.width * x / 2.2,
                child: Container(
                  height: MediaQuery.of(context).size.height * x * 1.1,
                  width: MediaQuery.of(context).size.width * x * 1.1,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        greetingMessage,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 50,
                            color: c3),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Updates:",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w900, fontSize: 25, color: c3),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.14 * 5,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return const HomePageElement();
                    },
                    separatorBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.only(left: 38, right: 38),
                        child: Divider(),
                      );
                    },
                    itemCount: 5,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
