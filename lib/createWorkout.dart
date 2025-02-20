import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'main.dart';
import 'sql.dart';

class newWorkoutPage extends StatefulWidget{
  @override 
  State createState() => new thing();
}
class thing extends State<newWorkoutPage> {
  TextEditingController _workoutName = TextEditingController();
  TextEditingController _exerciseName = TextEditingController();
  TextEditingController _exerciseReps = TextEditingController();
  TextEditingController _exerciseSets = TextEditingController();
  TextEditingController _exerciseDescription = TextEditingController();
  TextEditingController _exerciseWeight = TextEditingController();

  List exercises = [];




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Color.fromRGBO(255, 113, 113, 1)),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Color.fromRGBO(255, 113, 113, 1),
          child: saveButton( workoutName: _workoutName, exercises: exercises,),
        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(255, 113, 113, 1),
          elevation: 0,
          title: TextField(
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
            controller: _workoutName,
            decoration: InputDecoration(
              hintText: "workout name",
              hintStyle: GoogleFonts.lato(
                textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 40, ),),
            ),
          )
        ),

        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
        
                //Spacer(flex: 10),
        
                Container(
                  padding: EdgeInsets.only(right: 10, bottom: 10),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 5.5),
                          child: Icon(
                            Icons.add, 
                            color: Colors.white, size: 20,
                          ),
                        ),
        
                        SizedBox(width: 1,),
                        
        
                        Text("new exercise", style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                        ),),),
                      ],
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            margin: EdgeInsets.only(top: 85),
                            child: SingleChildScrollView(
                              padding: EdgeInsets.all(30),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Material(
                                  color: Color.fromARGB(255, 255, 113, 113),
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                                                                        
                                        TextField(
                                          controller: _exerciseName, 
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white, width: 2.0),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white, width: 2.0),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            labelText: 'Exercise Name',
                                            labelStyle: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
        
                                        SizedBox(height: 15,),
        
                                                                              TextField(
                                          controller: _exerciseDescription, 
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white, width: 2.0),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white, width: 2.0),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            labelText: 'Exercise Description',
                                            labelStyle: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
        
                                        SizedBox(height: 15,),
        
                                        TextField(
                                          controller: _exerciseReps, 
                                          keyboardType: TextInputType.number,
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white, width: 2.0),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white, width: 2.0),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            labelText: 'Exercise Reps',
                                            labelStyle: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
        
                                        SizedBox(height: 15,),
        
                                        TextField(
                                          controller: _exerciseSets, 
                                          keyboardType: TextInputType.number,
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white, width: 2.0),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white, width: 2.0),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            labelText: 'Exercise Sets',
                                            labelStyle: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
        
                                        SizedBox(height: 15,),        
        
                                        TextField(
                                          controller: _exerciseWeight, 
                                          keyboardType: TextInputType.number,
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white, width: 2.0),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white, width: 2.0),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            labelText: 'Exercise Weight',
                                            labelStyle: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
        
                                        SizedBox(height: 15,),
                                    
                                        Container(
                                          height: 35,
                                          child: FloatingActionButton.extended(
                                            elevation: 0,
                                            //extendedPadding: EdgeInsets.all(0),
                                            backgroundColor: Color.fromRGBO(252, 85, 85, 1),
                                            label: Text("Add Exercise", style: GoogleFonts.lato(
                                              textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,),),),
                                            onPressed: () {
        
                                              if (_exerciseName.text == "") {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text("Error"),
                                                      content: Text("Please enter an exercise name"),
                                                      actions: [
                                                        TextButton(
                                                          child: Text("OK"),
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
        
                                              else if (_exerciseSets.text == "" && _exerciseReps.text != "") {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text("Error"),
                                                      content: Text("Please enter sets"),
                                                      actions: [
                                                        TextButton(
                                                          child: Text("OK"),
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
        
                                              else if (_exerciseSets.text != "" && _exerciseReps.text == "") {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text("Error"),
                                                      content: Text("Please enter reps"),
                                                      actions: [
                                                        TextButton(
                                                          child: Text("OK"),
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
        
                                              else {
                                                String name = _exerciseName.text;
                                                int ? reps;
                                                int ? sets;
                                                String ? description;
                                                int ? weight;
                                                            
                                                _exerciseReps.text == "" ? reps = null : reps = int.parse(_exerciseReps.text);
                                                _exerciseSets.text == "" ? sets = null : sets = int.parse(_exerciseSets.text);
                                                _exerciseDescription.text == "" ? description = 'no description' : description = _exerciseDescription.text;
                                                _exerciseWeight.text == "" ? weight = null : weight = int.parse(_exerciseWeight.text);
                                                            
                                                            
                                                exercises.add(Exercise(name, reps, sets, description, weight));
                                        
                                                _exerciseName.clear();
                                                _exerciseReps.clear();
                                                _exerciseSets.clear();
                                                _exerciseDescription.clear();
                                                _exerciseWeight.clear();
                                        
                                                setState(() {
                                                  Navigator.of(context, rootNavigator: true).pop(context);
                                                });
                                              }
                                            }
                                          ),
                                        ),
                                          
                                      ]
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
        
                ListView.builder(
                  shrinkWrap: true, 
                  itemCount: exercises.length,
                  itemBuilder: (BuildContext context, int index) {
            
                    final exercise = exercises[index];
                    return Container(
                      margin: EdgeInsets.only(left: 30, right:30, bottom: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                          child: Column(
                            children: [
        
                              if (exercise.reps == null && exercise.sets == null && exercise.weight == null) ...[
                                Container(
                                  color: Color.fromRGBO(252, 85, 85, 1),
                                  child: ListTile(
                                    //visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                    title: Text(exercise.name, style:GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,),)),
                                    subtitle: Text(exercise.description, style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,),),),
                                    textColor: Colors.white,
                                  ),
                                ),
                              ]
        
                              else ... [
                                Container(
                                  color: Color.fromRGBO(252, 85, 85, 1),
                                  child: ExpansionTile(
                                    //visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                    title: Text(exercise.name, style:GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,),)),
                                    subtitle: Text(exercise.description, style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,),),),
                                    textColor: Colors.white,
                                    children: [
        
                                      if (exercise.reps != null && exercise.sets != null ) ...[
                                        exerciseRepsSets(rep: exercise.reps, set: exercise.sets),
                                      ],
        
                                      if (exercise.weight != null) ...[
                                        exerciseWeight(weight: exercise.weight),
                                      ]
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
        ),
        ),
      );
    }
  }

  class saveButton extends StatelessWidget {
    const saveButton({required this.exercises, required this.workoutName});
    final List exercises;
    final TextEditingController workoutName;

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
              label: Text("Save", style: GoogleFonts.lato(
                textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,),),),
              onPressed: () async {
                Future<bool> isAdded = workoutNameCheck(workoutName.text);
                if (await isAdded == true) {
                  addWorkout(workoutName.text);

                  for (var item in exercises)
                    addExercise(workoutName.text, item.name, item.reps, item.sets, item.description, item.weight);  
                  Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp()),);
                }

                else if (await isAdded == false) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Workout already exists"),
                        content: Text("Please choose a different name"),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      );
    }
  }


Widget exerciseRepsSets ({required rep, required set}) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 255, 113, 113),
        ),
        child: Text("Reps: " + rep.toString() + 'x' +set.toString(), style: GoogleFonts.lato(
          textStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,),),
        ),
      ),

      SizedBox(height: 10,)
    ],
  );
}

