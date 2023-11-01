import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blooddonation/add.dart';
import 'package:flutter_blooddonation/update.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference donor =
  FirebaseFirestore.instance.collection('donar');

  // Delete
  void deleteDonor(docId) {
    donor.doc(docId).delete();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Blood Donation App',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddUser(),
          ),
        ),
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search by Blood Group',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: donor.orderBy('name').snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> donors = snapshot.data.docs;
                  final searchText = searchController.text.toLowerCase();

                  final filteredDonors = donors.where((donorSnap) {
                    final group = donorSnap['group'].toString().toLowerCase();
                    return group.contains(searchText);
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredDonors.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot donorSnap = filteredDonors[index];
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Text(
                              donorSnap['group'],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            donorSnap['name'],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Phone: ${donorSnap['phone']}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/update',
                                      arguments: {
                                        'name': donorSnap['name'],
                                        'phone':
                                        donorSnap['phone'].toString(),
                                        'group': donorSnap['group'],
                                        'id': donorSnap.id,
                                      });
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  launch("tel:${donorSnap['phone']}"); // Launch the phone dialer
                                },
                                icon: Icon(
                                  Icons.call,
                                  color: Colors.green, // You can customize the icon color
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  deleteDonor(donorSnap.id);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
