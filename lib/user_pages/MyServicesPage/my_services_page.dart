import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jrd_s_c/user_pages/MyServicesPage/active_subs.dart';
import 'package:jrd_s_c/user_pages/MyServicesPage/available_subs.dart';
import 'package:jrd_s_c/utilities/colors.dart';

class MyServicesPage extends StatefulWidget {
  const MyServicesPage({super.key});

  @override
  State<MyServicesPage> createState() => _MyServicesPageState();
}

class _MyServicesPageState extends State<MyServicesPage> {
  double x = 0.9;

  void _handleFloatingButtonPressed(BuildContext context) {
    final DateTime now = DateTime.now();
    if (now.day > 10) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Iconsax.close_circle),
              ),
            ],
            title: Text(
              "Cannot start new Subscription After 10th of a Month!",
              textAlign: TextAlign.center,
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
            ),
          );
        },
      );
    } else {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return AvailableSubscriptionPage();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _handleFloatingButtonPressed(context),
        backgroundColor: c3,
        child: const Icon(Iconsax.add, size: 50),
      ),
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
                    color: c7,
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
                    color: c10,
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Active Subscriptions:",
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
                      return const ActiveSubElement();
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
        ],
      ),
    );
  }
}
