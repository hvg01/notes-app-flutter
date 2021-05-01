import 'package:flutter/material.dart';
import 'package:notes_app/pages/editnote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class NotesList extends StatefulWidget {
  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {

  final refToNotes= FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0,
        title: Text(
            'Notes',
          style: TextStyle(fontSize: 20.0),

        ),
      ),
      body: StreamBuilder(
        stream: refToNotes.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Container(
              color: Colors.grey[100],
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10.0),
                child: snapshot.hasData?
                snapshot.data.docs.length == 0 ?
                RichText(
                    text : TextSpan(style: TextStyle(fontSize: 20, color: Colors.grey),
                          children: [TextSpan(text: 'Click on '),
                          WidgetSpan(child: Icon(Icons.add_circle_outline, color: Colors.grey,)),
                          TextSpan(text: ' to add a note')]
                    )):

                ListView.builder(
                  itemCount: snapshot.hasData?snapshot.data.docs.length:0,
                  itemBuilder: (_,index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>EditNote(docToEdit: snapshot.data.docs[index])));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white
                      ),
                        padding: EdgeInsets.symmetric(vertical:0.0, horizontal: 20.0) ,
                      margin: EdgeInsets.symmetric(vertical:5.0,horizontal:10.0),
                      height: 75.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(" "+ snapshot.data.docs[index]['title'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                          Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ),
                  );
                },
                ): SizedBox(),
          );
        }
      ),
    );
  }
}
