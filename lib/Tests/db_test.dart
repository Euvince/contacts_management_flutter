import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await openDatabase(
    join(await getDatabasesPath(), "contacts.db"),
    onCreate: (Database db, int version) {
      return db.execute(
          "CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT, fullname VARCHAR(255), phone_number VARCHAR(255))"
      );
    },
    version: 1
  );

  Future<List<Contact>> getContacts () async {
    final db = await database;
    List<Map<String, dynamic>> contacts = await db.query(
      "contacts",
      columns: ['id', 'fullname', 'phone_number'],
    );
    return List.generate(contacts.length, (index) {
      return Contact(
          id: contacts[index]['id'] as int,
          fullname: contacts[index]['fullname'] as String,
          phoneNumber: contacts[index]['phone_number'] as String
      );
    });
  }

  Future<void> getContact (Contact contact) async {
    final db = await database;
    await db.query(
        "contacts",
        columns: ['id', 'fullname', 'phone_number'],
        where: "id = ?",
        whereArgs: [contact.id]
    );
  }

  Future<void> insertContact (Contact contact) async {
    final db = await database;
    await db.insert("contacts", contact.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateContact (Contact contact) async {
    final db = await database;
    await db.update("contacts", contact.toMap(), where: "id = ?", whereArgs: [contact.id]);
  }

  Future<void> deleteContact (Contact contact) async {
    final db = await database;
    await db.delete("contacts", where: "id = ?", whereArgs: [contact.id]);
  }

}

class Contact {
  final int id;
  final String fullname;
  final String phoneNumber;

  const Contact({
      required this.id,
      required this.fullname,
      required this.phoneNumber
  });

  Map<String, dynamic> toMap () {
    return {
      'id' : this.id,
      'fullname' : this.fullname,
      'phoneNumber' : this.phoneNumber,
    };
  }

  String toString () {
    return '{Id : $id, Nom et prénoms : $fullname, Numéro de téléphone : $phoneNumber}';
  }

}