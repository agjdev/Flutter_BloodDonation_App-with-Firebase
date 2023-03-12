import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';



class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key}) : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final bloodgroups = ['A+','A-','AB+','AB-','B+','B-','O+','O-'];
  String? selectedgroups ;
  final CollectionReference donor = FirebaseFirestore.instance.collection('donor');
  TextEditingController donorName = TextEditingController();
  TextEditingController donorMobile = TextEditingController();

  void updatedonor(docId){
    final data = {
      'name':donorName.text,
      'mobile':donorMobile.text,
      'group':selectedgroups
    };
    donor.doc(docId).update(data);

  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donorName.text = args['name'];
    donorMobile.text = args['mobile'];
    selectedgroups = args['group'];
    final docId = args['id'];


    return Scaffold(
      appBar: AppBar(
        title: Text("Update the User"),
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
                value: selectedgroups,
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

                updatedonor(docId);

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
                  child: Text("Update", style:TextStyle(
                    fontSize: 20,
                  ))),
            )

          ],
        ),
      ),
    );
  }
}
