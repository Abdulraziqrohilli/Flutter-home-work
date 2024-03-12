// import 'dart:async';
// import 'package:path/path.dart';
// import 'package:sembast/sembast.dart';
// import 'package:sembast/sembast_io.dart';

// class DatabaseHelper {
//  late Database _database;

//   Future<void> openDatabase() async {
//     final String dbPath = join(await getDatabasesPath(), 'my_database.db');
//     _database = await databaseFactoryIo.openDatabase(dbPath);
//   }

//   Future<void> insertData(String storeName, Map<String, dynamic> data) async {
//     final store = intMapStoreFactory.store(storeName);
//     await store.add(_database, data);
//   }

//   Future<List<Map<String, dynamic>>> getAllData(String storeName) async {
//     final store = intMapStoreFactory.store(storeName);
//     final finder = Finder(sortOrders: [SortOrder('timestamp', false)]);
//     final records = await store.find(_database, finder: finder);
//     return records.map((record) => record.value).toList();
//   }

//   Future<void> deleteData(String storeName, int recordId) async {
//     final store = intMapStoreFactory.store(storeName);
//     await store.record(recordId).delete(_database);
//   }
// }
