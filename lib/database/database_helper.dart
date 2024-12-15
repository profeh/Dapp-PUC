import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


// Modelo do contato
class Contact {
  final int? id;
  final String name;
  final String phone;
  final String email;

  Contact({this.id, required this.name, required this.phone, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'] as int?,
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
    );
  }
}

// Helper para o banco de dados
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // Getter para a base de dados
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('contacts.db');
    return _database!;
  }

  // Inicialização do banco de dados
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Criação das tabelas no banco de dados
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contacts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        email TEXT NOT NULL
      )
    ''');
  }

  // CRUD Operations
  Future<int> insert(Contact contact) async {
  try {
    final db = await instance.database;
    return await db.insert('contacts', contact.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  } catch (e) {
    print('Error inserting contact: $e');
    return -1; // ou outro valor indicando falha
  }
}

  Future<List<Contact>> getContacts() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('contacts');
    return List.generate(maps.length, (i) {
      return Contact.fromMap(maps[i]);
  });
}

  Future<int> update(Contact contact) async {
    final db = await instance.database;
    return await db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}