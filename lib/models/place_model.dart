import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModel({required this.id, required this.name, required this.latLng});
}

List<PlaceModel> places = [
  PlaceModel(
    id: 1,
    name: 'Safary Hotel',
    latLng: const LatLng(30.055916191301712, 31.24713551428398),
  ),
  PlaceModel(
    id: 2,
    name: 'Bella Case Hotel',
    latLng: const LatLng(30.047965841266443, 31.241785372494817),
  ),
  PlaceModel(
    id: 3,
    name: 'Gamaleya Boutique',
    latLng: const LatLng(30.05342408127319, 31.26085898488362),
  ),
];
