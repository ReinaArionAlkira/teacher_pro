import 'package:isar/isar.dart';
import 'entities/grade.dart';
import 'entities/student.dart';
import 'isar_service.dart';

class GradeService {
  final Isar isar = IsarService().isar;

  static final GradeService _instance = GradeService._internal();

  factory GradeService() {
    return _instance;
  }

  GradeService._internal();

  Future<void> createGrade(Grade newGrade) async {
    await isar.writeTxn<int>(() async {
      var x = await isar.grades.put(newGrade);
      await newGrade.lesson.save();
      await newGrade.student.save();
      return x;
    });
  }

  Stream<List<Grade>> getAllGrades() async* {
    yield* isar.grades.where().watch(fireImmediately: true);
  }

  Stream<List<Grade>> getAllGradesFromStudent(Student student) async* {
    yield* isar.grades
        .where()
        .filter()
        .student((q) => q.registerNoEqualTo(student.registerNo))
        .watch(fireImmediately: true);
  }

  Future<void> editGrade(int id, Grade newGrade) async {
    await isar.writeTxn<int>(() async {
      newGrade.id = id;
      await isar.grades.put(newGrade);
      await newGrade.lesson.save();
      await newGrade.student.save();
      return newGrade.id;
    });
  }

  Future<int> getCountGradesForStudent(int registerNo) async {
    return await isar.grades
        .where()
        .filter()
        .student((q) => q.registerNoEqualTo(registerNo))
        .count();
  }

  // Deleting
  Future<void> deleteGrade(Grade record) async {
    await isar.writeTxn(() => isar.grades.delete(record.id));
  }
}
