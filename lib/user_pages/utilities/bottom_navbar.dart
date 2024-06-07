import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jrd_s_c/user_pages/HomePage/home_page.dart';
import 'package:jrd_s_c/user_pages/MyServicesPage/my_services_page.dart';
import 'package:jrd_s_c/user_pages/ProfilePage/profile_page.dart';
import 'package:jrd_s_c/colors.dart';

class BottomNavBarPage extends StatefulWidget {
  final dynamic data;
  const BottomNavBarPage({super.key, this.data = "search"}); // Added 'super'
  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  var _index = 0;

  static const List<Widget> _widgetsOptions = <Widget>[
    HomePage(),
    MyServicesPage(),
    ProfilePage(),
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
        color: Color(0xffB80C09),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7.5),
          child: SafeArea(
            child: GNav(
              tabBackgroundColor: c5,
              gap: 15,
              backgroundColor: c1,
              haptic: true,
              padding: const EdgeInsets.all(16),
              tabs: const [
                GButton(
                  icon: Iconsax.home,
                  text: "Home",
                  iconActiveColor: Colors.white,
                  textColor: Colors.white,
                ),
                GButton(
                  icon: Iconsax.activity,
                  text: "My Services",
                  iconActiveColor: Colors.white,
                  textColor: Colors.white,
                ),
                GButton(
                  icon: Iconsax.user,
                  text: "Profile",
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
