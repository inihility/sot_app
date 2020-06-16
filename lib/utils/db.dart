import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:typed_data';
import '../models/island.dart';

class Db{
  Db._privateConstructor();

  static final Db instance = Db._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // Construct a file path to copy database to
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "working_sot.db");
    await deleteDatabase(path);
    // Only copy if the database doesn't exist
    // if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound){
    // Load database from asset and copy
    ByteData data = await rootBundle.load(join('assets', 'stored_sot.db'));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // Save copied asset to documents
    await new File(path).writeAsBytes(bytes);
    // }
    _database = await openDatabase(path);
    return _database;
  }

  getIslandNameById(String id) async{
    final db = await database;
    var res = await db.query("island", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? res.first["name"] : Null;
  }

  listIslands() async{
    final db = await database;
    List<Map> list = await db.rawQuery("SELECT * FROM island");
    print("Listing islands3 " + list.length.toString());
    List<Island> islandList = new List();
    list.forEach((element) {
      islandList.add(Island.fromMap(element));
    });
    islandList.forEach((element) {
      print(element.name);
    });
  }

  getIslands() async{
    final db = await database;
    List<Map> list = await db.rawQuery("SELECT * FROM island");
    List<Island> islandList = new List();
    list.forEach((element) {
      islandList.add(Island.fromMap(element));
    });
    return islandList;
  }

  listTables() async{
    final db = await database;
    final list = await db.rawQuery("SELECT * FROM sqlite_master");
    print(list);
  }
}