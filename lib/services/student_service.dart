import 'package:isar/isar.dart';
import 'package:teacher_pro/services/isar_service.dart';

import 'entities/lesson.dart';
import 'entities/student.dart';

class StudentService {
  final Isar isar = IsarService().isar;

  static final StudentService _instance = StudentService._internal();

  factory StudentService() {
    return _instance;
  }

  StudentService._internal();

  Future<void> createStudent(Student newStudent) async {
    await isar.writeTxn<int>(() => isar.students.put(newStudent));
  }

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

  Future<void> deleteStudent(Student record) async {
    await isar.writeTxn(() => isar.students.delete(record.registerNo!));
  }
}
