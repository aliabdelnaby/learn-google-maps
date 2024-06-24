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
  late Set<Polygon> polygons = {};

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(
        30.043916081931524,
        31.235197105241596,
      ),
      zoom: 11,
    );
    initPolygons();
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
          polygons: polygons,
          zoomControlsEnabled: false,
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

  void initPolygons() {
    Polygon polygon = Polygon(
      polygonId: const PolygonId('1'),
      holes: const [
        [
          LatLng(30.04934675961009, 31.230246945313542),
          LatLng(30.035081175766287, 31.23290769652366),
          LatLng(30.041768423959425, 31.247756404889792),
          LatLng(30.06227317040862, 31.25264875388904),
        ],
      ],
      points: const [
        LatLng(30.085924655200753, 31.18379246833647),
        LatLng(30.089043824749577, 31.315113415158343),
        LatLng(30.014007972860085, 31.315628399263527),
        LatLng(30.027830726736987, 31.17520939991674),
      ],
      fillColor: Colors.blue.shade100,
      strokeWidth: 3,
    );

    polygons.add(polygon);
  }
}

//! Zoom Levels
// world view 0 -> 3
// country view 4 -> 6
// city view 10 -> 12
// street view 13 -> 17
// building view 18 -> 20
