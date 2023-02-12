import 'package:flutter/material.dart';

import '../../services/entities/grade.dart';

class ListOfGradesWidget extends StatelessWidget {
  ListOfGradesWidget({required this.isarService, super.key});

  final isarService;

  final List options = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Grade>>(
        stream: isarService.getAllGrades(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final grades = snapshot.data;
            if (grades!.isEmpty) {
              return const Center(
                child: Text('No grades found'),
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
                      title: Text(grades[index].grade.toString()),
                      // subtitle:
                      //     Text(grades[index].student.registerNo as String),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
