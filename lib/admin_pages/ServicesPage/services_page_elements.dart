import 'package:flutter/material.dart';
import 'package:jrd_s_c/colors.dart';

class AdminServicesElements extends StatelessWidget {
  const AdminServicesElements({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        decoration: BoxDecoration(
          color: c10.withOpacity(0.3),
          borderRadius: BorderRadius.circular(22),
        ),
        child: ListTile(
          title: Text("Title", style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("Days:"),
          trailing: Text(
            "Time",
            style: TextStyle(color: c1),
          ),
        ),
      ),
    );
  }
}
