import 'package:flutter/material.dart';
import 'package:tp_four/Pages/AddContactPage.dart';
import 'package:tp_four/Pages/ContactListPage.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.blue
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Text("CO", style: TextStyle(fontSize: 70),),
                      radius: 50,
                    ),
                    Text("Gestion des contacts", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ],
                )
            ),
            ListTile(
              title: Text("Ajouter un contact", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
              leading: Icon(Icons.add),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddContactPage())
                );
              },
            ),
            ListTile(
              title: Text("Liste des contacts", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
              leading: Icon(Icons.contacts),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ContactsListPage())
                );
              },
            ),
            ListTile(
              title: Text("Paramètres", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
              leading: Icon(Icons.settings),
              onTap: () {},
            )
          ],
        )
    );
  }
}
