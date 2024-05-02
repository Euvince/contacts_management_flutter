import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tp_four/Models/Contact.dart';
import 'package:tp_four/Pages/ContactDetailsPage.dart';
import 'package:tp_four/Pages/UpdateContactPage.dart';
import 'package:tp_four/Widgets/MyAppBar.dart';
import 'package:tp_four/Widgets/MyFloatingActionButton.dart';

class ContactsListPage extends StatefulWidget {
  const ContactsListPage({super.key});

  @override
  State<ContactsListPage> createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {

  final ContactProvider _contactProvider = new ContactProvider();

  bool _stateLoading = true;
  bool _deletingLoading = false;

  List<Contact> _contacts = [];

  void _loadContacts () async {
    _contacts = await _contactProvider.getContacts();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    /* Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _stateLoading = false;
      });
    }); */
    _loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Liste des contacts",),
      floatingActionButton: MyFloatingActionButton(icon: Icons.add,),
      body: _contacts.length > 0
        ? _deletingLoading
          ? Center(
              child: CircularProgressIndicator(strokeWidth: 5, color: Colors.blue,),
          )
          : ListView.builder(
          itemCount: _contacts.length,
          itemBuilder: (context, int index) {

            final _contact = _contacts[index];
            final int? _id = _contact.id as int;
            final String fullname = _contact.fullname.toString();
            final String phoneNumber = _contact.phoneNumber.toString();

            return Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text("$fullname"),
                      subtitle: Text("$phoneNumber"),
                      iconColor: Colors.blue,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ContactDetailsPage(id: _id!,))
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ContactDetailsPage(id: _id!,))
                              );
                            },
                            child: Text("Détails", style: TextStyle(color: Colors.green),)
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => UpdateContactPage(contact: _contact,))
                              );
                            },
                            child: Text("Modifier", style: TextStyle(color: Colors.blue),)
                        ),
                        TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Suppression d'un contact", style: TextStyle(fontFamily: "Poppins"),),
                                      content: Text("Êtes-vous sûr de vouloir supprimer ce contact ?", style: TextStyle(fontFamily: "Poppins"),),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Annuler", style: TextStyle(color: Colors.blue),)
                                        ),
                                        TextButton(
                                            onPressed: () async {
                                              await _contactProvider.deleteContact(_id!);
                                              setState(() {
                                                _deletingLoading = true;
                                              });
                                              Future.delayed(const Duration(seconds : 3), () {
                                                setState(() {
                                                  _deletingLoading = false;
                                                  Fluttertoast.showToast(
                                                      msg: "Contact supprimé avec succès",
                                                      toastLength: Toast.LENGTH_LONG,
                                                      gravity: ToastGravity.BOTTOM,
                                                      textColor: Colors.white,
                                                      backgroundColor: Colors.blue
                                                  );
                                                });
                                              });
                                              _loadContacts();
                                              Navigator.pop(context);
                                            },
                                            child: Text("Supprimer", style: TextStyle(color: Colors.red),)
                                        )
                                      ],
                                    );
                                  }
                              );
                            },
                            child: Text("Supprimer", style: TextStyle(color: Colors.red),)
                        ),
                        SizedBox(width: 8,),
                      ],
                    )
                  ],
                )
            );
          }
      )
        : Center(
            child: Text("Aucun contact en base de données", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),)
          )
    );
  }
}
