import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:event_calendar/model/event.dart';
import 'package:event_calendar/screens/routeMapScreen.dart';

class MapScreen extends StatefulWidget {
  final Function(LatLng) onLocationSelected;
  final LatLng? initialLocation;
  final List<Event>? events;

  MapScreen(
      {required this.onLocationSelected, this.initialLocation, this.events});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LatLng _currentLocation;

  @override
  void initState() {
    super.initState();
    _currentLocation = widget.initialLocation ?? LatLng(41.9981, 21.4254);
  }

  void _showEventDetails(Event event) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(event.description),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Location: ${event.location}"),
              Text("Date: ${event.date.toLocal().toString().split(' ')[0]}"),
              Text("Time: ${event.time.format(context)}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RouteMapScreen(
                      startLocation: _currentLocation,
                      endLocation: LatLng(
                          double.parse(event.location
                              .split(',')[0]
                              .split(':')[1]
                              .trim()),
                          double.parse(event.location
                              .split(',')[1]
                              .split(':')[1]
                              .trim())),
                    ),
                  ),
                );
              },
              child: Text("Get Route"),
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
        title: Text('Select Event Location',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: _currentLocation,
          zoom: 12.0,
          onTap: (_, LatLng latLng) {
            setState(() {
              _currentLocation = latLng;
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: _currentLocation,
                builder: (ctx) =>
                    Icon(Icons.location_on, color: Colors.blue, size: 30),
              ),
              if (widget.events != null)
                ...widget.events!
                    .map((event) {
                      final locationParts = event.location.split(',');
                      final latitude = double.tryParse(
                          locationParts[0].split(':')[1].trim());
                      final longitude = double.tryParse(
                          locationParts[1].split(':')[1].trim());

                      if (latitude != null && longitude != null) {
                        return Marker(
                          point: LatLng(latitude, longitude),
                          builder: (ctx) => GestureDetector(
                            onTap: () => _showEventDetails(event),
                            child: Icon(Icons.location_on,
                                color: Colors.red, size: 30),
                          ),
                        );
                      } else {
                        return null;
                      }
                    })
                    .where((marker) => marker != null)
                    .cast<Marker>()
                    .toList(),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.onLocationSelected(_currentLocation);
        },
        child: Icon(Icons.check, color: Colors.white),
        backgroundColor: Colors.brown,
      ),
    );
  }
}
