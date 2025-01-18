import 'package:flutter/material.dart';
import 'package:event_calendar/screens/addEventScreen.dart';
import 'package:event_calendar/screens/mapScreen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:event_calendar/model/event.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  Map<DateTime, List<Event>> _events = {};
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  List<Event> _getAllEvents() {
    return _events.values.expand((eventList) => eventList).toList();
  }

  void _showEventsDialog(DateTime day) {
    final events = _events[day] ?? [];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Events for ${day.toLocal().toString().split(' ')[0]}'),
          content: events.isNotEmpty
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: events
                      .map((event) => ListTile(
                            title: Text(event.description),
                            subtitle: Text(
                                '${event.time.format(context)} at ${event.location}'),
                          ))
                      .toList(),
                )
              : Text('No events for this day.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Event Calendar',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown,
        actions: [
          IconButton(
            icon: Icon(
              Icons.map,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapScreen(
                    onLocationSelected: (location) {},
                    initialLocation: null,
                    events: _getAllEvents(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Color.fromRGBO(245, 245, 220, 1),
        child: Column(
          children: [
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              eventLoader: (day) => _events[day] ?? [],
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                _showEventsDialog(selectedDay);
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.brown,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.brown[300],
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: Colors.brown,
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: TextStyle(color: Colors.brown),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Colors.brown),
                weekendStyle: TextStyle(color: Colors.brown),
              ),
              headerStyle: HeaderStyle(
                titleCentered: true,
                titleTextStyle: TextStyle(color: Colors.brown, fontSize: 20),
                formatButtonTextStyle: TextStyle(color: Colors.brown),
                formatButtonDecoration: BoxDecoration(
                  border: Border.all(color: Colors.brown),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.brown,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () async {
          final newEvent = await Navigator.push<Event>(
            context,
            MaterialPageRoute(
              builder: (context) => AddEventScreen(events: _getAllEvents()),
            ),
          );
          if (newEvent != null) {
            setState(() {
              if (_events[_selectedDay] == null) {
                _events[_selectedDay] = [];
              }
              _events[_selectedDay]!.add(newEvent);
            });
          }
        },
        child: Text(
          'Add New Event',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