Widget exerciseWeight ({required weight}) {
  return Column(
    children: [
      Text("Weight: " + weight.toString(), 
        style: GoogleFonts.lato(
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,),
        ),
      ),

      SizedBox(height: 10,)
    ],
  );
}

class Exercise {
  String name;
  int ? reps;
  int ? sets;
  String ? description;
  int ? weight;

  Exercise(this.name, this.reps, this.sets, this.description, this.weight);
  }

Future addExercise(String workoutName, String  name, int ? reps, int ? sets, String ? description, int ? weight) async {
  final exercises = Exercises(
    workoutName: workoutName, 
    exerciseName: name, 
    exerciseReps: reps,
    exerciseSets: sets,
    exerciseDescription: description,
    exerciseWeight: weight,
  );
  
  await DatabaseHelper.instance.addExercises(exercises);
}

Future addWorkout(name) async {
  final workouts = Workouts(
    workoutName: name,
  );

  await DatabaseHelper.instance.addWorkouts(workouts);
}
 

Future<bool> workoutNameCheck(name) async {
  List<Workouts> workoutsList = [];
  List<String> allCurrentNames = [];

  workoutsList = await DatabaseHelper.instance.getWorkouts();

  for (var item in workoutsList) {
    allCurrentNames.add(item.workoutName);
  }

  if (allCurrentNames.contains(name)) {
    return false;
  }

  else if (!allCurrentNames.contains(name)) {
    return true;
  }

  else {
    return false;
  }
}

 

 