import 'package:flutter/material.dart';
import 'api.dart';
import 'studentList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Courses App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //declare API
  final CoursesApi api = CoursesApi();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List courses = [];
  bool _dbLoaded = false;

  void initState() {
    super.initState();
    widget.api.getCourses().then((data) {
      setState(() {
        courses = data;
        courses.sort((a, b) =>
            a['courseName'].toString().compareTo(b['courseName'].toString()));
        _dbLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Courses App"),
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
                            ...courses
                                .map<Widget>(
                                  (courses) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: TextButton(
                                      onPressed: () => {
                                        Navigator.pop(context),
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    studentList(
                                                        courses['_id'],
                                                        courses[
                                                            'courseInstructor'],
                                                        //courses[
                                                        //'courseCredits'],
                                                        courses['courseID'],
                                                        courses[
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
                                        title: Text(
                                            "Course: " +
                                                (courses['courseName']),
                                            style: TextStyle(fontSize: 22)),
                                        subtitle: Text(
                                            "Instructor: " +
                                                courses['courseInstructor'] +
                                                "\t\t\t\t" +
                                                "Credits: " +
                                                courses['courseCredits']
                                                    .toString(),
                                            style: TextStyle(fontSize: 20)),

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
    );
  }
}
