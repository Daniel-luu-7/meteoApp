import 'package:geolocator/geolocator.dart';

class Location {
  double latitude = 0;
  double longitude = 0;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      (!serviceEnabled)
          ? print('Location services are disabled')
          : print('Location services are enabled');

      permission = await Geolocator.requestPermission();

      print(permission);

      if (permission == LocationPermission.whileInUse) {
        permission = await Geolocator.requestPermission();

        (permission == LocationPermission.denied)
            ? print('Location permissions are denied')
            : print('Location permissions are authorized');
      }

      // Position position = await Geolocator.getCurrentPosition(
      //     desiredAccuracy: LocationAccuracy.low);
      // print(position);
      // latitude = position.latitude;
      // longitude = position.longitude;

      latitude = 32.5;
      longitude = 45.2;
    } catch (e) {
      print('Error: $e');
    }
  }
}
