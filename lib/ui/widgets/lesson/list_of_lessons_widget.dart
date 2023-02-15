import 'package:flutter/material.dart';
import 'package:teacher_pro/services/lesson_service.dart';

import '../../../services/entities/lesson.dart';
import '../../../utils/time_range_convert.dart';
import 'edit_lesson_widget.dart';

class ListOfLessonsWidget extends StatelessWidget {
  ListOfLessonsWidget({required this.stream, this.onDelete, super.key});

  final LessonService lessonService = LessonService();

  final void Function(Lesson lesson)? onDelete;

  final Stream<List<Lesson>> Function() stream;

  final List options = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Lesson>>(
        stream: stream(),
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
                      onTap: (() {
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (BuildContext context) {
                          return EditLessonWidget(
                            lesson: lessons[index],
                          );
                        });
                        Navigator.of(context).push(route);
                      }),
                      title: Text(lessons[index].name!),
                      subtitle: Text(
                          '${lessons[index].day}:  ${minutesToTimeOfDay(lessons[index].fromTime!).format(context)} - ${minutesToTimeOfDay(lessons[index].toTime!).format(context)}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: onDelete != null
                            ? () => onDelete!(lessons[index])
                            : () {
                                lessonService.deleteLesson(lessons[index]);
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
