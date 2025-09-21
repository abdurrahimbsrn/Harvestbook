import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'hasat_defteri.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Tarla (
      TarlaID INTEGER PRIMARY KEY AUTOINCREMENT,
      TarlaAdi TEXT,
      EkiliMahsul TEXT,
      Donum INTEGER,
      ResimAdresi TEXT,
      EklemeTarihi DATETIME DEFAULT CURRENT_TIMESTAMP,
      ToplamMasraf REAL DEFAULT 0.0
      )
    ''');

    await db.execute('''
     CREATE TABLE Masraf (
     MasrafID INTEGER PRIMARY KEY AUTOINCREMENT,
     TarlaID INTEGER,
     Tutar REAL,
     MasrafAdi TEXT,
     Aciklama TEXT,
     EklemeTarihi DATETIME DEFAULT CURRENT_TIMESTAMP,
     FOREIGN KEY (TarlaID) REFERENCES Tarla(TarlaID)
    )
    ''');
  }
}
