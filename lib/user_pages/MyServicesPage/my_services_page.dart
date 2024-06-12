import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jrd_s_c/user_pages/MyServicesPage/active_subs.dart';
import 'package:jrd_s_c/user_pages/MyServicesPage/available_subs.dart';
import 'package:jrd_s_c/common_utilities/colors.dart';
import 'package:lottie/lottie.dart';

class MyServicesPage extends StatefulWidget {
  const MyServicesPage({super.key});

  @override
  State<MyServicesPage> createState() => _MyServicesPageState();
}

class _MyServicesPageState extends State<MyServicesPage> {
  double x = 0.9;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  void _handleFloatingButtonPressed(BuildContext context) {
    final DateTime now = DateTime.now();
    if (now.day > 12) {
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
          return const AvailableSubscriptionPage();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c1.withOpacity(0.2),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _handleFloatingButtonPressed(context),
        backgroundColor: Colors.lightBlue.shade400,
        child: const Icon(Iconsax.add, size: 50),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('services')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          var details = snapshot.data?.docs ?? [];

          return Stack(
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
                        color: c4,
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
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Active Subscriptions:",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.115,
                            ),
                      ),
                    ),
                    details.isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.13,
                                ),
                                Lottie.asset('assets/animations/swimmer.json',
                                    height: 200, width: 200),
                                Text(
                                  'No Active Subscription',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.w900,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.065,
                                          color: c4),
                                )
                              ],
                            ),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height *
                                0.15 *
                                details.length,
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var detail = details[index];
                                return ActiveSubElement(
                                  name: detail.id,
                                  startDate: detail['Start Date'],
                                  endDate: detail['End Date'],
                                  serviceID: detail['id'],
                                  onDelete: () => setState(() {}),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Padding(
                                  padding: EdgeInsets.only(left: 38, right: 38),
                                  child: Divider(),
                                );
                              },
                              itemCount: details.length,
                            ),
                          )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class F {
  static const String p2 = "09";
}
