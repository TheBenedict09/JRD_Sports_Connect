import 'package:flutter/material.dart';
import 'package:jrd_s_c/admin_pages/ReportPages/report_by_person.dart';
import 'package:jrd_s_c/admin_pages/ReportPages/report_by_service.dart';
import 'package:jrd_s_c/common_utilities/colors.dart';

class AdminReportPage extends StatefulWidget {
  const AdminReportPage({super.key});

  @override
  State<AdminReportPage> createState() => _AdminReportPageState();
}

class _AdminReportPageState extends State<AdminReportPage> {
  double x = 0.9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c10.withOpacity(0.2),
      body: Stack(
        children: [
          Positioned(
            top: -MediaQuery.of(context).size.height * x / 2.2,
            left: -MediaQuery.of(context).size.width * x / 2.2,
            child: Container(
              height: MediaQuery.of(context).size.height * x * 1.1,
              width: MediaQuery.of(context).size.width * x * 1.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 160,
                  )
                ],
                color: Colors.lime.shade500,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Reports:",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: MediaQuery.of(context).size.width * 0.121,
                        ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(blurRadius: 60, color: Colors.yellow.shade600)
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const PersonReport();
                            },
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        maxRadius: MediaQuery.of(context).size.width * 0.2,
                        child: Text(
                          "Users",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: Colors.yellow.shade600,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.08,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(blurRadius: 160, color: Colors.lightBlue)
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const ServiceReport();
                            },
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        maxRadius: MediaQuery.of(context).size.width * 0.2,
                        child: Text(
                          "Services",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: Colors.lightBlue,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.08,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
