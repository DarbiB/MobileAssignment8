import 'package:flutter/material.dart';
import 'api.dart';
import 'main.dart';
import 'editStudent.dart';

class studentList extends StatefulWidget {
  final String id, fname, studentID, courseName;

  final CoursesApi api = CoursesApi();

  studentList(this.id, this.fname, this.studentID, this.courseName);

  @override
  State<studentList> createState() =>
      _studentListState(id, fname, studentID, courseName);
}

class _studentListState extends State<studentList> {
  final String id, fname, studentID, courseName;

  _studentListState(this.id, this.fname, this.studentID, this.courseName);

  List students = [];
  bool _dbLoaded = false;

  void initState() {
    super.initState();
    widget.api.getStudents().then((data) {
      setState(() {
        students = data;
        students.sort(
            (a, b) => a['fname'].toString().compareTo(b['fname'].toString()));
        _dbLoaded = true;
      });
    });
  }

  void _deleteCourse(id) {
    setState(() {
      widget.api.deleteCourse(id);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: _dbLoaded
              ? Column(
                  children: [
                    Expanded(
                      child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(15.0),
                          children: [
                            ElevatedButton(
                                onPressed: () => {
                                      _deleteCourse(widget.id),
                                    },
                                child: Text("Delete Course"),
                                style: ElevatedButton.styleFrom(
                                    textStyle: TextStyle(fontSize: 20),
                                    primary: Colors.red)),
                            Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  "Students",
                                  style: TextStyle(fontSize: 24),
                                  textAlign: TextAlign.center,
                                )),
                            ...students
                                .map<Widget>(
                                  (students) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: TextButton(
                                      onPressed: () => {
                                        Navigator.pop(context),
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditStudent(
                                                        students['_id'],
                                                        students['fname'],
                                                        //courses[
                                                        //'courseCredits'],
                                                        students['studentID'],
                                                        students[
                                                            'courseName']))),
                                      },
                                      child: ListTile(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        // leading: CircleAvatar(
                                        //   radius: 70,
                                        //   child: Text(courses['courseID']),
                                        // ),
                                        //title: Text("Student: "),
                                        title: Text(
                                          (students['fname'] +
                                              " " +
                                              students['lname']),
                                          style: TextStyle(fontSize: 20),
                                          textAlign: TextAlign.center,
                                        ),
                                        // subtitle: Text(
                                        //     "Instructor: " +
                                        //         courses['courseInstructor'] +
                                        //         "\t\t\t\t" +
                                        //         "Credits: " +
                                        //         courses['courseCredits']
                                        //             .toString(),
                                        //     style: TextStyle(fontSize: 20)),

                                        tileColor: Colors.indigo,
                                        textColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ]),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Database Loading",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    CircularProgressIndicator()
                  ],
                )),
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
