import 'package:isar/isar.dart';
import 'grade.dart';
import 'student.dart';

part 'lesson.g.dart';

@collection
class Lesson {
  Id id = Isar.autoIncrement;

  String? name;

  String? day;

  // Przechowuję fromTime oraz toTime jako minuty danego dnia.
  // 0 -> 00:00
  // 75 -> 01:15
  // 1439 -> 23:59
  int? fromTime;

  int? toTime;

  final grades = IsarLinks<Grade>();

  final students = IsarLinks<Student>();

  @override
  String toString() {
    return name ?? "";
  }
}
