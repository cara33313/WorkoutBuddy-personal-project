import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'sql.dart';
import 'createWorkout.dart';
import 'workoutDisplay.dart';
import 'changeSplit.dart';

void main(
) => runApp(MyApp());

    
  class MyApp extends StatelessWidget {
  @override
      
  Widget build(BuildContext context) {
  return AppBuilder(builder: (context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Color.fromRGBO(255, 113, 113, 1)),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title:  Center(
            child: Text("workoutBuddy", style:GoogleFonts.lato(
              textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 40, ),),),
          ),
        elevation: 0,
        backgroundColor: Color.fromRGBO(255, 113, 113, 1),
        ),
        body: Center(
          child: Column(
            children: [

            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(top: 35, bottom: 20),
                child: Image.asset('assets/caraLogoFinal.png')
                )
            ),
       
            Expanded(
              child: Container(
                child: todaysWorkout(),
              ), 
              flex: 1,
              ),
        
            SizedBox(
              height: 15,
            ),
        
            Expanded(
              child: Container(
                child: savedWorkoutList(),
              ), 
              flex: 3,
            ),
            
            newWorkoutButton(),
        
            SizedBox(height: 10,),
        
        
            ],
          ), 
        )
      ),
    );
  } ); }
}

class savedWorkoutList extends StatelessWidget {
  const savedWorkoutList({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Column(
        children: [
          Text("workouts", style: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),),),

          SizedBox(height: 10,),

          Expanded(
            child: (workoutList()),
          ),

        ]
      );
    }
  }



class workoutList extends StatefulWidget {
   workoutList({Key? key}) : super(key: key);

    @override
     State<workoutList> createState() => _workoutListState();
}

class _workoutListState extends State<workoutList> {

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Workouts>>(
      future: DatabaseHelper.instance.getWorkouts(),
      builder: (BuildContext context, AsyncSnapshot<List<Workouts>> snapshot) {

        if (!snapshot.hasData) {
          return Text("no workouts added yet!");
        }

        else if (snapshot.hasData) {
          List<Workouts> workouts = snapshot.data!;

          if (workouts.isEmpty) {
          }

          else {
            return ListView.builder(
              shrinkWrap: true, 
              itemCount: workouts.length,
              itemBuilder: (BuildContext context, int index) {
                final workout = workouts[index];
                return Container(
                  margin: EdgeInsets.only(left: 30, right:30, bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Slidable(
                      key: Key(workout.workoutName),
                      direction: Axis.horizontal,
                      startActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        extentRatio: 0.25,
                          children: [ 
                          
                            SlidableAction(
                              label: 'Delete',
                              backgroundColor: Colors.blue,
                              icon: Icons.delete,
                              onPressed: (context) {
                                deleteWorkout(workout.workoutName);
                                verifyDeleteSplit(workout.workoutName);
                                AppBuilder.of(context)!.rebuild();
                              },  
                            ),
                  
                            //  SlidableAction(
                            //   label: "Edit",
                            //   backgroundColor: Colors.blue,
                            //   icon: Icons.delete,
                            //   onPressed: (context) {
                            //   },  
                            // ) 
                          ], 
                      ),
      
                      child: Container(
                        height: 45,
                        color: Color.fromRGBO(252, 85, 85, 1),
                        child: ListTile(
                          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            title: Text(workout.workoutName, style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,),),),
                          onTap: () async {
                            await Navigator.of(context).push(MaterialPageRoute(builder: (context) => workoutDisplayPage(workoutName: workout.workoutName)));
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }

        return Text("no workouts added yet!", style: GoogleFonts.lato(
          textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,),), );

      }
    );     
  }
}



class todaysWorkout extends StatefulWidget {
  todaysWorkout({Key? key}) : super(key: key);

  @override 
  State<todaysWorkout> createState() => _todaysWorkoutState();
}

class _todaysWorkoutState extends State<todaysWorkout> {
  DateTime date = DateTime.now();
  String day = DateFormat('EEEE').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Splits>>(
      future: DatabaseHelper.instance.getSplits(day),
      builder: (BuildContext context, AsyncSnapshot<List<Splits>> snapshot) {

        if (snapshot.data == null) {
          return Text("no workouts added yet!");
        }

        else if (snapshot.data != null) {
          List<Splits> splits = snapshot.data!;
          if (splits.isEmpty) {
            //splits.siEmpty
          String dayLowercase = day.toLowerCase();
            return Container(
              margin: EdgeInsets.only(left: 30, right:30,),
              child: Column(      
                children: [

                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "$dayLowercase's workout", style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,),),
                        ),
                      
                        WidgetSpan(
                          child: InkWell(
                            child: Icon(Icons.more_vert, color: Colors.white,),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute( builder: (context) => changeSplitPage()));
                            },
                          )
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10,),

                  InkWell(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        height: 45,
                        color: Color.fromRGBO(252, 85, 85, 1),
                        child: ListView(
                          children: [

                            ListTile(
                              visualDensity: VisualDensity(vertical: -4,),
                              title: Text("No split assigned yet", style:GoogleFonts.lato(
                                textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,  ),),),
                              onTap: () {},
                              textColor: Colors.white,
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            );
          }

          if (splits.isNotEmpty) {
          String dayLowercase = day.toLowerCase();
            return Container(
              margin: EdgeInsets.only(left: 30, right:30,),
              child: Column(      
                children: [

                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                        text: "$dayLowercase's workout", style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,),),
                        ),
                        
                        WidgetSpan(
                          child: InkWell(
                            child: Icon(Icons.more_vert, color: Colors.white,),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute( builder: (context) => changeSplitPage()));
                            },
                          )
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10,),

                  InkWell(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        height: 45,
                        color: Color.fromRGBO(252, 85, 85, 1),
                        child: ListView(
                          children: [
                              
                            ListTile(
                              visualDensity: VisualDensity(vertical: -4,),
                              title: Text(splits[0].exerciseName, style:GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,  ),),),
                              onTap: () async {
                                await Navigator.of(context).push(MaterialPageRoute(builder: (context) => workoutDisplayPage(workoutName: splits[0].exerciseName)));
                              },
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
  
          return Container();
            
        }
    );
  }
}
    

class newWorkoutButton extends StatelessWidget {
  const newWorkoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Align(
        alignment: Alignment.bottomRight, 
        child: Container(
          padding: EdgeInsets.only(right: 10, bottom: 10,),
          height: 45,
          child: FloatingActionButton.extended(
            extendedPadding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
            elevation: 0,
            backgroundColor: Color.fromRGBO(217, 79, 79, 1),
            label: Text("new", style: GoogleFonts.lato(
              textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,),),),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute( builder: (context) => newWorkoutPage()));
            },
          ),
        ),
      ),
    );
  }
}

