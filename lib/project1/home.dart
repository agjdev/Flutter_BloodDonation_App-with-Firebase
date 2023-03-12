import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference donor = FirebaseFirestore.instance.collection('donor');

  void deletedonor(docId){
    donor.doc(docId).delete();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Donation App"),
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, '/adduser');
      },
        child: Icon(Icons.add,
        size: 40,),
      backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    body: StreamBuilder(stream: donor.orderBy('name').snapshots(),builder:(context,AsyncSnapshot snapshot){
      if(snapshot.hasData){
        
        return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
              final DocumentSnapshot donorSnap = snapshot.data.docs[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),

                    color: Colors.white
                  ),
                  height: 80,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: CircleAvatar(
                          backgroundColor: Colors.white70,
                          foregroundColor: Colors.red,
                          radius: 30,
                          child: Text(donorSnap['group']),
                        ),
                      ),
                      Column(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(donorSnap['name']),
                          Text(donorSnap['mobile'].toString()),

                        ],
                      ),
                      Row(
                        children: [
                          IconButton(onPressed: (){
                            Navigator.pushNamed(context, '/update',
                            arguments: {
                              'name':donorSnap['name'],
                              'mobile':donorSnap['mobile'].toString(),
                              'group':donorSnap['group'],
                              'id':donorSnap.id

                            }                            );

                          }, icon: Icon(Icons.edit),
                            color: Colors.green,),
                          IconButton(onPressed: (){
                            deletedonor(donorSnap.id);
                          }, icon: Icon(Icons.delete),
                              color: Colors.red ,)

                        ],
                      )


                    ],
                  )
                ),
              );
            });

      }
      return Container ();

    } ,),
    );
  }
}
