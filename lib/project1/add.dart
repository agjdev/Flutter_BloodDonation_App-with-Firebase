import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {

  final bloodgroups = ['A+','A-','AB+','AB-','B+','B-','O+','O-'];
  String? selectedgroups ;
  final CollectionReference donor = FirebaseFirestore.instance.collection('donor');

  TextEditingController donorName = TextEditingController();
  TextEditingController donorMobile = TextEditingController();


  void addDonor(){
    final data = {
      'name':donorName.text,
      'mobile':donorMobile.text,
      'group':selectedgroups

    };
    donor.add(data);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Donors"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: donorName,
                keyboardType: TextInputType.name,
                maxLength: 20,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Donor Name"),

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: donorMobile,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Mobile Number"),

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  label: Text("Select blood group")
                ),
                  items: bloodgroups.map((e)=>DropdownMenuItem(
                      value: e,
                      child: Text(e)
                  )).toList(),

                  onChanged: (val){
                    selectedgroups = val as String?;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: (){
                addDonor();
                Navigator.pop(context);
              },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    minimumSize: MaterialStateProperty.all(
                      Size(
                        double.infinity,50
                      ),

                    ),
                  ),
                  child: Text("Submit", style:TextStyle(
                    fontSize: 20,
                  ))),
            )

          ],
        ),
      ),
    );
  }
}
