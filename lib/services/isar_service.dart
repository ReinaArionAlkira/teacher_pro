import 'package:isar/isar.dart';

import '../../services/entities/grade.dart';
import '../../services/entities/lesson.dart';
import '../../services/entities/student.dart';

class IsarService {
  late Isar isar;

  static final IsarService _instance = IsarService._internal();

  factory IsarService() {
    return _instance;
  }

  IsarService._internal();

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

  Future<void> cleanDataBase() async {
    await isar.writeTxn(() => isar.clear());
  }

  //todo: searching by...
}
