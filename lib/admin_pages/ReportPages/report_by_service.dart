// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jrd_s_c/common_utilities/colors.dart';

class ServiceReport extends StatefulWidget {
  const ServiceReport({super.key});

  @override
  State<ServiceReport> createState() => _ServiceReportState();
}

class _ServiceReportState extends State<ServiceReport> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  Future<void> _showServicesDialog(DocumentSnapshot userDoc) async {
    var servicesSnapshot = await FirebaseFirestore.instance
        .collection('Services')
        .doc(userDoc.id)
        .collection('subscribers')
        .get();

    var services = servicesSnapshot.docs;

    List<Widget> subscriberWidgets = [];

    for (var serviceDoc in services) {
      var userId = serviceDoc.id;
      var userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        var userName = userSnapshot['name'];
        subscriberWidgets.add(
          ListTile(
            title: Text(
              userName,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
            ),
          ),
        );
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.lightBlue.shade300,
          title: Text(
            userDoc['title'],
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: c1,
                  fontSize: MediaQuery.of(context).size.width * 0.07,
                ),
          ),
          content: services.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Subscribers: ",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                          ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Colors.lightBlue.shade600,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: subscriberWidgets.isNotEmpty
                            ? subscriberWidgets
                            : [const Text('No Subscribers')],
                      ),
                    ),
                  ],
                )
              : const Text('No Subscribers'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade200,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.065,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade400,
                borderRadius: BorderRadius.circular(22),
              ),
              child: TextField(
                controller: _searchController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search Service",
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: c3, width: 3),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: BorderSide(
                        color: Colors.lightBlue.shade600, width: 2.3),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Services').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong!'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var names = snapshot.data?.docs ?? [];
                names.sort((a, b) => a['title'].compareTo(b['title']));

                var filteredNames = names.where(
                  (doc) {
                    var name = doc['title'].toString().toLowerCase();
                    return name.contains(_searchQuery.toLowerCase());
                  },
                ).toList();

                return ListView.builder(
                  itemCount: filteredNames.length,
                  itemBuilder: (context, index) {
                    var name = filteredNames[index];
                    return ListTile(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        _showServicesDialog(name);
                      },
                      title: Text(
                        name['title'],
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.065,
                            ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
