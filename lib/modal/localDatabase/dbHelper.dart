// import 'dart:io';
//
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
//
// class DatabaseHelper {
//
//   static final _databaseName = "water_reminder_app.db";
//   static final _databaseVersion = 1;
//
//   static final tableWaterReminderList = 'water_reminder_list';
//
//   static final columnWaterReminderId = '_id';
//   static final columnWaterReminderAlarmTime = 'alarmTime';
//   static final columnWaterReminderAlarmCount = 'count';
//
//   // make this a singleton class
//   DatabaseHelper._privateConstructor();
//
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
//
//   // only have a single app-wide reference to the database
//   static Database _database;
//
//   Future<Database> get database async {
//     if (_database != null) return _database;
//     // lazily instantiate the db the first time it is accessed
//     _database = await _initDatabase();
//     return _database;
//   }
//
//   // this opens the database (and creates it if it doesn't exist)
//   _initDatabase() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, _databaseName);
//     return await openDatabase(path,
//       version: _databaseVersion,
//       // onCreate: _onCreate
//     );
//   }
//
//   // SQL code to create the database table
//   Future createTable(String query) async {
//     Database db = await instance.database;
//     await db.execute(query);
//     // '''
//     //   CREATE TABLE $tableName (
//     //     $columnWaterReminderId INTEGER PRIMARY KEY,
//     //     $columnWaterReminderAlarmTime TEXT NOT NULL,
//     //     $columnWaterReminderAlarmCount TEXT NOT NULL
//     //   )
//     //   '''
//
//   }
//
//   // Helper methods
//
//   // Inserts a row in the database where each key in the Map is a column name
//   // and the value is the column value. The return value is the id of the
//   // inserted row.
//   Future<int> insert(Map<String,String>row,String tableName) async {
//     Database db = await instance.database;
//     //return await db.insert(tableName, row);
//     return await db.insert(tableName,row);
//   }
//
// ////////////
//   // All of the rows are returned as a list of maps, where each map is
//   // a key-value list of columns.
//   // Future<List<Map<String, String>>> queryAllRows() async {
//   //   Database db = await instance.database;
//   //   return await db.query(tableWaterReminderList);
//   // }
// ///////////
//
//   // All of the methods (insert, query, update, delete) can also be done using
//   // raw SQL commands. This method uses a raw query to give the row count.
//   Future<int> queryRowCount(String tableName) async {
//     Database db = await instance.database;
//     return Sqflite.firstIntValue(
//         await db.rawQuery('SELECT COUNT(*) FROM $tableName'));
//   }
//
//   // We are assuming here that the id column in the map is set. The other
//   // column values will be used to update the row.
//   Future<int> update(Map row, String tableName, int id) async {
//     Database db = await instance.database;
//     // int id = row[columnId];
//     return await db.update(tableName, row, where: '$id = ?', whereArgs: [id]);
//   }
//
//   // Deletes the row specified by the id. The number of affected rows is
//   // returned. This should be 1 as long as the row exists.
//   Future<int> delete(int id, String tableName) async {
//     Database db = await instance.database;
//     return await db.delete(tableName, where: '$id = ?', whereArgs: [id]);
//   }
//
//   tableExist(String tableName) async {
//     Database db = await instance.database;
//     var res = await db.rawQuery(
//         "select * from Sqlite_master where type = 'table' and name = '$tableName'");
//     return res != null && res.length > 0;
//   }
// }
//////////
// final dbHelper = DatabaseHelper.instance;
// @override
// void initState() {
//   super.initState();
//   _dataBaseService();
// }
//
// _dataBaseService() async {
//   _openDataBase();
//   // _tableExist();
//   //  if(isTableExist) {
//   //    _createTable();
//   //  }
//   _findLength();
// }
// _openDataBase()async{
//   try {
//     await dbHelper.database;
//   } catch (e) {
//     print("Exception : in creating database is :$e");
//   }
// }
// _tableExist()async{
//   try {
//     setState(() {
//       isTableExist=dbHelper.tableExist("${DatabaseHelper.tableWaterReminderList}");
//     });
//   } catch (e) {
//     print("Exception : in check table exist in database is :$e");
//   }
// }
// _createTable()async{
//   try {
//     await dbHelper.createTable('''
//     CREATE TABLE ${DatabaseHelper.tableWaterReminderList}
//     (
//       ${DatabaseHelper.columnWaterReminderId} INTEGER PRIMARY KEY AUTOINCREMENT,
//       ${DatabaseHelper.columnWaterReminderAlarmTime} TEXT NOT NULL,
//       ${DatabaseHelper.columnWaterReminderAlarmCount} TEXT NOT NULL
//     )
//     ''');
//   } catch (e) {
//     print("Exception : in creating table is :$e");
//   }
//
// }
// _findLength() async {
//   try {
//     var count = await dbHelper
//         .queryRowCount("${DatabaseHelper.tableWaterReminderList}");
//     setState(() {
//       reminderListLength = count;
//     });
//     print("total count of rows is ::$count");
//   } catch (e) {
//     print("Exception : in finding length table is :$e");
//   }
// }
//
// _insertData() async {
//   // row to insert
//   //String query = "INSERT INTO ${DatabaseHelper.tableWaterReminderList} (${DatabaseHelper.columnWaterReminderAlarmTime},${DatabaseHelper.columnWaterReminderAlarmCount}) VALUES('40,'20')";
//   Map<String,String>row={
//     DatabaseHelper.columnWaterReminderAlarmTime:"20",
//     DatabaseHelper.columnWaterReminderAlarmCount:"40"
//   };
//   try {
//     final id = await dbHelper.insert(row,DatabaseHelper.tableWaterReminderList);
//     print('inserted row id: $id');
//   } catch (e) {
//     print("Exception : in inserting data in table is table is :$e");
//   }
// }