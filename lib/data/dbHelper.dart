import 'package:HasatDefteri/Models/Masraf.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../Models/Tarla.dart';

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

  Future<List<Tarla>> getTarlas() async {
    Database db = await this.database;
    try {
      // Veritabanından gelen veriler
      List<Map<String, dynamic>> maps = await db.query('Tarla');
      print('Query result: $maps'); // Sorgu sonucunu yazdır

      // Gelen verileri Tarla nesnelerine dönüştür
      List<Tarla> tarlaList = [];
      for (var map in maps) {
        int tarlaID = map['TarlaID'] ?? 0;
        String tarlaAdi = map['TarlaAdi'] ?? 'Bilinmeyen Tarla';
        String ekiliMahsul = map['EkiliMahsul'] ?? 'Bilinmeyen Mahsul';
        int donum = map['Donum'] ?? 0;
        String resimAdresi = map['ResimAdresi'] ?? '';
        DateTime eklemeTarihi = _parseEklemeTarihi(map['EklemeTarihi']);
        double toplamMasraf = (map['ToplamMasraf'] != null) ? map['ToplamMasraf'].toDouble() : 0.0;

        // Tarla nesnesi oluştur
        Tarla tarla = Tarla.withID(
          tarlaID: tarlaID,
          tarlaAdi: tarlaAdi,
          ekiliMahsul: ekiliMahsul,
          donum: donum,
          resimAdresi: resimAdresi,
          eklemeTarihi: eklemeTarihi.toString(),
          toplamMasraf: toplamMasraf,
        );

        // Listeye ekle
        tarlaList.add(tarla);
      }

      return tarlaList;
    } catch (e) {
      print('Error fetching data: $e'); // Hata mesajını yazdır
      return [];
    }
  }

// Tarih dönüşüm fonksiyonu
  DateTime _parseEklemeTarihi(dynamic dateStr) {
    if (dateStr == null || dateStr.toString().isEmpty) {
      return DateTime.now();
    }
    try {
      // Tarihi doğru bir şekilde parse edin
      return DateFormat('dd-MM-yyyy').parse(dateStr.toString());
    } catch (e) {
      print('Tarih dönüştürme hatası: $e');
      return DateTime.now();
    }
  }

  Future<int> insertTarla(Tarla tarla) async {
    final db = await this.database;

    // Tarla nesnesini veritabanına ekle
    var result = await db.insert(
      'Tarla',
      tarla.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<void> deleteTarla(int id) async {
    final db = await DatabaseHelper().database;

    // Tarla nesnesini sil
    await db.delete(
      'Tarla',
      where: 'TarlaID = ?',
      whereArgs: [id],
    );
  }

  // Masraf db

  Future<List<Masraf>> getMasrafs() async {
    Database db = await this.database;
    try {
      // Veritabanından gelen veriler
      List<Map<String, dynamic>> maps = await db.query('Masraf ');
      print('Query result: $maps'); // Sorgu sonucunu yazdır

      // Gelen verileri Masraf nesnelerine dönüştür
      List<Masraf> masrafList = [];
      for (var map in maps) {
        int masrafID = map['MasrafID'] ?? 0;
        String masrafAdi = map['MasrafAdi'] ?? 'Bilinmeyen Tarla';
        String aciklama = map['Aciklama'] ?? '';
        DateTime eklemeTarihi = _parseEklemeTarihi(map['EklemeTarihi']);
        double tutar = (map['Tutar'] != null) ? map['Tutar'].toDouble() : 0.0;

        // Tarla nesnesi oluştur
        Masraf masraf = Masraf.withID(
            masrafID: masrafID,
            masrafAdi: masrafAdi,
            aciklama: aciklama,
            eklemeTarihi: eklemeTarihi.toString(),
            ucret: tutar,
        );


        // Listeye ekle
        masrafList.add(masraf);
      }

      return masrafList;
    } catch (e) {
      print('Error fetching data: $e'); // Hata mesajını yazdır
      return [];
    }
  }

  Future<int> insertMasraf(Masraf masraf) async {
    final db = await this.database;

    // Tarla nesnesini veritabanına ekle
    var result = await db.insert(
      'Masraf',
      masraf.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }
}
