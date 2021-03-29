import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:medapp/components/colors/school_toolkit_colors.dart';

class CalendarEvent {
  DateTime dateTime;
  int weekDay;
  final Color color;
  final bool holiday;

  CalendarEvent.fromDateTime({
    @required this.dateTime,
    this.color = SchoolToolkitColors.blue,
    this.holiday = false,
  });

  CalendarEvent.fromWeekDay({
    @required this.weekDay,
    this.color = SchoolToolkitColors.blue,
    this.holiday = false,
  });
}
