import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jrd_s_c/admin_pages/EventsPage/events_page_elements.dart';
import 'package:jrd_s_c/colors.dart';

class AdminEventsPage extends StatefulWidget {
  const AdminEventsPage({super.key});

  @override
  State<AdminEventsPage> createState() => AdminEventsPageState();
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
          title: const Text('Add New Event'),
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
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.07,
        child: FloatingActionButton(
          onPressed: _showAddEventDialog,
          backgroundColor: Colors.blueAccent,
          child: Text(
            "Add new Event",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w900, fontSize: 20, color: c5),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Events').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
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
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w900, fontSize: 50, color: c5),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var event = events[index];
                    TimeOfDay startTime = _timeFromString(event['startTime']);
                    TimeOfDay endTime = _timeFromString(event['endTime']);
                    DateTime startDate = DateTime.parse(event['startDate']);
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
    );
  }
}
