import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jrd_s_c/admin_pages/ServicesPage/services_page_elements.dart';
import 'package:jrd_s_c/common_utilities/colors.dart';

class AdminServicesPage extends StatefulWidget {
  const AdminServicesPage({Key? key}) : super(key: key);

  @override
  State<AdminServicesPage> createState() => Admin_ServicesPageState();
}

class Admin_ServicesPageState extends State<AdminServicesPage> {
  final TextEditingController _titleController = TextEditingController();
  final List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  String? _startDay;
  String? _endDay;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  Future<void> _addService() async {
    String title = _titleController.text;
    String startDay = _startDay ?? '';
    String endDay = _endDay ?? '';
    String startTime = _startTime?.format(context) ?? '';
    String endTime = _endTime?.format(context) ?? '';

    if (title.isEmpty ||
        startDay.isEmpty ||
        endDay.isEmpty ||
        startTime.isEmpty ||
        endTime.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all fields')));
      return;
    }

    CollectionReference services =
        FirebaseFirestore.instance.collection('Services');
    await services.add({
      'title': title,
      'startDay': startDay,
      'endDay': endDay,
      'startTime': startTime,
      'endTime': endTime,
    });
  }

  void _showAddServiceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add New Service',
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
              DropdownButton<String>(
                hint: const Text('Select Starting Day'),
                value: _startDay,
                onChanged: (String? newValue) {
                  setState(() {
                    _startDay = newValue;
                  });
                },
                items: _daysOfWeek.map<DropdownMenuItem<String>>((String day) {
                  return DropdownMenuItem<String>(
                    value: day,
                    child: Text(day),
                  );
                }).toList(),
              ),
              DropdownButton<String>(
                hint: const Text('Select Ending Day'),
                value: _endDay,
                onChanged: (String? newValue) {
                  setState(() {
                    _endDay = newValue;
                  });
                },
                items: _daysOfWeek.map<DropdownMenuItem<String>>((String day) {
                  return DropdownMenuItem<String>(
                    value: day,
                    child: Text(day),
                  );
                }).toList(),
              ),
              TextButton(
                onPressed: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (BuildContext context, Widget? child) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: true),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null && picked != _startTime) {
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
                            .copyWith(alwaysUse24HourFormat: true),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null && picked != _endTime) {
                    setState(() {
                      _endTime = picked;
                    });
                  }
                },
                child: Text(_endTime == null
                    ? 'Select End Time'
                    : 'End Time: ${_endTime!.format(context)}'),
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
                await _addService();
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
            onPressed: _showAddServiceDialog,
            backgroundColor: Colors.yellow.shade600,
            child: Text(
              "Add new Service",
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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow.shade600,
                    ),
                  ),
                )
              ],
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Services').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final services = snapshot.data?.docs ?? [];

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
                          "Services:",
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height *
                            0.15 *
                            services.length,
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var service = services[index];
                            TimeOfDay startTime =
                                _timeFromString(service['startTime']);
                            TimeOfDay endTime =
                                _timeFromString(service['endTime']);
                            return AdminServicesElements(
                              title: service['title'],
                              startDay: service['startDay'],
                              endDay: service['endDay'],
                              startTime: startTime,
                              endTime: endTime,
                              id: service.id,
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
