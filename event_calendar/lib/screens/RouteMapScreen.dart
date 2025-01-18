import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RouteMapScreen extends StatefulWidget {
  final LatLng startLocation;
  final LatLng endLocation;

  RouteMapScreen({required this.startLocation, required this.endLocation});

  @override
  _RouteMapScreenState createState() => _RouteMapScreenState();
}

class _RouteMapScreenState extends State<RouteMapScreen> {
  List<LatLng> route = [];

  @override
  void initState() {
    super.initState();
    _fetchRoute();
  }

  Future<void> _fetchRoute() async {
    final url = Uri.parse(
        'https://router.project-osrm.org/route/v1/driving/${widget.startLocation.longitude},${widget.startLocation.latitude};${widget.endLocation.longitude},${widget.endLocation.latitude}?overview=full&geometries=polyline');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final geometry = data['routes'][0]['geometry'];
      setState(() {
        route = _decodePolyline(geometry);
      });
    } else {
      print('Failed to load route');
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0;
    int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int deltaLat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += deltaLat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int deltaLng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += deltaLng;

      polyline.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return polyline;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: widget.startLocation,
          zoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          if (route.isNotEmpty)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: route,
                  strokeWidth: 4.0,
                  color: Colors.red,
                ),
              ],
            ),
          MarkerLayer(
            markers: [
              Marker(
                point: widget.startLocation,
                builder: (ctx) =>
                    Icon(Icons.my_location, color: Colors.blue, size: 30),
              ),
              Marker(
                point: widget.endLocation,
                builder: (ctx) =>
                    Icon(Icons.location_on, color: Colors.green, size: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
