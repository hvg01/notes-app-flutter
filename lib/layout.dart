import 'package:flutter/material.dart';
import 'package:notes_app/pages/noteslist.dart';
import 'package:notes_app/pages/addnote.dart';
import 'package:notes_app/pages/trash.dart';

class Layout extends StatefulWidget {
  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int selectedIndex = 0;
  List <Widget> widgetOptions = <Widget>[
    NotesList(),
    Trash(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey[600],
        selectedItemColor: Colors.blue[900],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restore_from_trash),
           label: 'Trash',
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>AddNote()));
        },
        tooltip: 'Add Note',
        child: new Icon(Icons.add),
      ),

      body: widgetOptions.elementAt(selectedIndex),
    );
  }
}
