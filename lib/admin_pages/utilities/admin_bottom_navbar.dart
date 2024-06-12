import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jrd_s_c/admin_pages/EventsPage/event_page.dart';
import 'package:jrd_s_c/admin_pages/ReportPages/report.dart';
import 'package:jrd_s_c/admin_pages/ServicesPage/services_page.dart';
import 'package:jrd_s_c/common_utilities/colors.dart';

class AdminBottomNavBarPage extends StatefulWidget {
  final dynamic data;
  const AdminBottomNavBarPage(
      {super.key, this.data = "search"}); // Added 'super'
  @override
  State<AdminBottomNavBarPage> createState() => _AdminBottomNavBarPageState();
}

class _AdminBottomNavBarPageState extends State<AdminBottomNavBarPage> {
  var _index = 0;

  static const List<Widget> _widgetsOptions = <Widget>[
    AdminServicesPage(),
    AdminEventsPage(),
    AdminReportPage(),
  ];
  @override
  void initState() {
    super.initState();
    _updateIndex();
  }

  void _updateIndex() {
    if (widget.data == "Home") {
      _index = 1;
    } else {
      _index = 0; // Set default index if not "Home"
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.data == "Home") {
    //   _index = 1;
    //   print(widget.data);
    // } else {
    //   print(widget.data);
    // }
    return Scaffold(
      body: _widgetsOptions.elementAt(_index),
      bottomNavigationBar: Container(
        color: const Color(0xffF4A261),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7.5),
          child: SafeArea(
            child: GNav(
              tabBackgroundColor: c5,
              gap: 15,
              backgroundColor: c10,
              haptic: true,
              padding: const EdgeInsets.all(16),
              tabs: const [
                GButton(
                  icon: Icons.miscellaneous_services,
                  text: "Services",
                  iconActiveColor: Colors.white,
                  textColor: Colors.white,
                ),
                GButton(
                  icon: Icons.event,
                  text: "Events",
                  iconActiveColor: Colors.white,
                  textColor: Colors.white,
                ),
                GButton(
                  icon: Icons.edit_document,
                  text: "Report",
                  iconActiveColor: Colors.white,
                  textColor: Colors.white,
                ),
              ],
              selectedIndex: _index,
              onTabChange: (value) {
                setState(() {
                  _index = value;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

// class NavigationController extends StatelessWidget {
//   final Rx<int> selectedInndex = 0.obs;
// }
