import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final bloodGroups = ['A+','A-','B+','B-','O+','O-','AB+','AB-'];
  String ?selectedGroup;
  final CollectionReference donor =
  FirebaseFirestore.instance.collection('donar');

  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();


  void addDonar(){
    final data = {
      'name' : donorName.text,
      'phone': donorPhone.text,
      'group': selectedGroup,
    };
    donor.add(data);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Doners',style: TextStyle(
            fontSize: 25,fontWeight: FontWeight.w600,color: Colors.white
        ),
        ),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: donorName,
              decoration: (
              InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Donar Name')
              )
              ),
            ),
            SizedBox(height: 14,),
            TextField(
              controller: donorPhone,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: (
              InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Phone Number')
              )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  label: Text('Selected Blood Groups')
                ),
                  items: bloodGroups.map((e) =>
                  DropdownMenuItem(
                  child:Text(e),
                    value: e,
                  )
              ).toList(),
                  onChanged: (val){
                  selectedGroup = val as String?;
                  }),
            ),
            ElevatedButton(
                onPressed: (){
                    addDonar();
                    Navigator.pop(context);
                },
              style: ButtonStyle(
              maximumSize:
              MaterialStateProperty.all(Size(double.infinity,50)),
              backgroundColor:
              MaterialStateProperty.all(Colors.red)
            ),
    child: Text('Submit',
            ),
            ),
          ],
        ),
      ),
    );
  }
}
