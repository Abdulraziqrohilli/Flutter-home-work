import 'package:flutter/foundation.dart';
import 'package:hurriyat/models/details/Details.dart';
import 'package:hurriyat/sqflite/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final databaseName = "hashimi.db";

  //Tables and queries as a variable
  String news = '''
      CREATE TABLE news (
        
        newsId integer primary key autoincrement, title Text, description Text,userId INTEGER,createdAt TEXT,user TEXT,source TEXT,  image TEXT, languageId integer,views TEXT,category TEXT,
        FOREIGN KEY (userId) REFERENCES users (userId) ON DELETE CASCADE
      )
    ''';
  String userTable =
      "create table users (userId integer primary key autoincrement, usrName Text)";
  String userData = "insert into users (userId, usrName) values(1,'flutter')";
  String newsData =
      "insert into news (newsId, title,description,userId,createdAt,user,source,image,languageId,views,category) values(988979879,'flutter title','flutter description',1,'flutter createion data','flutter user','flutter source','assets/logos/logo.png',1,'123','Hase')";
  // String news =
  //     "create table news (newsId integer primary key autoincrement, title Text, description Text,createdAt TEXT,user TEXT,source TEXT,  image TEXT, languageId integer,views TEXT,
  //       FOREIGN KEY (userId) REFERENCES users (usrId) ON DELETE CASCADE

  //     )";

  //Future init method to create a database, user table and user default data
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      //auto execute the user table into the database
      await db.execute(userTable);
      await db.execute(news);

      //auto execute the user default data in the table
      await db.rawQuery(userData);
      await db.rawQuery(newsData);
    });
  }

  //Authentication Method for login
  // Future <bool> authentication(Details users)async{
  //   final Database db = await initDB();
  //   var result = await db.rawQuery("select * from users where usrName = '${users.usrName}' and usrPassword = '${users.usrPassword}' ");
  //   if(result.isNotEmpty){

  //     return true;
  //   }else{
  //     return false;
  //   }
  // }

  //Method for creating an account
  // Future <int> createUsers(Users users) async {
  //   final Database db = await initDB();
  //   return db.insert('users', users.toMap());
  // }

  //Method to show users
  // Future <List<Users>> getUsers () async{
  //   final Database db = await initDB();
  //   final List<Map<String, Object?>>  queryResult = await db.query('users',orderBy: 'usrId');
  //   return queryResult.map((e) => Users.fromMap(e)).toList();
  // }

  // Delete a user
  // Future<void> deleteUser() async {
  //   final db = await initDB();
  //   try {
  //     await db.delete("users", where: "usrId = ?", whereArgs: [1]);
  //   } catch (err) {
  //     if (kDebugMode){
  //       print("deleting failed: $err");
  //     }
  //   }
  // }

  //Update user
  // Future <int> updateUser(Users users)async{
  //   final Database db = await initDB();
  //   var result = await db.update('users', users.toMap(), where: 'usrId = ?', whereArgs: [users.usrId]);
  //   return result;
  // }

  //Total users count
  // Future <int?> totalUsers() async {
  //   final Database db = await initDB();
  //   final count = Sqflite.firstIntValue(await db.rawQuery("select count(*) from users"));
  //   return count;
  // }

  //Notes ----------------------------------------------------------------------

  //Create a new note
  Future<int> createNote(Detailss note) async {
    final Database db = await initDB();
    return db.insert('news', note.toMap());
  }

  Future<int?> totalUsers() async {
    final Database db = await initDB();
    final count =
        Sqflite.firstIntValue(await db.rawQuery("select count(*) from users"));
    return count;
  }

  Future<int?> newsId() async {
    final Database db = await initDB();
    final count =
        Sqflite.firstIntValue(await db.rawQuery("select newsId from news"));
    return count;
  }

  Future<List<Map<String, dynamic>>> getAllIds() async {
    Database db = await initDB();
    return await db.query('news', columns: ['newsId'], orderBy: 'newsId');
  }

  //Show incomplete notes with 1 status
  Future<List<Detailss>> getNotes() async {
    final Database db = await initDB();
    final List<Map<String, Object?>> queryResult = await db.query(
      'news',
      orderBy: 'newsId',
    );
    return queryResult.map((e) => Detailss.fromMap(e)).toList();
  }

  //show completed notes with 0 status
  // Future<List<Detailss>> getCompletedNotes(String newsId ) async {
  //   final Database db = await initDB();
  //   final List<Map<String, Object?>> queryResult =
  //       await db.query('news', orderBy: 'newsId', where: newsId);
  //   return queryResult.map((e) => Detailss.fromMap(e)).toList();
  // }
  Future<List<Detailss>> getCompletedNotes() async {
    final Database db = await initDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('news', orderBy: 'newsId', where: 'userId= 1');
    return queryResult.map((e) => Detailss.fromMap(e)).toList();
  }

  Future<int?> totalNotes() async {
    final Database db = await initDB();
    final count = Sqflite.firstIntValue(
        await db.rawQuery("select count(*) from news order by newsId"));
    return count;
  }
  //show pending notes with 0 status
  // Future <List<>> getPendingNotes () async{
  //   final Database db = await initDB();
  //   final List<Map<String, Object?>>  queryResult = await db.query('notes',orderBy: 'noteId',where: 'noteStatus = 1');
  //   return queryResult.map((e) => Notes.fromMap(e)).toList();
  // }

  // Delete
  Future<void> deleteNote(String id) async {
    final db = await initDB();
    try {
      await db.delete("news", where: "newsId = ?", whereArgs: [id]);
    } catch (err) {
      if (kDebugMode) {
        print("deleting failed: $err");
      }
    }
  }

  //Update note
  // Future <int> updateNotes(Notes note)async{
  //   final Database db = await initDB();
  //   var result = await db.update('notes', note.toMap(), where: 'noteId = ?', whereArgs: [note.noteId]);
  //   return result;
  // }

  //Update note Status to complete
  // Future <int> setNoteStatus(int? id)async{
  //   final Database db = await initDB();
  //   final res = await db.rawUpdate('UPDATE notes SET noteStatus = 0 WHERE noteId = ?', [id]);
  //   return res;
  // }

  //Total note count
}
