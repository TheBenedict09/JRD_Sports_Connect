import 'package:flutter/material.dart';
import 'package:jrd_s_c/colors.dart';

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
          color: c3,
          borderRadius: BorderRadius.circular(22),
        ),
        child: ListTile(
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
                date,
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
