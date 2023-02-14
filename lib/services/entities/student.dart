import 'package:isar/isar.dart';
import 'lesson.dart';
import 'grade.dart';

part 'student.g.dart';

@collection
class Student {
  Id? registerNo;

  String? name;

  String? surrname;

  final grades = IsarLinks<Grade>();

  final lessons = IsarLinks<Lesson>();

  @override
  String toString() {
    return '$surrname $name';
  }
}
