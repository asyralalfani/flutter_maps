part of 'pages.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Completer<GoogleMapController> _mapController = Completer();
  Set<Marker> _markers = Set<Marker>();
  LocationService locationService = LocationService();

  CameraPosition initialCamera;
  BitmapDescriptor userIcon;
  UserLocation currentLocation;
  bool isLoaderMap = false;

  @override
  void initState() {
    super.initState();
    getLocationUser();
    getIconsCustom();
  }

  @override
  void dispose() {
    locationService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (isLoaderMap == true)
          ? GoogleMap(
              mapType: MapType.normal,
              compassEnabled: false,
              tiltGesturesEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: initialCamera,
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
                markerOnMap();
              },
            )
          : Center(
              child: SpinKitFadingCircle(
                size: 50,
                color: Colors.blueAccent,
              ),
            ),
    );
  }

  void getLocationUser() async {
    bool checkPermission = await MapsServices.checkPermissionService();
    if (checkPermission) {
      locationService = LocationService(check: checkPermission);
      locationService.locationStream.listen((userLocation) {
        setState(() {
          initialCamera = CameraPosition(
              zoom: ZOOM,
              tilt: TILT,
              bearing: BEARING,
              target: LatLng(userLocation.latitude, userLocation.longitude));
          currentLocation = userLocation;
          isLoaderMap = true;
        });
        markerOnMap();
      });
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  void getIconsCustom() async {
    final Uint8List markerIcon = await getBytesFromAsset( 'assets/driver_icon.png', 80);
    userIcon = BitmapDescriptor.fromBytes(markerIcon);
  }

  void markerOnMap() {
    var markPosition =
        LatLng(currentLocation.latitude, currentLocation.longitude);

    _markers.add(Marker(
      markerId: MarkerId('userLoc'),
      position: markPosition,
      icon: userIcon,
    ));
  }
}
