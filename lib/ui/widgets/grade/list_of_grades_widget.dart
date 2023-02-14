import 'package:flutter/material.dart';
import 'package:teacher_pro/services/grade_service.dart';
import 'package:teacher_pro/services/lesson_service.dart';

import '../../../services/entities/grade.dart';

class ListOfGradesWidget extends StatelessWidget {
  ListOfGradesWidget({super.key});

  final GradeService gradeService = GradeService();

  final List options = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Grade>>(
        stream: gradeService.getAllGrades(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final grades = snapshot.data;
            if (grades!.isEmpty) {
              return const Card(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                  textAlign: TextAlign.center,
                  'No grades found',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              );
            }
            return Flexible(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: grades.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      //TODO: onTap
                      title: Text(grades[index].grade.toString()),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${grades[index].student.value!.surrname} ${grades[index].student.value!.name}'),
                          Text('${grades[index].lesson.value!.name}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          gradeService.deleteGrade(grades[index]);
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [CircularProgressIndicator()],
            ));
          }
        });
  }
}
