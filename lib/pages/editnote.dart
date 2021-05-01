import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class EditNote extends StatefulWidget {
  DocumentSnapshot docToEdit;
  EditNote({this.docToEdit});

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {

  TextEditingController title= TextEditingController();
  TextEditingController description= TextEditingController();

  CollectionReference refToTrash= FirebaseFirestore.instance.collection('trash');

  @override
  void initState(){
    title= TextEditingController(text: widget.docToEdit['title']);
    description= TextEditingController(text: widget.docToEdit['description']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
        backgroundColor: Colors.blue[900],
        actions:[
          TextButton.icon(
            label: Text('Save  ',style: TextStyle(color: Colors.grey[100])),
            icon: Icon(Icons.check_rounded, color: Colors.grey[100],),

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
            widget.docToEdit.reference.update({
              'title': title.text,
              'description': description.text
            }).whenComplete(() => Navigator.pop(context));
          }
            },
          ),
        ],

      ),
      body: Container(
        color: Colors.grey[100],
        padding: EdgeInsets.all(20.0),

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

            SizedBox(height: 5.0,),

            TextButton.icon(
                label: Text('Delete  ',style: TextStyle(color: Colors.red,)),
                icon: Icon(Icons.delete_outline_rounded, color: Colors.red,),

                onPressed: (){
                  refToTrash.add({
                    'title': title.text,
                    'description': description.text,
                  });
                  widget.docToEdit.reference.delete().whenComplete(()=>Navigator.pop(context));
                },
              ),

          ],
        ),
      ),

    );
  }
}




