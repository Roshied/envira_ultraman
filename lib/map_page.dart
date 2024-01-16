import 'dart:async';
import 'dart:collection';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart' as point;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/src/types/polyline.dart'
as poly;
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';
import '../consts.dart';
import 'package:location/location.dart' as loc;

class SearchMap extends StatefulWidget {
  const SearchMap({super.key});

  @override
  State<SearchMap> createState() => _SearchMapState();
}

class _SearchMapState extends State<SearchMap> {
  loc.Location _locationController = new loc.Location();

  final Completer<GoogleMapController> _mapController =
  Completer<GoogleMapController>();

  GoogleMapController? mapController;
  String location = "Search Location";
  static const LatLng _pGooglePlex =
  LatLng(-7.268588481297382, 112.78431469818055);
  static const LatLng _pApplePark =
  LatLng(-7.264635809343702, 112.75851922331852);
  LatLng? _currentP = null;

  Map<PolylineId, poly.Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getLocationUpdates().then((_) => {
      getPolyLinePoints().then((coordinates) => {
        generatePolyLineFromPoints(coordinates),
      }),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ENVIRA"),
        backgroundColor: Colors.yellowAccent,
      ),
      body: _currentP == null
          ? const Center(
        child: Text("Loading..."),
      )
          : Stack(
        children: [
          GoogleMap(
            onMapCreated: ((GoogleMapController controller) =>
                _mapController.complete(controller)),
            initialCameraPosition: CameraPosition(
              target: _pGooglePlex,
              zoom: 15,
            ),
            markers: {
              Marker(
                  markerId: MarkerId("_currentLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _currentP!),
              Marker(
                  markerId: MarkerId("_sourceLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _pGooglePlex),
            },
            polylines: Set<poly.Polyline>.of(polylines.values),
          ),
          Positioned(
              top: 10,
              child: InkWell(
                onTap: () async {
                  var place = await PlacesAutocomplete.show(
                      context: context,
                      apiKey: GOOGLE_MAPS_API_KEY,
                      mode: Mode.overlay,
                      types: [],
                      strictbounds: false,
                      components: [Component(Component.country, 'id')],
                      onError: (err) {
                        print(err);
                      });

                  if (place != null) {
                    setState(() {
                      location = place.description.toString();
                    });

                    final plist = GoogleMapsPlaces(
                      apiKey: GOOGLE_MAPS_API_KEY,
                      apiHeaders: await GoogleApiHeaders().getHeaders(),
                    );
                    String placeid = place.placeId ?? "0";
                    final detail =
                    await plist.getDetailsByPlaceId(placeid);
                    final geometry = detail.result.geometry!;
                    final lat = geometry.location.lat;
                    final lng = geometry.location.lng;
                    var newlatlng = LatLng(lat, lng);

                    mapController?.animateCamera(
                        CameraUpdate.newCameraPosition(
                            CameraPosition(target: newlatlng, zoom: 13)));
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width - 40,
                      child: ListTile(
                        title: Text(
                          location,
                          style: TextStyle(fontSize: 18),
                        ),
                        trailing: Icon(Icons.search),
                        dense: true,
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital_rounded),
            label: 'Kesehatan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 15,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }
    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted == loc.PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((loc.LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentP!);
        });
      }
    });
  }

  Future<List<LatLng>> getPolyLinePoints() async {
    List<LatLng> polylineCoordinates = [];
    point.PolylinePoints polylinePoints = point.PolylinePoints();
    point.PolylineResult result =
    await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY,
      point.PointLatLng(_currentP!.latitude, _currentP!.longitude),
      point.PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
      travelMode: point.TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((point.PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("poly");
    poly.Polyline polyline = poly.Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 8);
    setState(() {
      polylines[id] = polyline;
    });
  }
}
