//Deserialization Class
class Students {
  final String id;
  final String fname;
  final String lname;
  final String studentID;
  final String courseID;
  final String courseName;

  Students._(this.id, this.fname, this.lname, this.studentID, this.courseID,
      this.courseName);

  //creating a factory based on json object to deserialize

  factory Students.fromJson(Map json) {
    //deserialization
    final id = json[''].replaceAll('ObjectId(\"', '').replaceAll('\")', '');
    final fname = json['fname'];
    final lname = json['lname'];
    final studentID = json['studentID'];
    final courseID = json['courseID'];
    final courseName = json['courseName'];

    return Students._(id, fname, lname, studentID, courseID, courseName);
  }
}
