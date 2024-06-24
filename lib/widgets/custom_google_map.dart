// ignore_for_file: deprecated_member_use, unused_local_variable
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_with_google_maps/models/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController? mapController;
  late Set<Marker> markers = {};
  late Set<Polyline> polyLines = {};

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
    initMarkers();
    initPolyLines();
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
          polylines: polyLines,
          zoomControlsEnabled: false,
          markers: markers,
          initialCameraPosition: initialCameraPosition,
          onMapCreated: (controller) {
            mapController = controller;
            initMapStyles();
          },
        ),
      ],
    );
  }

  void initMapStyles() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/night_map_style.json');

    mapController?.setMapStyle(nightMapStyle);
  }

  Future<Uint8List> getAssetImageFromRawData(String image, double width) async {
    var imageData = await rootBundle.load(image);
    var imageCodec = await ui.instantiateImageCodec(
      imageData.buffer.asUint8List(),
      targetWidth: width.round(),
    );
    var imageFrame = await imageCodec.getNextFrame();
    var imageByteData =
        await imageFrame.image.toByteData(format: ui.ImageByteFormat.png);
    return imageByteData!.buffer.asUint8List();
  }

  void initMarkers() async {
    // var customMarkerIcon = BitmapDescriptor.bytes(
    //   await getAssetImageFromRawData("assetImage", 100),
    // );

    var myMarkers = places
        .map(
          (placeModel) => Marker(
            markerId: MarkerId(
              placeModel.id.toString(),
            ),
            // icon: customMarkerIcon,
            position: placeModel.latLng,
            infoWindow: InfoWindow(
              title: placeModel.name,
            ),
          ),
        )
        .toSet();
    markers.addAll(myMarkers);
    setState(() {});
  }

  void initPolyLines() {
    Polyline polyline = const Polyline(
      polylineId: PolylineId("1"),
      color: Colors.blue,
      zIndex: 1,
      startCap: Cap.roundCap,
      width: 5,
      points: [
        LatLng(30.043916081931524, 31.235197105241596),
        LatLng(30.047965841266443, 31.241785372494817),
        LatLng(30.055916191301712, 31.24713551428398),
        LatLng(30.05342408127319, 31.26085898488362),
      ],
    );
    Polyline polyline2 = const Polyline(
      polylineId: PolylineId("2"),
      color: Colors.red,
      
      patterns: [
        PatternItem.dot,
      ],
      startCap: Cap.roundCap,
      width: 5,
      points: [
        LatLng(30.055916194501892, 31.24713558928311),
        LatLng(30.05342406927378, 31.26081478488336),
      ],
    );

    polyLines.add(polyline);
    polyLines.add(polyline2);
  }
}
