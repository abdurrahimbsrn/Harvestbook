import 'package:sqflite/sqflite.dart';
import '../Models/Tarla.dart';
import 'hasatDefter_dataBase.dart';


class TarlaDAO {
  //Future<List> getTarla() async {

    //Database db= await this.db;

    /*
    final db = await DatabaseHelper().database;

    // Tarla tablosundaki tüm verileri ve her tarlanın toplam masrafını çek
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT Tarla.*, COALESCE(SUM(Masraf.Tutar), 0) AS toplamMasraf
      FROM Tarla
      LEFT JOIN Masraf ON Tarla.tarlaID = Masraf.TarlaID
      GROUP BY Tarla.tarlaID
    ''');

    // Map verisini Tarla nesnesine çevirip liste oluştur
    return List.generate(maps.length, (i) {
      return Tarla.fromMap(maps[i]);
    });

     */
  }

  Future<int> insertTarla(Tarla tarla) async {
    final db = await DatabaseHelper().database;

    // Tarla nesnesini veritabanına ekle
    var result = await db.insert(
      'Tarla',
      tarla.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<void> updateTarla(Tarla tarla) async {
    final db = await DatabaseHelper().database;

    // Tarla nesnesini güncelle
    await db.update(
      'Tarla',
      tarla.toMap(),
      where: 'TarlaID = ?',
      whereArgs: [tarla.tarlaID],
    );
  }

