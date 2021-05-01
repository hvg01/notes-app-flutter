import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {


  TextEditingController title= TextEditingController();
  TextEditingController description= TextEditingController();
  CollectionReference refToNotes= FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
        backgroundColor: Colors.blue[900],
        actions:[
          TextButton.icon(
            label: Text('Save  ', style: TextStyle(color: Colors.grey[100])),
            icon: Icon(Icons.check_rounded, color:Colors.grey[100]),
            onPressed: (){
              if(title.text=='')
                {
                  final snackBar = SnackBar(
                    content: Text('Title cannot be empty!'),
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              else {
                refToNotes.add({
                  'title': title.text,
                  'description': description.text,
                }).whenComplete(() => Navigator.pop(context));
              }
              },
          ),
        ],

      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          color: Colors.grey[100],

          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: title,
                  decoration: InputDecoration(hintText: 'Title', enabledBorder: InputBorder.none ),
                ),
              ),

              SizedBox(height: 10.0,),

              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: description,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(hintText: 'Description', enabledBorder: InputBorder.none),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
