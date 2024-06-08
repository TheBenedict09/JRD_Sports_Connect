import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jrd_s_c/colors.dart';

class AdminEventsElements extends StatelessWidget {
  final String id;
  final String title;
  final String startDay;
  final String desc;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  const AdminEventsElements({
    Key? key,
    required this.id,
    required this.title,
    required this.startDay,
    required this.desc,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  void _showEditDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Edit or Delete Event',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w900, fontSize: 23, color: c5),
          ),
          content: Text(
            'Would you like to edit or delete this event?',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontSize: 17, color: c5),
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
    TextEditingController descController = TextEditingController(text: desc);

    String updatedStartDay = startDay;
    TimeOfDay updatedStartTime = startTime;
    TimeOfDay updatedEndTime = endTime;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Event'),
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
                  if (newValue != null) updatedStartDay = newValue;
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
                child: Text('Start Time: ${updatedStartTime.format(context)}'),
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
                child: Text('End Time: ${updatedEndTime.format(context)}'),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Description'),
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
                    .collection('Events')
                    .doc(id)
                    .update({
                  'title': titleController.text,
                  'startDay': updatedStartDay,
                  'Desc': descController.text,
                  'startTime': updatedStartTime.format(context),
                  'endTime': updatedEndTime.format(context),
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

  void _deleteService(BuildContext context) {
    FirebaseFirestore.instance.collection('Events').doc(id).delete();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Event deleted')));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          color: c10.withOpacity(0.3),
          borderRadius: BorderRadius.circular(22),
        ),
        child: ListTile(
          onTap: () {
            _showEditDeleteDialog(context);
          },
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Text(
                startDay,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xffB80C09),
                  fontSize: 16,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
          trailing: Text(
            "${startTime.format(context)} - ${endTime.format(context)}",
            style: TextStyle(
              color: c1,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
