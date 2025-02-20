import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'sql.dart';


class workoutDisplayPage extends StatelessWidget {
  workoutDisplayPage({required this.workoutName});


  final workoutName;

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(Color.fromRGBO(255, 113, 113, 1)),
          fillColor: MaterialStateProperty.all(Colors.white)
          ),
        scaffoldBackgroundColor: Color.fromRGBO(255, 113, 113, 1)
        ),
      home: Scaffold(
        appBar: AppBar(
          title:  Text(workoutName, style:GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 40, ),),),
          elevation: 0,
          backgroundColor: Color.fromRGBO(255, 113, 113, 1),
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 20,),

            Expanded(child: exerciseList(workoutName: workoutName)),
            

            SizedBox(height: 20),

              //finishWorkoutButton(),
            ],
          )
        ),
      );
  }
}

class exerciseList extends StatelessWidget{
  exerciseList ({required this.workoutName});
  final workoutName;
  var $color = Color.fromRGBO(252, 85, 85, 1);
  //late final thingyLength = widget.thingyLength;

  // @override
  // getChecked() {
  //   void initState() {
  //   super.initState();
  //   final List<bool> isChecked = List.filled(thingyLength, false);
  // }
  // }
  

  //must be defined up here 

  Widget build(BuildContext context) {
    return FutureBuilder<List<Exercises>>(
      future: DatabaseHelper.instance.getExercises(workoutName),
      builder: (BuildContext context, AsyncSnapshot<List<Exercises>> snapshot) {
        if (!snapshot.hasData) {
          return Text("no workouts added yet!");
        }

        if (snapshot.hasData) {
        List<Exercises> exercises = snapshot.data!;
        final List<bool> isChecked = List.filled(exercises.length, false);

          return ListView.builder(
            shrinkWrap: true, 
            itemCount: exercises.length,
            itemBuilder: (BuildContext context, int index) {
            final exercise = exercises[index];
            final exercisesLength = exercises.length;

              String exerciseDescription = exercise.exerciseDescription ?? "no description";

              return Container(
                margin: EdgeInsets.only(left: 30, right:30, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Column(
                    children: [

                      if (exercise.exerciseReps == null && exercise.exerciseSets == null && exercise.exerciseWeight == null) ...[
                        listTileOne(isChecked: isChecked[index], exerciseName: exercise.exerciseName, exerciseDescription: exerciseDescription)
                      ]

                      else ... [
                        listTileTwo(isChecked: isChecked[index], exerciseName: exercise.exerciseName, exerciseDescription: exerciseDescription, exerciseSets: exercise.exerciseSets, exerciseReps: exercise.exerciseReps, exerciseWeight: exercise.exerciseWeight, exercise: exercise)
                      ],
                    ],
                  ),
                ),
              );
            }
          );
        }  

        return (
          Container()
        );
      }
    );
  }
}

class checkBoxes extends StatefulWidget {
  checkBoxes({required this.isChecked});
  bool isChecked;

  @override
  _checkBoxesState createState() => _checkBoxesState();
}

class _checkBoxesState extends State<checkBoxes> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Checkbox(
        value: widget.isChecked,
        onChanged: (newValue) {
          setState(() {
            widget.isChecked = newValue!;
          });
        },
      ),
    );
  }
}

class listTileOne extends StatefulWidget {
  listTileOne({required this.isChecked, required this.exerciseName, required this.exerciseDescription});
  bool isChecked;
  String exerciseName;
  String exerciseDescription;


  @override
  _listTileOneState createState() => _listTileOneState();
}

class _listTileOneState extends State<listTileOne> {
  var $color = Color.fromRGBO(252, 85, 85, 1);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: $color,
      child: ListTile(
        //visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        title: Text(widget.exerciseName, style:GoogleFonts.lato(
          fontWeight: FontWeight.bold,
          textStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,),)),
        subtitle: Text(widget.exerciseDescription, style: GoogleFonts.lato(
          textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,),),),
        trailing: Checkbox(
          value: widget.isChecked,
          onChanged: (newValue) {
            setState(() {
            widget.isChecked = newValue!;
            if (widget.isChecked == false) $color = Color.fromRGBO(252, 85, 85, 1);
            else
            $color = Color.fromARGB(255, 255, 99, 99);
            });
          },
        ),
      ),
    );
  }
}

