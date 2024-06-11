import 'package:flutter/material.dart';
import 'package:jrd_s_c/common_utilities/colors.dart';

class HomePageElement extends StatelessWidget {
  const HomePageElement({
    super.key,
    required this.title,
    required this.desc,
    required this.date,
    required this.startTime,
    required this.endTime,
  });
  final String title;
  final String desc;
  final String date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.yellow.shade600,
          borderRadius: BorderRadius.circular(22),
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * 0.060,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffB80C09),
                          fontSize: MediaQuery.of(context).size.width * 0.043,
                        ),
                  ),
                  Text(
                    "${startTime.format(context)} - ${endTime.format(context)}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: c1,
                          fontSize: MediaQuery.of(context).size.width * 0.043,
                        ),
                  ),
                ],
              ),
              Text(
                desc,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.042,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BigGreyCircle extends StatelessWidget {
  const BigGreyCircle({
    super.key,
    required this.x,
  });

  final double x;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -MediaQuery.of(context).size.height * x / 2.2,
      left: -MediaQuery.of(context).size.width * x / 2.2,
      child: Container(
        height: MediaQuery.of(context).size.height * x * 1.1,
        width: MediaQuery.of(context).size.width * x * 1.1,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: c10,
        ),
      ),
    );
  }
}
