import 'package:flutter/material.dart';
import 'package:tp_four/Pages/AddContactPage.dart';

class MyFloatingActionButton extends StatelessWidget {

  final icon;

  const MyFloatingActionButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        /* ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Bouton cliqué", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              backgroundColor: Colors.black,
            )
        ); */
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddContactPage())
        );
      },
      child: Icon(this.icon, color: Colors.white,),
      backgroundColor: Colors.blue,
      tooltip: "Bouton Flottant",
    );
  }
}
