import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:voz_popular/services/firebase_service.dart';
import 'package:voz_popular/services/map_service.dart';
import 'package:voz_popular/widgets/textfield_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class MapSample extends StatefulWidget{
  const MapSample({super.key});


  @override
  State<MapSample> createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {


  Set<Marker> markers = {};

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(4.6484695, -74.1027488),
    zoom: 11.75,
  );

  @override
  void initState() {
    MapService.getMarkers().then((value){
      setState(() {
        markers = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final mapService = Provider.of<MapService>(context);

    BorderRadius slideUpPanelRadius = const BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20)
    );

    return Material(
      child: SlidingUpPanel(
        backdropEnabled: true,
        panel: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        'Tienda Doña Fanny',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 130,
                    child: FutureBuilder(
                      future: FirebaseService.getBusinessImages('TpgP2blwKOhVyZJyu4QJcnzOtgP2'),
                      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                        if(snapshot.hasData){
                          return ListView.builder(
                            padding: const EdgeInsets.all(10),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index){
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  child: Image.network(
                                    snapshot.data![index],
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              );
                            }
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    )
                  ),
                  Text('Cr 13B #31D 03 Sur', style: TextStyle(fontSize: 30),)
                ],
              ),
            ),
          ),
        ),
        borderRadius: slideUpPanelRadius,
        collapsed: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF04364A),
            borderRadius: slideUpPanelRadius
          ),
          child: const Center(
            child: Icon(Icons.arrow_upward, color: Colors.white,),
          ),
        ),
        body: Scaffold(
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: markers,
                ),
                Positioned(
                  left: 10,
                  right: 10,
                  top: 20,
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xFFFFFFFF)
                        ),
                        child: IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back)
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xFFFFFFFF)
                        ),
                        child: IconButton(
                            onPressed: () async {
                              Position userLocation = await mapService.determinePosition();

                              CameraPosition userCameraLocation = CameraPosition(
                                target: LatLng(userLocation.latitude, userLocation.longitude),
                                zoom: 16.75,
                              );

                              final GoogleMapController controller = await _controller.future;
                              await controller.animateCamera(CameraUpdate.newCameraPosition(userCameraLocation));
                            },
                            icon: const Icon(Icons.location_on)
                        ),
                      )
                    ],
                  )
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}