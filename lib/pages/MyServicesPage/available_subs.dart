import 'package:flutter/material.dart';
import 'package:jrd_s_c/pages/MyServicesPage/active_subs.dart';
import 'package:jrd_s_c/utilities/colors.dart';

class AvailableSubscriptionPage extends StatefulWidget {
  const AvailableSubscriptionPage({super.key});

  @override
  State<AvailableSubscriptionPage> createState() =>
      _AvailableSubscriptionPageState();
}

class _AvailableSubscriptionPageState extends State<AvailableSubscriptionPage> {
  double x = 0.9;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    color: c1,
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
                    color: c5,
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Available Subscriptions:",
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
                      return const NewSubElement();
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

class NewSubElement extends StatelessWidget {
  const NewSubElement({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        decoration: BoxDecoration(
          color: c10,
          borderRadius: BorderRadius.circular(22),
        ),
        child: ListTile(
          title: const Text("Title",
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text("Time:"),
        ),
      ),
    );
  }
}
