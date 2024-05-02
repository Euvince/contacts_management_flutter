import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tp_four/Models/Contact.dart';
import 'package:tp_four/Widgets/MyAppBar.dart';
import 'package:tp_four/Widgets/MyDrawer.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {

  final _formKey = new GlobalKey<FormState>();

  final _fullNameController = new TextEditingController();
  final _phoneNumberController = new TextEditingController();

  final ContactProvider _contactProvider = new ContactProvider();

  bool _loading = false;

  @override
  void dispose() {
    super.dispose();

    _fullNameController.dispose();
    _phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Ajouter un contact",),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Informations du contact",
                    style: TextStyle(
                      color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 22, fontFamily: "Poppins"
                    ),
                  )
                ],
              ),
              Image.asset("assets/images/ori_logo.png"),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      label: Text("Nom et prénoms"),
                      hintText: "Nom et prénoms*",
                      icon: Icon(Icons.person)
                  ),
                  controller: _fullNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vous devez remplir ce champ";
                    } return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      label: Text("Numéro de téléphone"),
                      hintText: "Numéro de téléphone*",
                      icon: Icon(Icons.phone)
                  ),
                  controller: _phoneNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vous devez remplir ce champ";
                    } return null;
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Contact _contact = new Contact();
                        _contact.fullname = _fullNameController.text;
                        _contact.phoneNumber = _phoneNumberController.text;
                        await _contactProvider.insertContact(_contact);
                        FocusScope.of(context).requestFocus(FocusNode());
                        setState(() {
                          _loading = true;
                        });
                        Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            _loading = false;
                            _fullNameController.text = "";
                            _phoneNumberController.text = "";
                            Fluttertoast.showToast(
                                msg: "Contact enrégistré avec succès",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                textColor: Colors.white,
                                backgroundColor: Colors.blue
                            );
                          });
                        });
                      }
                    },
                    child: Text("Enrégistrer", style: TextStyle(color: Colors.white),),
                    style: ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.all(12)),
                        backgroundColor: MaterialStatePropertyAll(Colors.blue)
                    ),
                  ),
                  SizedBox(width: 8.0,),
                  _loading ? CircularProgressIndicator(
                    strokeWidth: 5,
                    color: Colors.blue,
                  ) : SizedBox()
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
