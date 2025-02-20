import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:workout_buddy_real_two/main.dart';
import 'dart:async';
import 'sql.dart';
import 'createWorkout.dart';
import 'workoutDisplay.dart';




class changeSplitPage extends StatelessWidget {
  const changeSplitPage({super.key});


  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Color.fromRGBO(255, 113, 113, 1)),
        home: Scaffold(
          appBar: AppBar(
            title:  Center(
              child: Text("change split", style:GoogleFonts.lato(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 40, 
                  ),
                ),
              ),
            ),
            elevation: 0,
            backgroundColor: Color.fromRGBO(255, 113, 113, 1),
          ),
          body: Column(
            children: [
              Spacer(),

                Row(
                  children: [
                    Spacer(),
                    Column(
                      children: [
                        Row(children: [StartBox("Monday"),DropdownButtonDay(day: "Monday"),],),
                        SizedBox(height: 30,),
                        Row(children: [StartBox("Tuesday"),DropdownButtonDay(day: "Tuesday"),],),
                        SizedBox(height: 30,),
                        Row(children: [StartBox("Wednesday"),DropdownButtonDay(day: "Wednesday")],),
                        SizedBox(height: 30,),
                        Row(children: [StartBox("Thursday"),DropdownButtonDay(day: "Thursday")],),
                        SizedBox(height: 30,),
                        Row(children: [StartBox("Friday"),DropdownButtonDay(day: "Friday")],),
                        SizedBox(height: 30,),
                        Row(children: [StartBox("Saturday"),DropdownButtonDay(day: "Saturday"),],),
                        SizedBox(height: 30,),
                        Row(children: [StartBox("Sunday"),DropdownButtonDay(day: "Sunday"),],),
                      ],
                    ),
                    Spacer(),
                  ],
                ),

              Spacer(),

              saveButton(),
              SizedBox(height: 30,),

            ],
          )
        ),
      );
  }
}

class StartBox extends StatelessWidget {
  final String day;
  StartBox(this.day);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          //height: 45,
          width: 136,
          color: Color.fromRGBO(252, 85, 85, 1),
          //color: Color.fromARGB(255, 223, 70, 70)
          child: ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text(day, style: GoogleFonts.lato(
                textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,),),),
          ),
        ),
      ),
    );
  }
}

class DropdownButtonDay extends StatefulWidget {
  final day;
  DropdownButtonDay({required this.day});

  @override
  
  State<DropdownButtonDay> createState() => _DropdownButtonDayState();
}

class _DropdownButtonDayState extends State<DropdownButtonDay> {
  late var splits;
  int ? workoutID;
  bool isLoading = false;
  late String currentSplitName;
  String ? DropDownValueDay;

  @override
  void initState() {
    super.initState();
    refreshWorkouts();
  }


@override
  Future refreshWorkouts() async {
    setState(() => isLoading = true);
    splits = await DatabaseHelper.instance.getSplits(widget.day);
    setState(() => isLoading = false);
  }


  Widget build(BuildContext context) {
  return FutureBuilder<List<Workouts>>(
    future: DatabaseHelper.instance.getWorkoutNames(),
    builder: (BuildContext context, AsyncSnapshot<List<Workouts>> snapshot,) {
      if (!snapshot.hasData) 
      {}

      if (snapshot.hasData) 
      {
        if (DropDownValueDay == null) {
          if (splits.isNotEmpty) {
            DropDownValueDay = splits[0].exerciseName;
            currentSplitName = splits[0].exerciseName;
          }
          else if (splits.isEmpty) {
            currentSplitName = 'none';
          }
        }
        //need this to get the initial value of what the split is, but must be in isnull because when you change the split and run through
        //setState again it resets it to the old value for some reason
        List<Workouts> workouts = snapshot.data!;
        List<String> items = [];
        for (var workout in workouts) {
          items.add(
              workout.workoutName
          );
        }

        return Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.only(left: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: Color.fromRGBO(252, 85, 85, 1),
                    height: 40,
                    width: 136,
                    child: ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: DropdownButton(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 0,
                        //dropdownColor: Color.fromARGB(255, 233, 89, 89),
                        dropdownColor: Color.fromRGBO(252, 85, 85, 1),
                        isExpanded: true,
                        //underline: Container(),
                        icon: Icon(Icons.arrow_drop_down, color: Colors.white,),
                        items: items.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                              child: Text(item, 
                                style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,),),
                                    ),
                          );
                        }).toList(),
                        value: DropDownValueDay,
                        onChanged: (value) {
                          setState( () {
                            SaveSplit(value.toString(), widget.day, currentSplitName);
                            DropDownValueDay = value.toString();
                          });                   
                        }
                      ),
                    ),
                  ),
                
              ),
        );

      }

      return Container();

    }
  );
  }
}

class saveButton extends StatelessWidget {
  saveButton({Key ? key} ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Align(
        alignment: Alignment.bottomCenter, 
        child: Container(
          padding: EdgeInsets.all(5),
          height: 45,
          child: FloatingActionButton.extended(
            extendedPadding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
            elevation: 0,
            backgroundColor: Color.fromRGBO(217, 79, 79, 1),
            label: Text("Save", style: GoogleFonts.lato(
              textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,),),),
            onPressed: () {
             Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp()),);
            },
          ),
        ),
      ),
    );
  }
}

Future SaveSplit(String workoutName, String day, String currentSplitName) async {
  if (currentSplitName == 'none') {
    final splits = Splits(
      day: day,
      exerciseID: 2,
      exerciseName: workoutName,
    );
    await DatabaseHelper.instance.addSplits(splits);
  }

   else {
    workoutName =  workoutName;
    day = day;

    await DatabaseHelper.instance.updateSplits(workoutName, day);
   }
}



 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
