// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/utils/location_services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  GoogleMapController? mapController;
  late Location location;
  Set<Marker> markers = {};
  late LocationServices locationServices;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(30.043916081931524, 31.235197105241596),
      zoom: 11,
    );
    location = Location();
    locationServices = LocationServices();
    updateMyLocation();
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
      markers: markers,
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

    mapController!.setMapStyle(nightMapStyle);
  }

  void updateMyLocation() async {
    await locationServices.checkAndRequestLocationService();
    var hasPermission =
        await locationServices.checkAndRequestLocationPermission();
    if (hasPermission) {
      locationServices.getRealTimeLocationData(
        (locationData) {
          setmyLocationMarker(locationData);
          setMyCameraPosition(locationData);
        },
      );
    } else {}
  }

  void setMyCameraPosition(LocationData locationData) {
    var cameraPosition = CameraPosition(
      target: LatLng(
        locationData.latitude!,
        locationData.longitude!,
      ),
      zoom: 15,
    );
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }

  void setmyLocationMarker(LocationData locationData) {
    var myLocationMarker = Marker(
      markerId: const MarkerId('myLocation'),
      position: LatLng(
        locationData.latitude!,
        locationData.longitude!,
      ),
    );
    markers.add(myLocationMarker);
    setState(() {});
  }
}

//! Zoom Levels
// world view 0 -> 3
// country view 4 -> 6
// city view 10 -> 12
// street view 13 -> 17
// building view 18 -> 20
