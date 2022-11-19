//Deserialization Class
class Courses {
  final String id;
  final String courseInstructor;
  final int courseCredits;
  final String courseID;
  final String courseName;

  Courses._(this.id, this.courseInstructor, this.courseCredits, this.courseID,
      this.courseName);

  //creating a factory based on json object to deserialize

  factory Courses.fromJson(Map json) {
    //deserialization
    final id = json[''].replaceAll('ObjectId(\"', '').replaceAll('\")', '');
    final courseInstructor = json['courseInstructor'];
    final courseCredits = json['courseCredits'];
    final courseID = json['courseID'];
    final courseName = json['courseName'];

    return Courses._(id, courseInstructor, courseCredits, courseID, courseName);
  }
}
