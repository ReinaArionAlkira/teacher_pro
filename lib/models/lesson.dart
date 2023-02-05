import 'package:isar/isar.dart';
import 'package:teacher_pro/models/grade.dart';
import 'package:teacher_pro/models/student.dart';

part 'lesson.g.dart';

@collection
class Lesson {
  Id id = Isar.autoIncrement;

  String? name;

  String? day;

  String? hours;

  final grades = IsarLinks<Grade>();

  final students = IsarLinks<Student>();
}
