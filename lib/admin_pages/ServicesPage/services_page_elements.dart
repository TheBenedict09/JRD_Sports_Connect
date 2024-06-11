import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jrd_s_c/common_utilities/colors.dart';

class AdminServicesElements extends StatelessWidget {
  final String id;
  final String title;
  final String startDay;
  final String endDay;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  const AdminServicesElements({
    super.key,
    required this.id,
    required this.title,
    required this.startDay,
    required this.endDay,
    required this.startTime,
    required this.endTime,
  });

  void _showEditDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Edit or Delete Service',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
          ),
          content: Text(
            'Would you like to edit or delete this service?',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.0425,
                ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showEditServiceDialog(context);
              },
              child: const Text('Edit'),
            ),
            TextButton(
              onPressed: () {
                _deleteService(context);
                Navigator.of(context).pop();
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _showEditServiceDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: title);
    String? updatedStartDay = startDay;
    String? updatedEndDay = endDay;
    TimeOfDay? updatedStartTime = startTime;
    TimeOfDay? updatedEndTime = endTime;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Service'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              DropdownButton<String>(
                hint: const Text('Select Starting Day'),
                value: updatedStartDay,
                onChanged: (String? newValue) {
                  updatedStartDay = newValue;
                },
                items: [
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday',
                  'Sunday'
                ].map<DropdownMenuItem<String>>((String day) {
                  return DropdownMenuItem<String>(
                    value: day,
                    child: Text(day),
                  );
                }).toList(),
              ),
              DropdownButton<String>(
                hint: const Text('Select Ending Day'),
                value: updatedEndDay,
                onChanged: (String? newValue) {
                  updatedEndDay = newValue;
                },
                items: [
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday',
                  'Sunday'
                ].map<DropdownMenuItem<String>>((String day) {
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
                    initialTime: startTime,
                  );
                  if (picked != null && picked != updatedStartTime) {
                    updatedStartTime = picked;
                  }
                },
                child: Text(updatedStartTime == null
                    ? 'Select Start Time'
                    : 'Start Time: ${updatedStartTime!.format(context)}'),
              ),
              TextButton(
                onPressed: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: endTime,
                  );
                  if (picked != null && picked != updatedEndTime) {
                    updatedEndTime = picked;
                  }
                },
                child: Text(updatedEndTime == null
                    ? 'Select End Time'
                    : 'End Time: ${updatedEndTime!.format(context)}'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('Services')
                    .doc(id)
                    .update({
                  'title': titleController.text,
                  'startDay': updatedStartDay,
                  'endDay': updatedEndDay,
                  'startTime': updatedStartTime?.format(context),
                  'endTime': updatedEndTime?.format(context),
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteService(BuildContext context) async {
    FirebaseFirestore.instance.collection('Services').doc(id).delete();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Service deleted')));
    QuerySnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    for (var userDoc in userSnapshot.docs) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userDoc.id)
          .collection('services')
          .doc(title)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(22),
        ),
        child: ListTile(
          onTap: () {
            _showEditDeleteDialog(context);
          },
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.065,
                ),
          ),
          subtitle: Text(
            "$startDay - $endDay",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: c5,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.043,
                ),
          ),
          trailing: Text(
            "${startTime.format(context)} - ${endTime.format(context)}",
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
}
