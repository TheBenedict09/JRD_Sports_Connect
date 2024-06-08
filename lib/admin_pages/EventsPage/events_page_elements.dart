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
    final titleController = TextEditingController(text: title);
    final descController = TextEditingController(text: desc);

    DateTime selectedDate = DateTime.parse(startDay);
    TimeOfDay updatedStartTime = startTime;
    TimeOfDay updatedEndTime = endTime;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Event'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  TextButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Text(
                      'Date: ${selectedDate.toLocal()}'.split(' ')[0],
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: updatedStartTime,
                      );
                      if (pickedTime != null) {
                        setState(() {
                          updatedStartTime = pickedTime;
                        });
                      }
                    },
                    child:
                        Text('Start Time: ${updatedStartTime.format(context)}'),
                  ),
                  TextButton(
                    onPressed: () async {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: updatedEndTime,
                      );
                      if (pickedTime != null) {
                        setState(() {
                          updatedEndTime = pickedTime;
                        });
                      }
                    },
                    child: Text('End Time: ${updatedEndTime.format(context)}'),
                  ),
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                ],
              );
            },
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
                FirebaseFirestore.instance.collection('Events').doc(id).update({
                  'title': titleController.text,
                  'startDate': selectedDate.toIso8601String(),
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
          color: Colors.blueAccent.withOpacity(0.5),
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
