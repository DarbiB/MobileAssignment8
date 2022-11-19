import 'package:flutter/material.dart';
import 'api.dart';
import 'main.dart';

class EditStudent extends StatefulWidget {
  final String id, fname, studentID, courseName;

  final CoursesApi api = CoursesApi();

  EditStudent(this.id, this.fname, this.studentID, this.courseName);

  @override
  State<EditStudent> createState() => _EditStudentState(id, fname);
}

class _EditStudentState extends State<EditStudent> {
  final String id, fname;

  _EditStudentState(this.id, this.fname);

  void _changeFirstName(id, fname) {
    setState(() {
      widget.api.changeFirstName(id, fname);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Student ID: " + widget.studentID,
          style: TextStyle(fontSize: 20),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Text(
                    "Enter a new first name for " + widget.fname,
                    style: TextStyle(fontSize: 22),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: priceController,
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            _changeFirstName(widget.id, priceController.text),
                          },
                      child: Text("Change First Name",
                          style: TextStyle(fontSize: 20))),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: () => {
                Navigator.pop(context),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage())),
              }),
    );
  }
}
