import 'package:flutter/material.dart';
import 'package:jrd_s_c/utilities/colors.dart';

class ActiveSubElement extends StatelessWidget {
  const ActiveSubElement({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        decoration: BoxDecoration(
          color: c4,
          borderRadius: BorderRadius.circular(22),
        ),
        child: ListTile(
          onTap: () {
            
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
