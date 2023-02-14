import 'package:flutter/material.dart';
import 'package:teacher_pro/services/student_service.dart';

import '../../../services/entities/student.dart';

class ListOfStudentsWidget extends StatelessWidget {
  ListOfStudentsWidget({super.key});

  final StudentService studentService = StudentService();

  final List options = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Student>>(
        stream: studentService.getAllStudents(),
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
                      //TODO: onTap
                      title: Text(
                          '${students[index].name} ${students[index].surrname}'),
                      subtitle: Text(
                          'Register No: ${students[index].registerNo.toString()}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          studentService.deleteStudent(students[index]);
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
