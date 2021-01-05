part of 'pages.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Completer<GoogleMapController> _mapController = Completer();

  CameraPosition initialCamera = CameraPosition(
      zoom: ZOOM, tilt: TILT, bearing: BEARING, target: INITIAL_LOCATION);

  LocationService locationService = LocationService();

  @override
  void initState() {
    super.initState();
    getLocationUser();
  }

  @override
  void dispose() {
    locationService.dispose();
    super.dispose();
  }

  void getLocationUser() async {
    bool checkPermission = await MapsServices.checkPermissionService();
    if (checkPermission) {
      locationService = LocationService(check: checkPermission);
      locationService.locationStream.listen((userLocation) {
        print("Latitude " + userLocation.latitude.toString());
        print("Longitude " + userLocation.longitude.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
