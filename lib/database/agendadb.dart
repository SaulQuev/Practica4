import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pmsn2023/models/career_model.dart';
import 'package:pmsn2023/models/popular_model.dart';
import 'package:pmsn2023/models/task_model.dart';
import 'package:pmsn2023/models/teacher_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Agenda {
  static const db_name = 'Agendadb';
  static const versiondb = 1;

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    return _database = await _initDatabase();
  }

  Future<Database?> _initDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String pathdb = join(dir.path, db_name);
    return openDatabase(pathdb, version: versiondb, onCreate: _createTables);
  }

  FutureOr<void> _createTables(Database db, int version) {
    String tasks = '''create table tasks(task_id integer primary key,
    task_name varchar(50), task_desc varchar(50),task_state integer, expiration_date varchar(100), alert_date varchar(100),
    teacher_id integer, foreign key (teacher_id) references teachers(teacher_id))''';

    String careers = '''create table careers(career_id integer primary key,
    career_name varchar(100))''';

    String teachers = '''create table teachers(teacher_id integer primary key,
    teacher_name varchar(100), teacher_email varchar(100), career_id integer, foreign key (career_id) references careers(career_id)) ''';

    db.execute(careers);
    db.execute(teachers);
    db.execute(tasks);
  }

  Future<int> INSERT(String tName, Map<String, dynamic> data) async {
    var connection = await database;
    return connection!.insert(tName, data);
  }

  Future<int> UPDATE(
      String tName, String field, Map<String, dynamic> data) async {
    var connection = await database;
    return connection!
        .update(tName, data, where: '$field = ?', whereArgs: [data[field]]);
  }

  Future<int> DELETE(
      String tName, String field, int objectId, String? childTable) async {
    var connection = await database;
    if (childTable != null) {
      final dependentRows = await connection!
          .rawQuery("select * from $childTable where $field = $objectId");
      if (dependentRows.isEmpty) {
        return connection
            .delete(tName, where: '$field = ?', whereArgs: [objectId]);
      } else {
        return 0;
      }
    } else {
      return connection!
          .delete(tName, where: '$field = ?', whereArgs: [objectId]);
    }
  }

  Future<List<TaskModel>> GETALLTASKS() async {
    var connection = await database;
    var result = await connection!.query('tasks');
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<CareerModel>> GETALLCAREERS() async {
    var connection = await database;
    var result = await connection!.query('careers');
    return result.map((career) => CareerModel.fromMap(career)).toList();
  }

  Future<List<TeacherModel>> GETALLTEACHERS() async {
    var connection = await database;
    var result = await connection!.query('teachers');
    return result.map((teacher) => TeacherModel.fromMap(teacher)).toList();
  }

  Future<CareerModel> GETCAREER(int objectId) async {
    var connection = await database;
    var result = await connection!
        .query('careers', where: 'career_id = ?', whereArgs: [objectId]);
    return result.map((career) => CareerModel.fromMap(career)).toList().first;
  }

  Future<TeacherModel> GETTEACHER(int objectId) async {
    var connection = await database;
    var result = await connection!
        .query('teachers', where: 'teacher_id = ?', whereArgs: [objectId]);
    return result
        .map((teacher) => TeacherModel.fromMap(teacher))
        .toList()
        .first;
  }

  Future<void> DELETEALL(table) async {
    var connection = await database;
    await connection!.delete(table, where: '1=1');
  }

  Future<List<CareerModel>> GETFILTEREDCAREERS(String input) async {
    var connection = await database;
    var sql = "select * from careers where career_name like '%$input%'";
    var result = await connection!.rawQuery(sql);
    return result.map((career) => CareerModel.fromMap(career)).toList();
  }

  Future<List<TeacherModel>> GETFILTEREDTEACHERS(String input) async {
    var connection = await database;
    var sql = "select * from teachers where teacher_name like '%$input%'";
    var result = await connection!.rawQuery(sql);
    return result.map((teacher) => TeacherModel.fromMap(teacher)).toList();
  }

  Future<List<TaskModel>> GETFILTEREDTASKS(String input, int? input2) async {
    var connection = await database;
    var sql = input2 != null
        ? "select * from tasks where task_name like '%$input%' and task_state = $input2"
        : "select * from tasks where task_name like '%$input%'";
    var result = await connection!.rawQuery(sql);
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<TaskModel>> GETUNFINISHEDTASKS() async {
    var connection = await database;
    var sql = "select * from tasks where task_state = 0";
    var result = await connection!.rawQuery(sql);
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<PopularModel>> GETALLPOPULAR() async {
    var conexion = await database;
    var result = await conexion!.query('tblPopular');
    return result.map((event) => PopularModel.fromMap(event)).toList();
  }

  Future<List<PopularModel>> GETPOPULAR(int id) async {
    var conexion = await database;
    var result = await conexion!.query('tblPopular', where: 'id=$id');
    return result.map((event) => PopularModel.fromMap(event)).toList();
  }
}

//MAPA ES EQUIVALENTE A JSON