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
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: initialCameraPosition,
          // cameraTargetBounds: CameraTargetBounds(
          //   LatLngBounds(
          //     southwest: const LatLng(
          //       30.03737748732558,
          //       31.23417640063827,
          //     ),
          //     northeast: const LatLng(
          //       30.08967415776431,
          //       31.260918861245514,
          //     ),
          //   ),
          // ),
          onMapCreated: (controller) {
            mapController = controller;
          },
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: ElevatedButton(
            onPressed: () {
              CameraPosition newCameraPosition = const CameraPosition(
                target: LatLng(
                  30.068652804045982,
                  31.40810446504568,
                ),
                zoom: 11,
              );
              mapController?.animateCamera(
                CameraUpdate.newCameraPosition(
                  newCameraPosition,
                ),
              );
            },
            child: const Text('Change location'),
          ),
        ),
      ],
    );
  }
}
