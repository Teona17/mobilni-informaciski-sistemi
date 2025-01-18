import 'package:flutter/material.dart';
import 'package:event_calendar/model/event.dart';
import 'package:event_calendar/screens/mapScreen.dart';
import 'package:latlong2/latlong.dart';

class AddEventScreen extends StatefulWidget {
  final LatLng? initialLocation;
  final List<Event>? events;

  AddEventScreen({this.initialLocation, this.events});

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime _selectedDate = DateTime.now();
  LatLng? _selectedLocation;
  bool _isLocationSelected = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialLocation != null) {
      _selectedLocation = widget.initialLocation;
      _isLocationSelected = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF795548),
        title: Text(
          'Add Event',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Event Description',
                  labelStyle: TextStyle(color: Color(0xFF795548)),
                ),
                style: TextStyle(color: Color(0xFF795548)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Date: ${_selectedDate.toLocal().toString().split(' ')[0]}',
                      style: TextStyle(color: Color(0xFF795548)),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        setState(() {
                          _selectedDate = date;
                        });
                      }
                    },
                    child: Text(
                      'Select Date',
                      style: TextStyle(color: Color(0xFF795548)),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Time: ${_selectedTime.format(context)}',
                      style: TextStyle(color: Color(0xFF795548)),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime,
                      );
                      if (time != null) {
                        setState(() {
                          _selectedTime = time;
                        });
                      }
                    },
                    child: Text(
                      'Select Time',
                      style: TextStyle(color: Color(0xFF795548)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  final location = await Navigator.push<LatLng>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(
                        onLocationSelected: (location) {
                          Navigator.pop(context, location);
                        },
                        initialLocation: _selectedLocation,
                        events: widget.events,
                      ),
                    ),
                  );
                  if (location != null) {
                    setState(() {
                      _selectedLocation = location;
                      _isLocationSelected = true;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Color(0xFF795548),
                  child: Row(
                    children: [
                      Icon(Icons.map, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        _isLocationSelected
                            ? 'Location Selected ✔'
                            : 'Select Location',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF795548),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      _selectedLocation != null) {
                    final newEvent = Event(
                      description: _descriptionController.text,
                      location:
                          'Lat: ${_selectedLocation!.latitude}, Lon: ${_selectedLocation!.longitude}',
                      time: _selectedTime,
                      date: _selectedDate,
                    );
                    Navigator.pop(context, newEvent);
                  }
                },
                child: Text('Add Event', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
