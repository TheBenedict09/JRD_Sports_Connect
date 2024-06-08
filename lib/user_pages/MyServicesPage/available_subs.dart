import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jrd_s_c/colors.dart';

class AvailableSubscriptionPage extends StatefulWidget {
  const AvailableSubscriptionPage({super.key});

  @override
  State<AvailableSubscriptionPage> createState() =>
      _AvailableSubscriptionPageState();
}

class _AvailableSubscriptionPageState extends State<AvailableSubscriptionPage> {
  double x = 0.9;

  TimeOfDay _timeFromString(String timeString) {
    final format = RegExp(r'(\d+):(\d+)\s(\w{2})');
    final match = format.firstMatch(timeString);
    if (match != null) {
      final hour = int.parse(match.group(1)!);
      final minute = int.parse(match.group(2)!);
      final period = match.group(3)!;

      final adjustedHour = period == 'PM' && hour != 12
          ? hour + 12
          : period == 'AM' && hour == 12
              ? 0
              : hour;

      return TimeOfDay(hour: adjustedHour, minute: minute);
    } else {
      throw const FormatException('Invalid time format');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Services").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          var services = snapshot.data?.docs ?? [];
          return Stack(
            children: [
              Stack(
                children: [
                  Positioned(
                    top: -MediaQuery.of(context).size.height * x / 1.8,
                    left: -MediaQuery.of(context).size.width * x / 2.2,
                    child: Container(
                      height: MediaQuery.of(context).size.height * x * 1.3,
                      width: MediaQuery.of(context).size.width * x * 1.3,
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
                      height: MediaQuery.of(context).size.height * x * 1.0,
                      width: MediaQuery.of(context).size.width * x * 1.0,
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
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Available Subscriptions:",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 50,
                            ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.14 * 5,
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var service = services[index];
                          TimeOfDay startTime =
                              _timeFromString(service['startTime']);
                          TimeOfDay endTime =
                              _timeFromString(service['endTime']);
                          return NewSubElement(
                            title: service['title'],
                            startDay: service['startDay'],
                            endDay: service['endDay'],
                            startTime: startTime,
                            endTime: endTime,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.only(left: 38, right: 38),
                            child: Divider(),
                          );
                        },
                        itemCount: services.length,
                      ),
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

class NewSubElement extends StatefulWidget {
  const NewSubElement({
    super.key,
    required this.title,
    required this.startDay,
    required this.endDay,
    required this.startTime,
    required this.endTime,
  });

  final String title;
  final String startDay;
  final String endDay;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  @override
  // ignore: library_private_types_in_public_api
  _NewSubElementState createState() => _NewSubElementState();
}

class _NewSubElementState extends State<NewSubElement> {
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? widget.startTime : widget.endTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null && picked.hour >= 5 && picked.hour <= 21) {
      setState(() {
        if (isStartTime) {
          selectedStartTime = picked;
        } else {
          selectedEndTime = picked;
        }
      });
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Invalid Time",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Please select a time between 5:00 AM and 9:00 PM.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 25,
                ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        decoration: BoxDecoration(
          color: c10.withOpacity(0.8),
          borderRadius: BorderRadius.circular(22),
        ),
        child: ListTile(
          onTap: () {
            AfterTap(context);
          },
          title: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),
          subtitle: Text("${widget.startDay} - ${widget.endDay}"),
          trailing: Text(
            "${widget.startTime.format(context)} - ${widget.endTime.format(context)}",
            style: TextStyle(
              color: c1,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> AfterTap(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Select Time Range:",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 20,
                        ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    "Start Time:",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 18,
                        ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await _selectTime(context, true);
                      setState(() {});
                    },
                    child: Text(
                      selectedStartTime == null
                          ? "Select start time"
                          : "Start time: ${selectedStartTime!.format(context)}",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 18, fontWeight: FontWeight.bold, color: c1),
                    ),
                  ),
                  Text(
                    "End Time:",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 18,
                        ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await _selectTime(context, false);
                      setState(() {});
                    },
                    child: Text(
                      selectedEndTime == null
                          ? "Select end time"
                          : "End time: ${selectedEndTime!.format(context)}",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 18, fontWeight: FontWeight.bold, color: c1),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    if (selectedStartTime != null && selectedEndTime != null) {
                      // print(
                      //   "Selected Start Time: ${selectedStartTime!.format(context)}",
                      // );
                      // print(
                      //   "Selected End Time: ${selectedEndTime!.format(context)}",
                      // );

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "New Subscription Added",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: 25,
                                  ),
                            ),
                          );
                        },
                      );

                      Future.delayed(
                        const Duration(seconds: 2),
                        () {
                          Navigator.of(context)
                              .pop(); // Close the confirmation dialog
                          Navigator.of(context)
                              .pop(); // Close the original dialog
                        },
                      );
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
