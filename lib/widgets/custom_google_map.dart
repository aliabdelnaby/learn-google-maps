import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(
        30.043916081931524,
        31.235197105241596,
      ),
      zoom: 11,
      //! Zoom Levels
      // world view 0 -> 3
      // country view 4 -> 6
      // city view 10 -> 12
      // street view 13 -> 17
      // building view 18 -> 20
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      cameraTargetBounds: CameraTargetBounds(
        LatLngBounds(
          southwest: const LatLng(
            30.03737748732558,
            31.23417640063827,
          ),
          northeast: const LatLng(
            30.08967415776431,
            31.260918861245514,
          ),
        ),
      ),
    );
  }
}
