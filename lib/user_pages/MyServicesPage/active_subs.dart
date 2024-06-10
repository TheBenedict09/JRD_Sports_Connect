import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jrd_s_c/common_utilities/colors.dart';
import 'package:intl/intl.dart';

class ActiveSubElement extends StatelessWidget {
  const ActiveSubElement({
    super.key,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.serviceID,
  });

  final String name;
  final String startDate;
  final String endDate;
  final String serviceID;

  String formatDate(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    final day = DateFormat('d').format(parsedDate);
    final suffix = day.endsWith('1') && day != '11'
        ? 'st'
        : day.endsWith('2') && day != '12'
            ? 'nd'
            : day.endsWith('3') && day != '13'
                ? 'rd'
                : 'th';
    final month = DateFormat('MMMM').format(parsedDate);
    return '$day$suffix of $month';
  }

  Future<void> _deleteService(BuildContext context) async {
    FirebaseFirestore.instance.collection('Services').doc(serviceID).collection('subscribers').doc(FirebaseAuth.instance.currentUser?.uid).delete();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Service deleted')));
    QuerySnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    for (var userDoc in userSnapshot.docs) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userDoc.id)
          .collection('services')
          .doc(name)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    const String timeRange = "01 Jan - 10 Jan";
    final DateTime now = DateTime.now();

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        decoration: BoxDecoration(
          color: c3,
          borderRadius: BorderRadius.circular(22),
        ),
        child: ListTile(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  content: Text(
                    "Validity: $timeRange",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 18,
                        ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        if (now.day < 9) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                actions: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Iconsax.close_circle),
                                  ),
                                ],
                                title: Text(
                                  "Cannot cancel a Subscription before 20th of a Month!",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(fontSize: 20),
                                ),
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      _deleteService(context);
                                      Navigator.of(context)
                                          .pop(); // Close the second dialog
                                      Navigator.of(context)
                                          .pop(); // Close the first dialog
                                    },
                                    child: const Text('Yes'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('No'),
                                  ),
                                ],
                                title: Text(
                                  "Are you sure?",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(fontSize: 20),
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: const Text('Stop Service'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                );
              },
            );
          },
          title: Text(
            name,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 23,
                ),
          ),
          subtitle: Text(
            '${formatDate(startDate)} - ${formatDate(endDate)}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: c1,
                  fontSize: 18,
                ),
          ),
        ),
      ),
    );
  }
}
