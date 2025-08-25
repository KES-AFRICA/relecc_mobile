import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart';

class LocationService {
  final Location location = Location();

  Future<String?> getStreetNameFromCoordinates(double lat, double lon) async {
    final url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon&zoom=18&addressdetails=1';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'User-Agent': 'FlutterApp',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['address']['road'] ?? data['display_name'];
      } else {
        print('Erreur Nominatim: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erreur lors de la récupération de la rue: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getCurrentLocation() async {
    try {
      bool serviceEnabled;
      PermissionStatus permissionGranted;

      // Vérification et activation du service
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) return null;
      }

      // Vérification et demande de permission
      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) return null;
      }

      // Obtention de la position
      final locationData = await location.getLocation();

      // Récupération du nom de rue
      final street = await getStreetNameFromCoordinates(
          locationData.latitude!, locationData.longitude!);

      return {
        'coordinates': "${locationData.latitude},${locationData.longitude}",
        'streetName': street,
        'latitude': locationData.latitude,
        'longitude': locationData.longitude,
      };
    } catch (e) {
      print('Erreur localisation: $e');
      return null;
    }
  }
}