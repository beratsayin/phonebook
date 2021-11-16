import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'contactclass.dart';

//Database for contacts. Performs CRUD(Create, Read, Update, Delete) operations.
class ContactDatabase {
  static final ContactDatabase instance = ContactDatabase._init();

  static Database? _database;

  ContactDatabase._init();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDB('proslidable.db');
    return _database!;
  }

  //initializes database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  //creates database
  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    //creates new table
    await db.execute('''
CREATE TABLE $tableContacts (
  ${ContactFields.id} $idType,
  ${ContactFields.name} $textType,
  ${ContactFields.no} $textType
  )
''');
  }

  //adds a new contact to database
  Future<Contact> create(Contact contact) async {
    //defines database
    final db = await instance.database;

    //creates a unique id and assign it to the object via copy method
    final id = await db.insert(tableContacts, contact.toJson());
    return contact.copy(id: id);
  }

  //reads chosen contact from database
  Future<Contact> readContact(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableContacts,//table that will be queried
      columns: ContactFields.values,//columns that will be retrieved from table
      where: '${ContactFields.id} = ?',//defines which object will be read
      whereArgs: [id],//via this structure we prevent SQL injection attacks
    );

    if (maps.isNotEmpty) {
      return Contact. fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  //reads all contacts from database
  Future<List<Contact>> readAllContacts() async {
    final db = await instance.database;

    //orders elements by their names from A to Z
    final orderBy = '${ContactFields.name} COLLATE NOCASE ASC';
    final result = await db.query(tableContacts, orderBy: orderBy);

    return result.map((json) => Contact.fromJson(json)).toList();
  }

  //updates a contact in the database
  Future<int> update(Contact contact) async {
    final db = await instance.database;

    return db.update(
      tableContacts,
      contact.toJson(),
      where: '${ContactFields.id} = ?',
      whereArgs: [contact.id],
    );
  }

  //deletes a contact from database
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableContacts,
      where: '${ContactFields.id} = ?',
      whereArgs: [id],
    );
  }

  //closes database
  Future close() async {
    final db = await instance.database;

    db.close();
  }
}