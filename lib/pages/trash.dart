import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Trash extends StatefulWidget {
  @override
  _TrashState createState() => _TrashState();
}

class _TrashState extends State<Trash> {

  CollectionReference refToTrash= FirebaseFirestore.instance.collection('trash');
  CollectionReference refToNotes= FirebaseFirestore.instance.collection('notes');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restore'),
        backgroundColor: Colors.blue[900],
      ),
      body: StreamBuilder(
        stream: refToTrash.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.grey[100],
            alignment: Alignment.center,
            child: snapshot.hasData?
            snapshot.data.docs.length == 0 ?
            Text("Trash is empty", style: TextStyle(fontSize: 20, color: Colors.grey), textAlign: TextAlign.center,) :
            ListView.builder(
              itemCount: snapshot.hasData ? snapshot.data.docs.length : 0,
              itemBuilder: (_, index) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white
                  ),
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                  margin: EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  height: 100.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("  "+ snapshot.data.docs[index]['title'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            child: Text("Restore",
                              style: TextStyle(color: Colors.blue[900])),
                            onPressed: () {
                              refToNotes.add({
                                'title': snapshot.data.docs[index]['title'],
                                'description': snapshot.data
                                    .docs[index]['description'],
                              });
                              DocumentSnapshot ds = snapshot.data.docs[index];
                              FirebaseFirestore.instance.collection('trash').doc(ds.id).delete();
                            },
                          ),
                          TextButton(
                            child: Text("Delete Permanently",
                              style: TextStyle(color: Colors.red),),
                            onPressed: () {
                              DocumentSnapshot ds = snapshot.data.docs[index];
                              FirebaseFirestore.instance.collection('trash').doc(ds.id).delete();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ):SizedBox(),

          );
        }
          ),


    );
  }
}
