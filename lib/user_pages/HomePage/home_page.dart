import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jrd_s_c/user_pages/HomePage/home_page_updates.dart';
import 'package:jrd_s_c/common_utilities/colors.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class C {
  static const String part3 = "mail.";
}

class _HomePageState extends State<HomePage> {
  final services = FirebaseFirestore.instance.collection("Events");
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

  TimeOfDay _timeFromString(String timeString) {
  final format = RegExp(r'(\d{1,2}):(\d{2})');
  final match = format.firstMatch(timeString);
  if (match != null) {
    final hour = int.parse(match.group(1)!);
    final minute = int.parse(match.group(2)!);

    return TimeOfDay(hour: hour, minute: minute);
  } else {
    throw const FormatException('Invalid time format');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c1.withOpacity(0.2),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Events").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final events = snapshot.data?.docs ?? [];
          return Stack(
            children: [
              BigGreyCircle(x: x),
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.121,
                                    color: c5),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Updates:",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: MediaQuery.of(context).size.width * 0.065,
                            color: c3),
                      ),
                    ),
                    events.isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                ),
                                Lottie.asset('assets/animations/multi.json',
                                    height: 270),
                                Text(
                                  'No Updates',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 25,
                                          color: c4),
                                )
                              ],
                            ),
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var event = events[index];
                              TimeOfDay startTime =
                                  _timeFromString(event['startTime']);
                              TimeOfDay endTime =
                                  _timeFromString(event['endTime']);
                              DateTime startDate =
                                  DateTime.parse(event['startDate']);
                              return Column(
                                children: [
                                  HomePageElement(
                                    title: event['title'],
                                    desc: event['Desc'],
                                    date:
                                        '${startDate.toLocal()}'.split(' ')[0],
                                    startTime: startTime,
                                    endTime: endTime,
                                  ),
                                  if (index < events.length - 1)
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 38),
                                      child: Divider(),
                                    ),
                                ],
                              );
                            },
                            itemCount: events.length,
                          ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class D {
  static const String part4 = "com";
}
