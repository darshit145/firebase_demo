import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:firebase/screen/sqflite_package/subject.dart';
class DatabaseServices {
  static final DatabaseServices _databaseServices =
      DatabaseServices._instances();
  DatabaseServices._instances();
  factory DatabaseServices() {
    return _databaseServices;
  }
  static Database? _database;

  Future<Database> get dataBase async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDataBase();

    return _database!;
  }

  Future<Database> _initDataBase() async {
    final dataBase = await getDatabasesPath();
    final path = join(dataBase, "my_data.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        db.execute('''
            CREATE TABLE my_table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            age INTEGER
          )
          ''');
      },
    );
  }
  //FOR inserting the records
  Future<int> insertRecords(Map<String, dynamic> record) async {
    final db = await dataBase;
    return await db.insert("my_table", record);
  }

  //For fatching all the records
  Future<List<Map<String, dynamic>>> fatchRecords() async {
    final db = await dataBase;
    return await db.query("my_table");
  }
  //for updating a single row record
  Future<int> updateRecord(Subject subject) async {
    final db = await dataBase;
     return await db.update(
      'my_table',
      subject.toMap(),
      where: 'id = ?',
      whereArgs: [subject.id],
    );
  }
  //for deleting the whole row in database
  Future<int> deleteRecord(int id,Subject sub) async {
    final db = await dataBase;
    return await db.delete("my_table", where: 'id = ?', whereArgs: [sub.id]);
  }
  Future<List<Map<String,dynamic>>?>  selectBaseOncondition(String name)async{
    final db=await dataBase;
    final List<Map<String,dynamic>> record= await db.query(
      'my_table',
      where: 'name = ?',
      whereArgs: [name],
    );
    if(record.isEmpty){
      return null;
    }
    else{
      return record;
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllBelowAge(int ageLimit) async {
    final db = await dataBase;
    return await db.query(
      'my_table',
      where: 'age < ?',
      whereArgs: [ageLimit],
    );
  }

  Future<List<Map<String,dynamic>>?> getreverseId(int age)async{
    final db=await dataBase;
    return await db.query(
      "my_table",
      where: 'age < ?',
      whereArgs: [age],
      orderBy: 'age DESC'
    );
  }




}