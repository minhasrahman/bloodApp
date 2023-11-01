import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateDonor extends StatefulWidget {
  const UpdateDonor({super.key});

  @override
  State<UpdateDonor> createState() => _UpdateDonorState();
}

class _UpdateDonorState extends State<UpdateDonor> {
  final bloodGroups = ['A+','A-','B+','B-','O+','O-','AB+','AB-'];
  String ?selectedGroup;
  final CollectionReference donor =
  FirebaseFirestore.instance.collection('donar');

  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();


//////update
  void updateDonor(docId){
    final data = {
      'name':donorName.text,
      'phone': donorPhone.text,
      'grop': selectedGroup
    };
    donor.doc(docId).update(data).then((value) => Navigator.pop(context));
  }




  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    donorName.text = args['name'];
    donorPhone.text = args['phone'];
    selectedGroup = args['group'];
    final docId = args['id'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit',style: TextStyle(
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
                value: selectedGroup,
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
                updateDonor(docId);
              },
              style: ButtonStyle(
                  maximumSize:
                  MaterialStateProperty.all(Size(double.infinity,50)),
                  backgroundColor:
                  MaterialStateProperty.all(Colors.red)
              ),
              child: Text('Update',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
