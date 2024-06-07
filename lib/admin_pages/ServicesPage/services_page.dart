import 'package:flutter/material.dart';
import 'package:jrd_s_c/admin_pages/ServicesPage/services_page_elements.dart';
import 'package:jrd_s_c/colors.dart';

class AdminServicesPage extends StatefulWidget {
  const AdminServicesPage({super.key});

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

  void _showAddServiceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Service'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              DropdownButton<String>(
                hint: Text('Select Starting Day'),
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
                hint: Text('Select Ending Day'),
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
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                // You can add your logic to save the new service here.
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.07,
        child: FloatingActionButton(
          onPressed: _showAddServiceDialog,
          backgroundColor: c10,
          child: Text(
            "Add new Service",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w900, fontSize: 20, color: c5),
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w900, fontSize: 50, color: c5),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.14 * 5,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const AdminServicesElements();
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
    );
  }
}
