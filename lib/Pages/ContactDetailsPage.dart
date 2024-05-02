import 'package:flutter/material.dart';
import 'package:tp_four/Models/Contact.dart';
import 'package:tp_four/Pages/ContactListPage.dart';
import 'package:tp_four/Widgets/MyAppBar.dart';

class ContactDetailsPage extends StatefulWidget {

  final int? id;

  const ContactDetailsPage({super.key, required this.id});

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {

  final ContactProvider _contactProvider = new ContactProvider();

  String? _fullname = "";
  String? _phoneNumber = "";

  Contact? _contact = new Contact();

  void _loadOneContact () async {
    _contact = await _contactProvider.getContact(widget.id);
    _fullname = _contact?.fullname.toString();
    _phoneNumber = _contact?.phoneNumber.toString();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _loadOneContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Détails d'un contact",),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: "Nom et prénoms : ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: _fullname ?? "Non défini", style: TextStyle(fontWeight: FontWeight.bold)),
                    ]
                )
            ),
            RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: "Numéro de téléphone : ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: _phoneNumber ?? "Non défini", style: TextStyle(fontWeight: FontWeight.bold)),
                    ]
                )
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ContactsListPage())
                );
              },
              child: Text("Page précédente", style: TextStyle(color: Colors.white),),
              style: ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.all(12)),
                  backgroundColor: MaterialStatePropertyAll(Colors.blue)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
