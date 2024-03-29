import 'package:isar/isar.dart';
import 'package:teacher_pro/services/entities/grade.dart';
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

  Future<void> editStudent(int registerNo, Student newStudent) async {
    await isar.writeTxn<int>(() async {
      newStudent.registerNo = registerNo;
      await isar.students.put(newStudent);
      await newStudent.grades.save();
      await newStudent.lessons.save();
      return newStudent.registerNo!;
    });
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

  Future<int> getCountStudentsForLesson(int id) async {
    return await isar.students
        .where()
        .filter()
        .lessons((q) => q.idEqualTo(id))
        .count();
  }

  Future<void> deleteLessonFromStudent(Student student, Lesson lesson) async {
    await isar.writeTxn<void>(() async {
      student.lessons.remove(lesson);
      await student.lessons.save();
      await isar.grades
          .filter()
          .student((q) => q.registerNoEqualTo(student.registerNo))
          .lesson((q) => q.idEqualTo(lesson.id))
          .deleteAll();
    });
  }

  Future<void> deleteStudent(Student record) async {
    await isar.writeTxn(() => isar.students.delete(record.registerNo!));
    await isar.grades
        .filter()
        .student((q) => q.registerNoEqualTo(record.registerNo))
        .deleteAll();
  }
}
