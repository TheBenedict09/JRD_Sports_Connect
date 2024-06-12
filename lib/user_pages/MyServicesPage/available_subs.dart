// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jrd_s_c/common_utilities/colors.dart';
import 'package:lottie/lottie.dart';

class AvailableSubscriptionPage extends StatefulWidget {
  const AvailableSubscriptionPage({Key? key});

  @override
  State<AvailableSubscriptionPage> createState() =>
      _AvailableSubscriptionPageState();
}

class _AvailableSubscriptionPageState extends State<AvailableSubscriptionPage> {
  double x = 0.9;
  List<String> subscribedServices = [];

  @override
  void initState() {
    super.initState();
    _fetchSubscribedServices();
  }

  Future<void> _fetchSubscribedServices() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('services')
        .get();
    setState(() {
      subscribedServices = snapshot.docs.map((doc) => doc.id).toList();
    });
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
          var availableServices = services
              .where(
                  (service) => !subscribedServices.contains(service['title']))
              .toList();
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
                        color: Colors.lightBlue.shade700,
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
                        color: c1,
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
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.121,
                            ),
                      ),
                    ),
                    availableServices.isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.13,
                                ),
                                Lottie.asset('assets/animations/archer.json',
                                    height: 200, width: 200),
                                Text(
                                  'No Available Subscription',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.w900,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.065,
                                          color: c4),
                                )
                              ],
                            ),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height *
                                0.17 *
                                availableServices.length,
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var service = availableServices[index];
                                TimeOfDay startTime =
                                    _timeFromString(service['startTime']);
                                TimeOfDay endTime =
                                    _timeFromString(service['endTime']);
                                return NewSubElement(
                                  title: service['title'],
                                  startTime: startTime,
                                  endTime: endTime,
                                  startDay: service['startDay'],
                                  endDay: service['endDay'],
                                  id: service.id,
                                  onSubscribe: () {
                                    _fetchSubscribedServices();
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Padding(
                                  padding: EdgeInsets.only(left: 38, right: 38),
                                  child: Divider(),
                                );
                              },
                              itemCount: availableServices.length,
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
    Key? key,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.startDay,
    required this.endDay,
    required this.id,
    required this.onSubscribe,
  });

  final String title;
  final String startDay;
  final String endDay;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String id;
  final VoidCallback onSubscribe;

  @override
  _NewSubElementState createState() => _NewSubElementState();
}

class _NewSubElementState extends State<NewSubElement> {
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          selectedStartDate = picked;
        } else {
          selectedEndDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lime.shade500,
          borderRadius: BorderRadius.circular(22),
        ),
        child: ListTile(
          onTap: () {
            _afterTap(context);
          },
          title: Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.065,
                ),
          ),
          subtitle: Text(
            "${widget.startDay} - ${widget.endDay}",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: c5.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.043,
                ),
          ),
          trailing: Text(
            "${widget.startTime.format(context)} - ${widget.endTime.format(context)}",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: c1,
                  fontSize: MediaQuery.of(context).size.width * 0.037,
                ),
          ),
        ),
      ),
    );
  }

  Future<void> _afterTap(BuildContext context) {
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
                    "Select Date Range:",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 20,
                        ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    "Start Date:",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 18,
                        ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await _selectDate(context, true);
                      setState(() {});
                    },
                    child: Text(
                      selectedStartDate == null
                          ? "Select start date"
                          : "Start date: ${selectedStartDate!.toLocal()}"
                              .split(' ')[0],
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 18, fontWeight: FontWeight.bold, color: c1),
                    ),
                  ),
                  Text(
                    "End Date:",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 18,
                        ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await _selectDate(context, false);
                      setState(() {});
                    },
                    child: Text(
                      selectedEndDate == null
                          ? "Select end date"
                          : "End date: ${selectedEndDate!.toLocal()}"
                              .split(' ')[0],
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
                  onPressed: () async {
                    if (selectedStartDate != null && selectedEndDate != null) {
                      await _saveSubscription(
                        widget.title,
                        widget.id,
                        selectedStartDate!,
                        selectedEndDate!,
                        context,
                      );
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: Colors.black.withOpacity(0.7),
                            insetPadding: EdgeInsets.zero,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Lottie.asset(
                                  'assets/animations/success.json'),
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

  Future<void> _saveSubscription(
    String name,
    String id,
    DateTime startDate,
    DateTime endDate,
    BuildContext context,
  ) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('services')
        .doc(name)
        .set(
      {
        'Start Date': startDate.toString(),
        'End Date': endDate.toString(),
        'id': id,
      },
    );

    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    String username = snapshot['name'];

    await FirebaseFirestore.instance
        .collection('Services')
        .doc(id)
        .collection('subscribers')
        .doc(uid)
        .set(
      {
        'Start Date': startDate.toString(),
        'End Date': endDate.toString(),
        'name': username,
      },
    );

    widget.onSubscribe();
  }
}
