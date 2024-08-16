import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_holiday_calendar/DataSource/data_source.dart';
import 'package:flutter_holiday_calendar/apiservices/api_service.dart';
import 'package:flutter_holiday_calendar/model/model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HolidayCalendar(),
    );
  }
}

class HolidayCalendar extends StatefulWidget {
  const HolidayCalendar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HolidayCalendarState createState() => _HolidayCalendarState();
}

class _HolidayCalendarState extends State<HolidayCalendar> {
  List<Holiday> holidays = [];
  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    fetchHolidays().then((data) {
      setState(() {
        holidays = data;
        isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Indian Holidays and Festivals'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text('Error: $errorMessage'))
              : SfCalendar(
                  view: CalendarView.schedule,
                  monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment,
                  ),
                  dataSource: HolidayDataSource(holidays),
                ),
    );
  }
}