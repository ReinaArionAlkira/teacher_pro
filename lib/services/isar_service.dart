import 'package:isar/isar.dart';

import '../../services/entities/grade.dart';
import '../../services/entities/lesson.dart';
import '../../services/entities/student.dart';

// https://medium.com/geekculture/isar-database-how-to-use-it-with-flutter-todo-app-978a2d7c85dd
class IsarService {
  late Future<Isar> data;

  IsarService() {
    data = openIsar();
  }

  Future<Isar> openIsar() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [GradeSchema, StudentSchema, LessonSchema],
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> createGrade(Grade newGrade) async {
    final isar = await data;
    isar.writeTxnSync<int>(() => isar.grades.putSync(newGrade));
  }

  Future<void> createStudent(Student newStudent) async {
    final isar = await data;
    isar.writeTxnSync<int>(() => isar.students.putSync(newStudent));
  }

  Future<void> createLesson(Lesson newLesson) async {
    final isar = await data;
    isar.writeTxnSync<int>(() => isar.lessons.putSync(newLesson));
  }

//TODO: for one student
  Stream<List<Grade>> getAllGrades() async* {
    final isar = await data;
    yield* isar.grades.where().watch(fireImmediately: true);
  }

//TODO: from one lesson
  Stream<List<Student>> getAllStudents() async* {
    final isar = await data;
    yield* isar.students.where().watch(fireImmediately: true);
  }

//TODO: for one student
  Stream<List<Lesson>> getAllLessons() async* {
    final isar = await data;
    yield* isar.lessons.where().watch(fireImmediately: true);
  }

//TODO: for one object
  Future<void> cleanDataBase() async {
    final isar = await data;
    await isar.writeTxn(() => isar.clear());
  }
}
