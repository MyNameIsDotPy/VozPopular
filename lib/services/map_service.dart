import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'firebase_service.dart';

class MapService extends ChangeNotifier{

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  static Future<Set<Marker>> getMarkers() async {
    final businessQuery = await FirebaseService.getBusiness();
    final businessList = businessQuery.docs;

    Set<Marker> markers = {};

    for(var business in businessList){

      var businessData = business.data();
      GeoPoint location = businessData["location"];
      var icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          size: Size(100 ,100),
        ),
        "assets/images/Location_marker.png"
      );

      final marker = Marker(
        markerId: MarkerId(business.id),
        position: LatLng(location.latitude, location.longitude),
        icon: icon,
        onTap: (){
          
        }
      );
      markers.add(marker);
    }
    return markers;
  }
}
