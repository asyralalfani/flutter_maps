part of 'services.dart';

class MapsServices {
  static Location location = Location();

  static Future<bool> checkEnableService() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      return serviceEnabled;
    } else {
      return true;
    }
  }

  static Future<bool> checkPermissionService() async {
    PermissionStatus permissionGranted = await location.hasPermission();
    bool checkEnabled = await checkEnableService();
    if (checkEnabled) {
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        return true;
      } else {
        return true;
      }
    }
  }
}