class listTileTwo extends StatefulWidget {
  listTileTwo({required this.isChecked, required this.exerciseName, required this.exerciseDescription, required this.exerciseSets, required this.exerciseReps, required this.exerciseWeight, required this.exercise});
  bool isChecked;
  String exerciseName;
  String exerciseDescription;
  int? exerciseSets;
  int? exerciseReps;
  int? exerciseWeight;
  final exercise;


  @override
  _listTileTwoState createState() => _listTileTwoState();
}

class _listTileTwoState extends State<listTileTwo> {
  var $color = Color.fromRGBO(252, 85, 85, 1);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: $color,

      child: ExpansionTile(
        controlAffinity: ListTileControlAffinity.leading,
        trailing: Checkbox(
          value: widget.isChecked,
          onChanged: (newValue) {
            setState(() {
            widget.isChecked = newValue!;
            if (widget.isChecked == false) $color = Color.fromRGBO(252, 85, 85, 1);
            else
            $color = Color.fromARGB(255, 255, 99, 99);
            });
          },
        ),
        title: Text(widget.exerciseName, style:GoogleFonts.lato(
          fontWeight: FontWeight.bold,
          textStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,),)),
        subtitle: Text(widget.exerciseDescription, style: GoogleFonts.lato(
          textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,),),),
        textColor: Colors.white,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              if (widget.exerciseReps != null && widget.exerciseSets != null ) ...[
                exerciseRepsSets(exercise: widget.exercise),
              ],

              if (widget.exerciseWeight != null) ...[
                exerciseWeight(exercise: widget.exercise),
              ]
            ],
          ),
        ],
      ),
    );
  }
}



class exerciseRepsSets extends StatefulWidget {
  exerciseRepsSets({required this.exercise});
  final exercise;

  @override
  State<exerciseRepsSets> createState() => _exerciseRepsSetsState();
}

class _exerciseRepsSetsState extends State<exerciseRepsSets> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
    onTap: () {
      final setNumber = widget.exercise.exerciseSets;
      List<bool> isChecked = List.filled(setNumber, false);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          var repsController;
          var setsController;

          if (setNumber > 30) {
            return Container(
              height: 200,
              color: Color.fromRGBO(255, 113, 113, 1),
              child: Text("Too many sets!", style: GoogleFonts.lato(
                textStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,),),),
            );
          }

          else {
            return Container(
              height: 200,
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                    height: 200,
                    child: AlertDialog(
                      backgroundColor: Color.fromRGBO(255, 113, 113, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: Text("Set Tracker ->", style: GoogleFonts.lato(
                        textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,),),),
                      content: Container(
                        height: 110,
                        //width: double.maxFinite,
                        child: Column(
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: 80,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: setNumber,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text("Set ${index + 1}", style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,),),),
                        
                                            Container(
                                              child: Checkbox(
                                                value: isChecked[index],
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    isChecked[index] = newValue!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
              
                                        SizedBox(width: 10),
                                      ]
                                    );
                                  }
                                ),
                            ),
                      
                            if (isChecked.every((e) => e == true)) ...[
                              Container(
                                child: Text("Exercise completed", style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,),),),
                              ),
                              
                            ],
              
                          ],
                        ),
                      ),
                        //),
                  
                    ),
                  );
                }
              ),
            ); 
          }    
        }
      );
    },
    child: Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(255, 113, 113, 1),
      ),
      child: Text("Reps: " + widget.exercise.exerciseReps.toString() + 'x' + widget.exercise.exerciseSets.toString(), style: GoogleFonts.lato(
        textStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,),),
      ),
    ),
  );
    
  }
}


Widget exerciseWeight ({required Exercises exercise}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    child: Text("Weight: " + exercise.exerciseWeight.toString(), 
      style: GoogleFonts.lato(
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,),
      ),
    ),
  );
}

class Data {
  final String title;
  bool isSelected;

  Data({required this.isSelected, required this.title});

}


