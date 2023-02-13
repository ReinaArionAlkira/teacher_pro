import 'package:flutter/material.dart';
import 'package:teacher_pro/services/isar_service.dart';

import '../../services/entities/student.dart';

class ListOfStudentsWidget extends StatelessWidget {
  ListOfStudentsWidget({required this.isarService, super.key});

  final IsarService isarService;

  final List options = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Student>>(
        stream: isarService.getAllStudents(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final students = snapshot.data;
            if (students!.isEmpty) {
              return const Card(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                  textAlign: TextAlign.center,
                  'No students found',
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
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                          '${students[index].name} ${students[index].surrname} ${students[index].registerNo}'),
                      // subtitle:
                      //     Text(students[index].student.registerNo as String),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          isarService.deleteStudent(students[index].registerNo);
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
