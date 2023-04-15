import 'package:get/get.dart';
import 'package:task_app/db/db_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class TaskController extends GetxController{

  Database? database = DbHelper().database;

 //Database? database = DbHelper().

  @override
  void onReady(){
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<void> addTask({Task? task})async {

    await DbHelper.insert(task!);
  }

  void getTasks()async{
    List<Map<String,dynamic>> tasks =  database?.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());

  }



}