class changeSplitButton extends StatelessWidget {
  changeSplitButton({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
     return Container(
      height: 50,
      child: Align(
        alignment: Alignment.bottomRight, 
        child: Container(
          padding: EdgeInsets.only(right: 10, bottom: 10,),
          height: 45,
          child: FloatingActionButton.extended(
            extendedPadding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
            elevation: 0,
            backgroundColor: Color.fromRGBO(217, 79, 79, 1),
            label: Text("change split", style: GoogleFonts.lato(
              textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,),),),
            onPressed: () {

            },  
          ),
        ),
      ),
    );
  }
}

verifyDeleteSplit(workoutName) async {
  var monSplits = await DatabaseHelper.instance.getSplits("Monday");
  if (monSplits.isNotEmpty) {
    for (var i = 0; i < monSplits.length; i++) {
      if (monSplits[i].exerciseName == workoutName) {
        DatabaseHelper.instance.deleteSplit(monSplits[i].exerciseName);
      }
    }
  }
  var tueSplits = await DatabaseHelper.instance.getSplits("Tuesday");
  if (tueSplits.isNotEmpty) {
    for (var i = 0; i < tueSplits.length; i++) {
      if (tueSplits[i].exerciseName == workoutName) {
        DatabaseHelper.instance.deleteSplit(tueSplits[i].exerciseName);
      }
    }
  }
  var wedSplits = await DatabaseHelper.instance.getSplits("Wednesday");
  if (wedSplits.isNotEmpty) {
    for (var i = 0; i < wedSplits.length; i++) {
      if (wedSplits[i].exerciseName == workoutName) {
        DatabaseHelper.instance.deleteSplit(wedSplits[i].exerciseName);
      }
    }
  }
  var thuSplits = await DatabaseHelper.instance.getSplits("Thursday");
  if (thuSplits.isNotEmpty) {
    for (var i = 0; i < thuSplits.length; i++) {
      if (thuSplits[i].exerciseName == workoutName) {
        DatabaseHelper.instance.deleteSplit(thuSplits[i].exerciseName);
      }
    }
  }
  var friSplits = await DatabaseHelper.instance.getSplits("Friday");
  if (friSplits.isNotEmpty) {
    for (var i = 0; i < friSplits.length; i++) {
      if (friSplits[i].exerciseName == workoutName) {
        DatabaseHelper.instance.deleteSplit(friSplits[i].exerciseName);
      }
    }
  }
  var satSplits = await DatabaseHelper.instance.getSplits("Saturday");
  if (satSplits.isNotEmpty) {
    for (var i = 0; i < satSplits.length; i++) {
      if (satSplits[i].exerciseName == workoutName) {
        DatabaseHelper.instance.deleteSplit(satSplits[i].exerciseName);
      }
    }
  }
  var sunSplits = await DatabaseHelper.instance.getSplits("Sunday");
  if (sunSplits.isNotEmpty) {
    for (var i = 0; i < sunSplits.length; i++) {
      if (sunSplits[i].exerciseName == workoutName) {
        DatabaseHelper.instance.deleteSplit(sunSplits[i].exerciseName);
      }
    }
  }

}

deleteWorkout(workoutName) async { 
  await DatabaseHelper.instance.deleteWorkout(workoutName);
  await DatabaseHelper.instance.deleteExercises(workoutName);
}

class AppBuilder extends StatefulWidget {
  final Widget Function(BuildContext context) builder;

  const AppBuilder({Key? key, required this.builder}) : super(key: key);

  static _AppBuilderState? of(BuildContext context) {
    return context.findAncestorStateOfType<_AppBuilderState>();
  }

  @override
  _AppBuilderState createState() => _AppBuilderState();
}

class _AppBuilderState extends State<AppBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }

  void rebuild() {
    setState(() {
    });
    
  }
}