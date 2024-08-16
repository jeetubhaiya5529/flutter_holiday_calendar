// Function to fetch holidays from the API
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_holiday_calendar/model/model.dart';
import 'package:http/http.dart' as http;

Future<List<Holiday>> fetchHolidays() async {
  final apiKey = dotenv.env['apiKey'];
  final baseUrl = dotenv.env['baseUrl'];
  const String country = 'IN';
  const int year = 2024;
  final response = await http.get(
    Uri.parse('$baseUrl?api_key=$apiKey&country=$country&year=$year'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    final List<dynamic> holidaysList = jsonResponse['response']['holidays'];
    return holidaysList
        .map((holiday) => Holiday(
              DateTime.parse(holiday['date']['iso']),
              holiday['name'],
            ))
        .toList();
  } else {
    throw Exception('Failed to load holidays: ${response.statusCode}');
  }
}
