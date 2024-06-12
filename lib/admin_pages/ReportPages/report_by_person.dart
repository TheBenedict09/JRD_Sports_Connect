// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jrd_s_c/common_utilities/colors.dart';

class PersonReport extends StatefulWidget {
  const PersonReport({super.key});

  @override
  State<PersonReport> createState() => _PersonReportState();
}

class _PersonReportState extends State<PersonReport> {
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
        .collection('users')
        .doc(userDoc.id)
        .collection('services')
        .get();

    var services = servicesSnapshot.docs;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.yellow.shade300,
          title: Text(
            userDoc['name'],
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
                      "Services: ",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                          ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Colors.yellow.shade600),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: services.map((serviceDoc) {
                          return ListTile(
                            title: Text(
                              serviceDoc.id,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.06,
                                  ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                )
              : const Text('No services available'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade200,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.065,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.yellow.shade300,
                borderRadius: BorderRadius.circular(22),
              ),
              child: TextField(
                controller: _searchController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search Person",
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: c3, width: 3),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide:
                        BorderSide(color: Colors.yellow.shade600, width: 2.3),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
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
                names.sort((a, b) => a['name'].compareTo(b['name']));

                var filteredNames = names.where(
                  (doc) {
                    var name = doc['name'].toString().toLowerCase();
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
                        name['name'],
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
