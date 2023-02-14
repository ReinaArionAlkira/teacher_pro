import 'package:flutter/material.dart';

int timeOfDayToMinutes(TimeOfDay timeOfDay) {
  return timeOfDay.hour * 60 + timeOfDay.minute;
}

TimeOfDay minutesToTimeOfDay(int mins) {
  return TimeOfDay(hour: mins ~/ 60, minute: mins % 60);
}
