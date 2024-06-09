import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jrd_s_c/common_utilities/colors.dart';

class ActiveSubElement extends StatelessWidget {
  const ActiveSubElement({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const String subscriptionName = "Subscription Name";
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
                    subscriptionName,
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
                        if (now.day < 20) {
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
          title: const Text("Title",
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text("End Date:"),
          trailing: Text(
            "Time",
            style: TextStyle(color: c1),
          ),
        ),
      ),
    );
  }
}
