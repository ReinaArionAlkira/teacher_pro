import 'package:isar/isar.dart';

import '../../services/entities/grade.dart';
import '../../services/entities/lesson.dart';
import '../../services/entities/student.dart';

// https://medium.com/geekculture/isar-database-how-to-use-it-with-flutter-todo-app-978a2d7c85dd
class IsarService {
  late Isar isar;

  static final IsarService _instance = IsarService._internal();

  factory IsarService() {
    return _instance;
  }

  IsarService._internal();

  // IsarService() {
  //   data = openIsar();
  // }

  Future<void> init() async {
    isar = await openIsar();
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
    await isar.writeTxn<int>(() => isar.grades.put(newGrade));
  }

  Future<void> createStudent(Student newStudent) async {
    await isar.writeTxn<int>(() => isar.students.put(newStudent));
  }

  Future<void> createLesson(Lesson newLesson) async {
    await isar.writeTxn<int>(() => isar.lessons.put(newLesson));
  }

//TODO: for one student
  Stream<List<Grade>> getAllGrades() async* {
    yield* isar.grades.where().watch(fireImmediately: true);
  }

//TODO: from one lesson
  Stream<List<Student>> getAllStudents() async* {
    yield* isar.students.where().watch(fireImmediately: true);
  }

  Stream<List<Student>> getAllStudentsFromLesson(Lesson lesson) async* {
    yield* isar.students
        .where()
        .filter()
        .lessons((q) => q.idEqualTo(lesson.id))
        .watch(fireImmediately: true);
  }

//TODO: for one student
  Stream<List<Lesson>> getAllLessons() async* {
    yield* isar.lessons.where().watch(fireImmediately: true);
  }

//TODO: for one object
  Future<void> cleanDataBase() async {
    await isar.writeTxn(() => isar.clear());
  }

  // Deleting
  Future<void> deleteGrade(record) async {
    await isar.writeTxn(() => isar.grades.delete(record));
  }

  Future<void> deleteStudent(record) async {
    await isar.writeTxn(() => isar.students.delete(record));
  }

  Future<void> deleteLesson(record) async {
    await isar.writeTxn(() => isar.lessons.delete(record.id));
  }

  //TODO: searching by...
}
