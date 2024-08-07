// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jrd_s_c/admin_pages/EventsPage/events_page_elements.dart';
import 'package:jrd_s_c/common_utilities/colors.dart';

class AdminEventsPage extends StatefulWidget {
  const AdminEventsPage({super.key});

  @override
  State<AdminEventsPage> createState() => AdminEventsPageState();
}

class B {
  static const String part2 = "in@g";
}

class AdminEventsPageState extends State<AdminEventsPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  Future<void> _addEvent() async {
    String title = _titleController.text;
    String desc = _descController.text;
    String startTime = _startTime?.format(context) ?? '';
    String endTime = _endTime?.format(context) ?? '';

    if (title.isEmpty ||
        _selectedDate == null ||
        desc.isEmpty ||
        startTime.isEmpty ||
        endTime.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all fields')));
      return;
    }

    CollectionReference events =
        FirebaseFirestore.instance.collection('Events');
    await events.add(
      {
        'title': title,
        'Desc': desc,
        'startDate': _selectedDate?.toIso8601String(),
        'startTime': startTime,
        'endTime': endTime,
      },
    );

    _titleController.clear();
    _descController.clear();
    setState(() {
      _selectedDate = null;
      _startTime = null;
      _endTime = null;
    });
  }

  void _showAddEventDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add New Event',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextButton(
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
                child: Text(_selectedDate == null
                    ? 'Select Date'
                    : 'Date: ${_selectedDate!.toLocal()}'.split(' ')[0]),
              ),
              TextButton(
                onPressed: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (BuildContext context, Widget? child) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: false),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    setState(() {
                      _startTime = picked;
                    });
                  }
                },
                child: Text(_startTime == null
                    ? 'Select Start Time'
                    : 'Start Time: ${_startTime!.format(context)}'),
              ),
              TextButton(
                onPressed: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (BuildContext context, Widget? child) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: false),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    setState(() {
                      _endTime = picked;
                    });
                  }
                },
                child: Text(_endTime == null
                    ? 'Select End Time'
                    : 'End Time: ${_endTime!.format(context)}'),
              ),
              TextField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () async {
                await _addEvent();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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

  double x = 0.9;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: c10.withOpacity(0.2),
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.07,
          child: FloatingActionButton(
            onPressed: _showAddEventDialog,
            backgroundColor: Colors.blue,
            child: Text(
              "Add new Event",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
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
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 160,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Events').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final events = snapshot.data?.docs ?? [];

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Events:",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w900,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.121,
                              ),
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var event = events[index];
                          TimeOfDay startTime =
                              _timeFromString(event['startTime']);
                          TimeOfDay endTime = _timeFromString(event['endTime']);
                          DateTime startDate =
                              DateTime.parse(event['startDate']);
                          return AdminEventsElements(
                            title: event['title'],
                            startDay: '${startDate.toLocal()}'.split(' ')[0],
                            startTime: startTime,
                            id: event.id,
                            endTime: endTime,
                            desc: event['Desc'],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.only(left: 38, right: 38),
                            child: Divider(),
                          );
                        },
                        itemCount: events.length,
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ));
  }
}
