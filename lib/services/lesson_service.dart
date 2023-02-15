import 'package:isar/isar.dart';
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

  //TODO: for one student
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

  Future<void> editLesson(Lesson editLesson) async {
    editLesson.id = await isar.lessons.put(editLesson);
  }

  Future<void> deleteLesson(Lesson record) async {
    await isar.writeTxn(() => isar.lessons.delete(record.id));
  }
}
