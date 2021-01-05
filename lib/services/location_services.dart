part of 'services.dart';

class LocationService {
  Location location = Location();
  StreamController<UserLocation> locationStreamController =
      StreamController<UserLocation>();
  Stream<UserLocation> get locationStream => locationStreamController.stream;

  LocationService({bool check}) {
    if (check == true) {
      location.onLocationChanged.listen((locationData) {
        if (locationData != null) {
          locationStreamController.add(UserLocation(
              latitude: locationData.latitude,
              longitude: locationData.longitude));
        }
      });
    }
  }

  void dispose() => locationStreamController.close();
}
