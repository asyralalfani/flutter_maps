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
    MapsServices.checkPermissionService().then((value) => print(value));
    return Container();
  }
}
