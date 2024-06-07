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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                      return const NewSubElement();
                    },
                    separatorBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.only(left: 38, right: 38),
                        child: Divider(),
                      );
                    },
                    itemCount: 5,
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

class NewSubElement extends StatefulWidget {
  const NewSubElement({super.key});

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
      initialTime: isStartTime
          ? const TimeOfDay(hour: 5, minute: 0)
          : const TimeOfDay(hour: 21, minute: 0),
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
      // Show a dialog if the selected time is out of the allowed range
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid Time"),
          content: const Text("Please select a time between 5:00 AM and 9:00 PM."),
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
          color: c10,
          borderRadius: BorderRadius.circular(22),
        ),
        child: ListTile(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      title: Text(
                        "Title",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Select Time Range:",
                            textAlign: TextAlign.left,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 20,
                                    ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Text(
                            "Start Time:",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: c1),
                            ),
                          ),
                          Text(
                            "End Time:",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: c1),
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
                            if (selectedStartTime != null &&
                                selectedEndTime != null) {
                              print(
                                  "Selected Start Time: ${selectedStartTime!.format(context)}");
                              print(
                                  "Selected End Time: ${selectedEndTime!.format(context)}");

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

                              Future.delayed(const Duration(seconds: 2), () {
                                Navigator.of(context)
                                    .pop(); // Close the confirmation dialog
                                Navigator.of(context)
                                    .pop(); // Close the original dialog
                              });
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
          title: const Text("Title",
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text("Time:"),
        ),
      ),
    );
  }
}
