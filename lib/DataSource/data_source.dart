// Custom DataSource for the calendar

import 'package:flutter_holiday_calendar/model/model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HolidayDataSource extends CalendarDataSource {
  HolidayDataSource(List<Holiday> holidays) {
    appointments = holidays;
  }

  @override
  String getSubject(int index) {
    return (appointments![index] as Holiday).name;
  }

  @override
  DateTime getStartTime(int index) {
    return (appointments![index] as Holiday).date;
  }

  @override
  DateTime getEndTime(int index) {
    return (appointments![index] as Holiday).date;
  }
}
