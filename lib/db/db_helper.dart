import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DbHelper{
  static Database? database;
  static final int _version = 1;
  static final String _tableName  = 'tasks';



  static Future<void> initDb()async{
    if(database != null){
      return;
    }
    try{
      String _path = await getDatabasesPath() + 'tasks.db';
      database = await openDatabase(
        _path,
        version: _version,
        onCreate: (db,version){
          print('Creating a new one');
          return db.execute(
            'CREATE TABLE $_tableName('
                'id integer primary key autoincrement,'
                'title string,note text , data string,'
                'startTime String , endTime String,'
                 'color integer,'
                 'isCompleted integer)',




          );
        }
      );
    }catch(e){
      print(e);
    }
  }

  static Future<int> insert(Task task)async{
    print('insert function called');
    return await database?.insert(_tableName,task.toJson())??1;

  }
}