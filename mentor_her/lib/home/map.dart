import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:havemyback/home/DropdownFAB.dart';
import 'package:permission_handler/permission_handler.dart';



class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  GoogleMapController mapController;
  static LatLng _initialPosition;
  List<String> locations = ['107/263 Nehru Nagar, Kanpur', 'Delhi' , 'Lucknow' , 'Mumbai'];
  List<LatLng> pinLocations = [];
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  String category = "Creative";

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }


  void _getUserLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage( ImageConfiguration(devicePixelRatio: 2.5),'assets/$category.png');
    setState(() {
      pinLocationIcon = icon;
    });
    List<LatLng> markLocations = [];
    for (var location in locations) {
      List<Placemark> placemark = await Geolocator().placemarkFromAddress(location);
      setState(() {
        markLocations.add(LatLng(placemark[0].position.latitude, placemark[0].position.longitude));
      });
    }
    setState(() {
      pinLocations = markLocations;
      _markers.clear();
      for(final position in markLocations ){
        final marker = Marker (
          markerId: MarkerId(position.toString()),
          position: position,
          icon: pinLocationIcon,
          infoWindow: InfoWindow(
            title: position.toString(),
            onTap: (){
            }
          )
        );
        print(marker);
        _markers.add(marker);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: _markers,
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 11.0,
        ),
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer(),),
        ].toSet(),
      ),
      floatingActionButton: DropdownFAB(
        text : "Find organisations based on their location and category!",
        onPressed: (value) async {
          setState(() {
            category = value;
          });
          //Todo: Add different icons for all categories
          BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage( ImageConfiguration(devicePixelRatio: 2.5),'assets/$category.png');
          List<LatLng> markLocations = [];
          for (var location in locations) {
            List<Placemark> placemark = await Geolocator().placemarkFromAddress(location);
            setState(() {
              markLocations.add(LatLng(placemark[0].position.latitude, placemark[0].position.longitude));
            });
          }
          setState(() {
            pinLocations = markLocations;
            _markers.clear();
            for(final position in markLocations ){
              final marker = Marker (
                  markerId: MarkerId(position.toString()),
                  position: position,
                  icon: icon,
                  infoWindow: InfoWindow(
                      title: position.toString(),
                      onTap: (){
                      }
                  )
              );
              _markers.add(marker);
            }
          });
        },
        values: ["Creative", "Technology", "Marketing"], //Todo: Add Proper Categories
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
