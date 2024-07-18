// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/util/dialog_box.dart';
import 'package:to_do_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  {

  // reference the hive box
  final _mybox = Hive.box("mybox");
  toDoDataBase db = toDoDataBase();

  @override
  void initState() {
    // if this is 1st time ever opening the app, then create default data
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }
    super.initState();
  }

  // text contoleer
  final _controller = TextEditingController();

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // create new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) { //
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
    },
    );
  }

  // delete task
  void deleteTask(int index) {
  setState(() {
    db.toDoList.removeAt(index);
  });
  db.updateDataBase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        centerTitle: false, // Disable centering the title
        title: Row(
          children: [
            Container( // Wrap CircleAvatar with Container
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Set shape to circle
                border: Border.all( // Add border
                  color: Colors.white, // Set border color (white in this case)
                  width: 1.4, // Set border width (adjust as needed)
                ),
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage('images/belle.jpg'), // Replace with your image path
                radius: 23.0, // Adjust radius to account for border width
              ),
            ),
            SizedBox(width: 60.0), // Add some horizontal spacing
            Text(
              "Belle - TO DO",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontFamily: 'pacifico',
              ),
            ),
          ],
        ),
        elevation: 0,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add, color: Colors.blue.shade50,),
        backgroundColor: Colors.blueAccent.shade400,
      ),

      body: ListView.builder(
      itemCount: db.toDoList.length,
          itemBuilder: (context, index){
            return ToDoTile(
                taskName: db.toDoList[index][0],
                taskCompleted: db.toDoList[index][1],
                onChanged: (value) => checkBoxChanged(value, index),
                deleteFunction: (context) => deleteTask(index),

            );
          },
      ),
    );
  }
}
