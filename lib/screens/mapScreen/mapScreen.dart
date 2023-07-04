import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();

  static const CameraPosition _here = CameraPosition(
    target: LatLng(27.670359, 85.312488),
    zoom: 18,
  );
  late GoogleMapController _controller;
  Set<Polygon> polygons = {};
  List<LatLng> pointsForRect = const [
    LatLng(27.670436, 85.312343),
    LatLng(27.670298, 85.312923),
    LatLng(27.670041, 85.312840),
    LatLng(27.670217, 85.312153)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Art in Map"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _here,
        polygons: polygons,
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            _controller = controller;
          });
          rectPolygon();
          _controller.animateCamera(CameraUpdate.newCameraPosition(
              const CameraPosition(
                  target: LatLng(27.670359, 85.312488), zoom: 18)));
        },
      ),
    );
  }

  rectPolygon() {
    polygons.add(
      Polygon(
        strokeWidth: 2,
        strokeColor: Colors.cyan,
        polygonId: const PolygonId("rect"),
        geodesic: true,
        fillColor: Colors.transparent,
        points: pointsForRect,
      ),
    );
  }
}
//line
          // LatLng(27.6699, 85.3054),
          // LatLng(27.6779, 85.3196),
