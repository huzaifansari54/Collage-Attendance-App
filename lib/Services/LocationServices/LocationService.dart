import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<geocoding.Placemark> getLocation() {
    return location.requestService().then((value) {
      if (value) {
        return location.requestPermission().then((permission) async {
          if (permission == PermissionStatus.granted) {
            return location.getLocation().then((value) async {
              final result = await geocoding.placemarkFromCoordinates(
                  value.latitude!, value.longitude!);
              return result.first;
            });
          } else if (permission == PermissionStatus.denied) {
            await location.requestPermission();
          }
          return Future.error('Please give the permission for location');
        });
      }
      return Future.error('Location is not found');
    });
  }
}
