import 'package:flutter/material.dart';
import 'package:jrd_s_c/colors.dart';

class HomePageElement extends StatelessWidget {
  const HomePageElement({
    super.key,
  });

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
          title: Text("Update Title",
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("Description"),
          trailing: Text(
            "D&T",
            style: TextStyle(color: c1),
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
