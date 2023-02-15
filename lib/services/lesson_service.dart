import 'package:isar/isar.dart';
import 'package:teacher_pro/services/entities/grade.dart';
import 'package:teacher_pro/services/entities/lesson.dart';
import 'package:teacher_pro/services/entities/student.dart';
import 'isar_service.dart';

class LessonService {
  final Isar isar = IsarService().isar;

  static final LessonService _instance = LessonService._internal();

  factory LessonService() {
    return _instance;
  }

  LessonService._internal();

  Future<void> createLesson(Lesson newLesson) async {
    await isar.writeTxn<int>(() => isar.lessons.put(newLesson));
  }

  Future<void> addStudentToLesson(Lesson lesson, Student student) async {
    await isar.writeTxn<void>(() async {
      final st = await isar.students
          .filter()
          .registerNoEqualTo(student.registerNo)
          .findFirst();
      if (st == null) {
        return;
      }
      st.lessons.add(lesson);
      await st.lessons.save();
      lesson.students.add(student);
      await lesson.students.save();
    });
  }

  Stream<List<Lesson>> getAllLessons() async* {
    yield* isar.lessons.where().watch(fireImmediately: true);
  }

  Stream<List<Lesson>> getAllLessonsFromStudent(int registerNo) async* {
    yield* isar.lessons
        .where()
        .filter()
        .students((q) => q.registerNoEqualTo(registerNo))
        .watch(fireImmediately: true);
  }

  Future<int> getCountLessonsForStudent(int registerNo) async {
    return await isar.lessons
        .where()
        .filter()
        .students((q) => q.registerNoEqualTo(registerNo))
        .count();
  }

  Future<void> editLesson(int id, Lesson editLesson) async {
    await isar.writeTxn<int>(() async {
      editLesson.id = id;
      await isar.lessons.put(editLesson);
      await editLesson.grades.save();
      await editLesson.students.save();
      return editLesson.id;
    });
  }

  Future<void> deleteStudentFromLesson(Lesson lesson, Student student) async {
    await isar.writeTxn<void>(() async {
      lesson.students.remove(student);
      await lesson.students.save();
      student.lessons.remove(lesson);
      await student.lessons.save();
      await isar.grades
          .filter()
          .lesson((q) => q.idEqualTo(lesson.id))
          .deleteAll();
    });
  }

  Future<void> deleteLesson(Lesson record) async {
    await isar.writeTxn(() => isar.lessons.delete(record.id));
  }
}
