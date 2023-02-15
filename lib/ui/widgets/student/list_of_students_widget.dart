import 'package:flutter/material.dart';
import 'package:teacher_pro/services/student_service.dart';

import '../../../services/entities/student.dart';
import 'edit_student_widget.dart';

class ListOfStudentsWidget extends StatelessWidget {
  ListOfStudentsWidget({required this.stream, this.onDelete, super.key});

  final StudentService studentService = StudentService();

  final void Function(Student stdent)? onDelete;

  final Stream<List<Student>> Function() stream;

  final List options = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Student>>(
        stream: stream(),
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
                      onTap: (() {
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (BuildContext context) {
                          return EditStudentWidget(
                            student: students[index],
                          );
                        });
                        Navigator.of(context).push(route);
                      }),
                      title: Text(
                          '${students[index].name} ${students[index].surrname}'),
                      subtitle: Text(
                          'Register No: ${students[index].registerNo.toString()}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: onDelete != null
                            ? () => onDelete!(students[index])
                            : () {
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
