import 'package:flutter/material.dart';
import 'package:jrd_s_c/utilities/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double x = 0.9;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Positioned(
                top: -MediaQuery.of(context).size.height * x / 2.2,
                right: -MediaQuery.of(context).size.width * x / 2.2,
                child: Container(
                  height: MediaQuery.of(context).size.height * x * 1.1,
                  width: MediaQuery.of(context).size.width * x * 1.1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: c8,
                  ),
                ),
              ),
              // Circle in the middle left side
              Positioned(
                top: MediaQuery.of(context).size.height / 2 -
                    (MediaQuery.of(context).size.height * x / 2.2),
                left: -MediaQuery.of(context).size.width * x / 2.2,
                child: Container(
                  height: MediaQuery.of(context).size.height * x,
                  width: MediaQuery.of(context).size.width * x,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: c7,
                  ),
                ),
              ),
              // Circle in the bottom right corner
              Positioned(
                bottom: -MediaQuery.of(context).size.height * x / 2.2,
                right: -MediaQuery.of(context).size.width * x / 2.2,
                child: Container(
                  height: MediaQuery.of(context).size.height * x,
                  width: MediaQuery.of(context).size.width * x,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: c10,
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Ayush Benedict Singh,",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 50,
                        ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Your Email",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.068,
                    decoration: BoxDecoration(
                      color: c5,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text(
                        "xyz@gmail.com",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: c3),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Phone Number",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.068,
                    decoration: BoxDecoration(
                      color: c5,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text(
                        "1234567890",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: c3),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Address",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.069,
                    decoration: BoxDecoration(
                      color: c5,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text(
                        "California",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: c3),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.065,
                    child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: c9,
                      child: Text(
                        "Edit",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
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
