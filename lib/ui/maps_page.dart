part of 'pages.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Completer<GoogleMapController> _mapController = Completer();

  CameraPosition initialCamera = CameraPosition(
      zoom: ZOOM, tilt: TILT, bearing: BEARING, target: INITIAL_LOCATION);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      compassEnabled: true,
      tiltGesturesEnabled: false,
      zoomControlsEnabled: false,
      initialCameraPosition: initialCamera,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
    );
  }
}
