import 'package:flutter/material.dart';
import 'package:jrd_s_c/utilities/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double x = 0.9;
  String email = "xyz@gmail.com";
  String phoneNumber = "1234567890";
  String address = "California";

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

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
                        email,
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
                        phoneNumber,
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
                        address,
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
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.065,
                    child: FloatingActionButton(
                      onPressed: () {
                        emailController.text = email;
                        phoneNumberController.text = phoneNumber;
                        addressController.text = address;

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Edit Profile',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: c8),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                        labelText: 'Email'),
                                  ),
                                  TextField(
                                    controller: phoneNumberController,
                                    decoration: const InputDecoration(
                                        labelText: 'Phone Number'),
                                  ),
                                  TextField(
                                    controller: addressController,
                                    decoration: const InputDecoration(
                                        labelText: 'Address'),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      email = emailController.text;
                                      phoneNumber = phoneNumberController.text;
                                      address = addressController.text;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Save'),
                                ),
                              ],
                            );
                          },
                        );
                      },
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
