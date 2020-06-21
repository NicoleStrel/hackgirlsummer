import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:havemyback/home/DropdownFAB.dart';
import 'package:havemyback/models/organisationModel.dart';
import 'package:havemyback/profile/CompanyProfile.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../models/CRUDModel.dart';


class Map extends StatefulWidget {
  
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  
  
  GoogleMapController mapController;
  static LatLng _initialPosition;
  AsyncSnapshot outsidesnapshot;
  List<String> locations = ['107/263 Nehru Nagar, Kanpur', 'Delhi' , 'Lucknow' , 'Mumbai'];
  List<LatLng> pinLocations = [];
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  String category = "Creative";
  List<String> categories=['Creative', 'Technology','Digital Marketing', 'Consulting', 'Tax Preparation', 'Public Relations'];

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
    print("before");
    final List<Organisation> organisations = await Provider.of<CRUDModel>(context).fetchOrganisationsByCategory(category);
    for (var org in organisations) {
        List<Placemark> placemark = await Geolocator().placemarkFromAddress(org.location);
        print(org.location);
        setState(() {
          markLocations.add(LatLng(placemark[0].position.latitude, placemark[0].position.longitude));
        });
    }
    setState(() {
      pinLocations = markLocations;
      _markers.clear();
      int i = 0;
      for(final position in markLocations){
        final marker = Marker (
          markerId: MarkerId(organisations[i].cname),
          position: position,
          icon: icon,
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyProfile(id:organisations[i].id, org: organisations[i],)));
          },
          infoWindow: InfoWindow(
            title: organisations[i]?.cname,
            onTap: (){
//              Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyProfile(id: organisations.elementAt(i).id)));
            }
          )
        );
        i = i+1;
        _markers.add(marker);
      }
      i = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final orgProvider = Provider.of<CRUDModel>(context);

    return Center(
        child: FutureBuilder<List<Organisation>>(
           future: orgProvider.fetchOrganisations(),
            builder: (context, snapshot) {
              outsidesnapshot=snapshot;
              if(snapshot.hasData){
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
                        _markers.clear();
                      });
                      BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),'assets/$category.png');
                      List<LatLng> markLocations = [];
                      List<Organisation> categoryOrgs = [];
                      for (var org in snapshot.data) {
                        if (org.category==category){
                          List<Placemark> placemark = await Geolocator().placemarkFromAddress(org.location);
                          categoryOrgs.add(org);
                          setState(() {
                            markLocations.add(LatLng(placemark[0].position.latitude, placemark[0].position.longitude));
                          });
                        }
                      }
                      setState(() {
                        pinLocations = markLocations;
                        _markers.clear();
                        int i = 0;
                        for(final position in markLocations ){
                          final marker = Marker (
                              markerId: MarkerId(position.toString()),
                              position: position,
                              icon: icon,
                              infoWindow: InfoWindow(
                                  title: categoryOrgs[i].cname,
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyProfile(id: categoryOrgs.elementAt(0).id)));
                                  }
                              )
                          );
                          i = i + 1;
                          _markers.add(marker);
                        }
                        i = 0;
                      });
                    },
                    values: categories, 
                  ),
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                );
              }
              else return CircularProgressIndicator();
            }
          )
        );

  }
}   
    
