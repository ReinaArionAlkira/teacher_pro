import 'package:isar/isar.dart';
// import 'package:teacher_pro/models/student.dart';

// import 'lesson.dart';
part 'grade.g.dart';

@collection
class Grade {
  Id id = Isar.autoIncrement;

  double? grade;

  // final student = IsarLink<Student>();

  // final lesson = IsarLink<Lesson>();
}
