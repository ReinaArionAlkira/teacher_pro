import 'package:flutter/material.dart';

import '../../services/entities/grade.dart';
import '../../services/isar_service.dart';

class ListOfGradesWidget extends StatelessWidget {
  ListOfGradesWidget({required this.isarService, super.key});

  final IsarService isarService;

  final List options = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Grade>>(
        stream: isarService.getAllGrades(),
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
            return Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [CircularProgressIndicator()],
            ));
          }
        });
  }
}
