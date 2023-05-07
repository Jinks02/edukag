import 'package:edukag/view_models/services/auth_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HomeViewModel extends ChangeNotifier {
  AuthServiceImpl auth = AuthServiceImpl();

  String location = "";

  String getUsername() {
    return auth.currentUser?.displayName ?? " ";
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<Placemark> getAddress() async {
    Position position = await determinePosition();
    var address =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    location = address[0].subLocality ?? '';
    location = location + ', ' + address[0].locality! ?? '';
    notifyListeners();
    return address[0];
  }
}
