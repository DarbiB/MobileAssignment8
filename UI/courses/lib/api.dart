import 'package:dio/dio.dart';
import './Models/courses.dart';
import './Models/students.dart';

const String localhost = "http://10.0.2.2:1200/";

//delcare api class
class CoursesApi {
  final _dio = Dio(BaseOptions(baseUrl: localhost));

  Future<List> getCourses() async {
    //delcaring api and setting url
    final response = await _dio.get('/getAllCourses');

    //print (response)
    return response.data['courses'];
  }

  Future deleteCourse(String id) async {
    final response = await _dio.post('/deleteCourseById', data: {'id': id});
  }

  Future<List> getStudents() async {
    final response = await _dio.get('/getAllStudents');
    return response.data['students'];
  }

  Future changeFirstName(String id, String fname) async {
    final response =
        await _dio.post('/editStudentById', data: {'id': id, 'fname': fname});
  }

  //Future deletCoin(String id) async {
  //final response = await _dio.post('/deleteCoin', data: {'id': id});
  //}
}
