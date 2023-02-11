import 'package:isar/isar.dart';

import '../../services/entities/grade.dart';
import '../../services/entities/lesson.dart';
import '../../services/entities/student.dart';

// https://medium.com/geekculture/isar-database-how-to-use-it-with-flutter-todo-app-978a2d7c85dd
class IsarUsing {
  //final isar = await Isar.open([GradeSchema, StudentSchema, LessonSchema]);

  Future<void> createAndShow(student) async {
    final isar = await Isar.open([GradeSchema, StudentSchema, LessonSchema]);
    await isar.writeTxn(() async {
      await isar.students.put(student);
    });
  }
}
