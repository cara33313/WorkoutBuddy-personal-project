import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';



class DatabaseHelper{
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'workout.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }



Future _onCreate(Database db, int version) async {
  await db.execute('''
      CREATE TABLE workouts (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        workoutName TEXT NOT NULL
      )
      ''');

  await db.execute('''
  CREATE TABLE exercises (
        exerciseID INTEGER PRIMARY KEY AUTOINCREMENT,
        workoutName TEXT NOT NULL,
        exerciseName TEXT NOT NULL,
        exerciseReps INTEGER,
        exerciseSets INTEGER,
        exerciseDescription TEXT,
        exerciseWeight INTEGER
      )
      ''');

  await db.execute('''
      CREATE TABLE splits (
        day TEXT NOT NULL,
        exerciseID INTEGER NOT NULL,
        exerciseName TEXT NOT NULL
      )
      ''');
}

//error before when requesting one column to be returned then using the tomap feature as it was mapping for all values to be returned not just one column with all the values 
Future<List<Workouts>> getWorkouts() async {
  Database db = await instance.database;
  var workouts = await db.query('workouts');
  List<Workouts> workoutsList = workouts.isNotEmpty 
  ? workouts.map((c) => Workouts.fromMap(c)).toList() : [];
  return workoutsList;
}

Future<List<Workouts>> getWorkoutNames() async {
  Database db = await instance.database;
  var workouts = await db.rawQuery('SELECT workoutName FROM workouts');

  List<Workouts> workoutsList = workouts.isNotEmpty 
  ? workouts.map((c) => Workouts.fromMap(c)).toList() : [];
  return workoutsList;
}

Future<List<Exercises>> getExercises(String workoutName) async {
  Database db = await instance.database;
  var exercises = await db.rawQuery('SELECT * FROM exercises WHERE workoutName = "$workoutName"');

  List<Exercises> exercisesList = exercises.isNotEmpty 
  ?
  exercises.map((c) => Exercises.fromMap(c)).toList() : [];
  return exercisesList;
}

Future<int> addWorkouts(Workouts workouts) async {
  Database db = await instance.database;
  return await db.insert('workouts', workouts.toMap());
}

Future<int> addExercises(Exercises exercises) async {
  Database db = await instance.database;
  return await db.insert('exercises', exercises.toMap());
}

Future<int> addSplits(Splits splits) async {
  Database db = await instance.database;
  print('running add');
  return await db.insert('splits', splits.toMap());
}





Future<void> deleteSplit(String workoutName) async {
  Database db = await instance.database;
  await db.rawQuery("DELETE FROM splits WHERE exerciseName = '$workoutName'");
}


Future<List<Splits>> getSplits(String day) async {
  Database db = await instance.database;
  var splits = await db.rawQuery("SELECT * FROM splits WHERE day = '$day'");
  List<Splits> splitsList = splits.isNotEmpty 
  ? splits.map((c) => Splits.fromMap(c)).toList() : [];
  return splitsList;


}

Future<void> deleteWorkout(String workoutName) async {
  Database db = await instance.database;
  await db.rawQuery("DELETE FROM workouts WHERE workoutName = '$workoutName'");
}

Future<void> deleteExercises(String workoutName) async {
  Database db = await instance.database;
  await db.rawQuery("DELETE FROM exercises WHERE workoutName = '$workoutName'");
}

Future<String> checkSplits(String day) async {
  Database db = await instance.database;
  var exists = await db.rawQuery("SELECT EXISTS(SELECT exerciseName FROM splits WHERE day = '$day')");
  if (exists == false) {
    return '0'; 
    }
  

  if (exists == true) {
    var splits = await db.rawQuery("SELECT exerciseName FROM splits WHERE day = '$day'");
    List<Splits> splitsList = splits.isNotEmpty 
    ? splits.map((c) => Splits.fromMap(c)).toList() : [];
    return splitsList[0].exerciseName;
  }
  else {
    return '0';
  }

  
}

Future<void> updateSplits(workoutName, day) async {
  Database db = await instance.database;
  await db.rawQuery('UPDATE splits SET exerciseName="$workoutName", exerciseID=2 WHERE day = "$day"');

}



}


class Workouts {
  final int? ID;
  final String workoutName;

  Workouts({this.ID, required this.workoutName});

  factory Workouts.fromMap(Map<String, dynamic> json) =>  Workouts(
        ID: json["ID"],
        workoutName: json["workoutName"],
      );

      Map<String, dynamic> toMap() {
        return {
          "ID": ID,
          "workoutName": workoutName,
        };
        }
      }


class Exercises {
  final int? exerciseID; 
  final String workoutName;
  final String exerciseName;
  final int? exerciseReps;
  final int? exerciseSets;
  final String? exerciseDescription;
  final int? exerciseWeight;

  Exercises({this.exerciseID, required this.workoutName, required this.exerciseName, this.exerciseReps, this.exerciseSets, this.exerciseDescription, this.exerciseWeight});

  factory Exercises.fromMap(Map<String, dynamic> json) => new Exercises(
        exerciseID: json["exerciseID"],
        workoutName: json["workoutName"],
        exerciseName: json["exerciseName"],
        exerciseReps: json["exerciseReps"],
        exerciseSets: json["exerciseSets"],
        exerciseDescription: json["exerciseDescription"],
        exerciseWeight: json["exerciseWeight"],
      );
      
      Map<String, dynamic> toMap() {
        return {
          "exerciseID": exerciseID,
          "workoutName": workoutName,
          "exerciseName": exerciseName,
          "exerciseReps": exerciseReps,
          "exerciseSets": exerciseSets,
          "exerciseDescription": exerciseDescription,
          "exerciseWeight": exerciseWeight,
        };
        }
      }








class Splits {
  final String day; 
  final int exerciseID;
  final String exerciseName;

  Splits({required this.day, required this.exerciseID, required this.exerciseName});

  factory Splits.fromMap(Map<String, dynamic> json) => Splits(
        day: json["day"],
        exerciseID: json["exerciseID"],
        exerciseName: json["exerciseName"],
      );
      
      Map<String, dynamic> toMap() {
        return {
          "day": day,
          "exerciseID": exerciseID,
          "exerciseName": exerciseName,
        };
        }
      }





