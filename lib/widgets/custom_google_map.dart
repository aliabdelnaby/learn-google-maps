// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController? mapController;
  late Set<Circle> circles = {};

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(
        30.043916081931524,
        31.235197105241596,
      ),
      zoom: 11,
    );

    initCircles();
    super.initState();
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      circles: circles,
      zoomControlsEnabled: false,
      initialCameraPosition: initialCameraPosition,
      onMapCreated: (controller) {
        mapController = controller;
        initMapStyles();
      },
    );
  }

  void initMapStyles() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/night_map_style.json');

    mapController?.setMapStyle(nightMapStyle);
  }

  void initCircles() {
    Circle circle = Circle(
      circleId: const CircleId('1'),
      center: const LatLng(30.043916081931524, 31.235197105241596),
      radius: 1000,
      strokeWidth: 3,
      fillColor: Colors.black.withOpacity(0.5),
    );
    circles.add(circle);
  }
}

//! Zoom Levels
// world view 0 -> 3
// country view 4 -> 6
// city view 10 -> 12
// street view 13 -> 17
// building view 18 -> 20
