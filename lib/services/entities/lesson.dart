import 'package:isar/isar.dart';
import 'grade.dart';
import 'student.dart';

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
