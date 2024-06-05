import 'package:flutter/material.dart';
import 'package:jrd_s_c/utilities/colors.dart';

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
