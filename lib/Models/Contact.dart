import 'package:sqflite/sqflite.dart';

final String columnId = "id";
final String columnFullname = "fullname";
final String columnPhoneNumber = "phone_number";
final String tableName = "contacts";

class Contact {
  int? id;
  late String fullname;
  late String phoneNumber;

  Map<String, Object?> toMap () {
    var map = <String, Object?>{
      columnFullname : fullname,
      columnPhoneNumber : phoneNumber,
    };
    if (id != null) map[columnId] = id;
    return map;
  }

  Contact();

  Contact.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    fullname = map[columnFullname];
    phoneNumber = map[columnPhoneNumber];
  }

}

class ContactProvider {
  Database? database;

  Future<void> open () async {
    var databasePath = await getDatabasesPath();
    final String path = databasePath + "contacts.db";
    database = await openDatabase(
      path,
      onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnFullname VARCHAR(255), $columnPhoneNumber VARCHAR(255))"
        );
      },
      version: 1,
    );
  }

  Future<void> close () async => await database!.close();

  Future<List<Contact>> getContacts () async {
    List<Contact> contacts = [];
    await open();
    List<Map<String, dynamic>> maps = await database!.query(
      tableName,
      columns: [columnId, columnFullname, columnPhoneNumber],
    );
    await close();
    maps.forEach((element) {
      contacts.add(Contact.fromMap(element));
    });
    return contacts;
  }

  Future<Contact?> getContact (int? id) async {
    await open();
    List<Map<String, dynamic>> maps = await database!.query(
      tableName,
      columns: [columnId, columnFullname, columnPhoneNumber],
      where: "id = ?",
      whereArgs: [id]
    );
    await close();
    if (maps.length > 0) return Contact.fromMap(maps.first);
    return null;
  }

  Future<Contact> insertContact (Contact contact) async {
    await open();
    contact.id = await database!.insert(
      tableName,
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await close();
    return contact;
  }

  Future<int> updateContact (Contact contact) async {
    await open();
    int result = await database!.update(
      tableName,
      contact.toMap(),
      where: "id = ?",
      whereArgs: [contact.id]
    );
    await close();
    return result;
  }

  Future<int> deleteContact (int id) async {
    await open();
    int result = await database!.delete(
        tableName,
        where: "id = ?",
        whereArgs: [id]
    );
    await close();
    return result;
  }

}