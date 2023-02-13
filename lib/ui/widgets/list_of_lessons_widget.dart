import 'package:flutter/material.dart';

import '../../services/entities/lesson.dart';

class ListOfLessonsWidget extends StatelessWidget {
  ListOfLessonsWidget({required this.isarService, super.key});

  final isarService;

  final List options = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Lesson>>(
        stream: isarService.getAllLessons(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final lessons = snapshot.data;
            if (lessons!.isEmpty) {
              return const Card(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                  textAlign: TextAlign.center,
                  'No lessons found',
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
                itemCount: lessons.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(lessons[index].name!),
                      // subtitle:
                      //     Text(lessons[index].student.registerNo as String),
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
