// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
   DialogBox({
    super.key,
    required this.controller,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue[900],
      content: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.blue,// Apply decoration to the container
          border: Border.all( // Set border for all sides
            color: Colors.white12, // Solid black color
            width: 1.0, // Border width (optional)
          ),
          borderRadius: BorderRadius.circular(12.0), // Circular border radius
        ),
        child: Column(
          children: [
            // get user input
            TextField(
              controller: controller,
              cursorColor: Colors.blueAccent,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder( // This will show when focused
                  borderSide: BorderSide(color: Colors.grey, width: 1.0), // Adjust color as needed
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: "Add a new task",
              ),
            ),



            // buttons - > save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save button
                MyButton(text: "Save", onPressed: onSave),

                const SizedBox(width: 4.0),
                //cancel button
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
