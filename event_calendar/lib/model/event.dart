import 'package:flutter/material.dart';

class Event {
  final String description;
  final String location;
  final TimeOfDay time;
  final DateTime date;

  Event({
    required this.description,
    required this.location,
    required this.time,
    required this.date,
  });
}
