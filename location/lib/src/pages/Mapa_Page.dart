import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/src/providers/db_provider.dart';
import 'package:location/src/widgets/Appbar.dart';
import 'package:location/src/widgets/GradientIcon.dart';
import 'package:location/src/widgets/widgets.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  Completer<GoogleMapController> _controller = Completer();

  MapType mapType =  MapType.normal;
  bool valor = false;
  double _height = 65;
  double _opacity = 0;
  
  @override
  Widget build(BuildContext context) {

      final ScanModels? scan = ModalRoute.of(context)!.settings.arguments as ScanModels;

      final CameraPosition puntoInicial = CameraPosition(
        target:  scan!.getLatLng() ,
        zoom: 18.5,
        tilt: 50,
        bearing: 15
      );

      Set<Marker> markers = new Set<Marker>();
      markers.add(new Marker(
        markerId: MarkerId('Punto-Central'),
        position: scan.getLatLng(),
        icon: BitmapDescriptor.defaultMarker
        
        )
      );

     

      timeDilation= 2;
      final size = MediaQuery.of(context).size;

    return Scaffold(
       extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: AppBarWidget(title: "Mapa"),
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () async {
    
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: scan.getLatLng(),
                  zoom: 18.5,
                  tilt: 50
                  )));
                
            },
            child: IconMap())  
        ],
        ),

      body: Stack(
        children: [

          GoogleMap(
            mapType: mapType,
            initialCameraPosition: puntoInicial,
            myLocationButtonEnabled: true,
            trafficEnabled: valor,
            compassEnabled:false,
            zoomControlsEnabled: false,
            padding: EdgeInsets.all(25),
            markers: markers,
            onMapCreated: (GoogleMapController controller) {
              setState(() { 
              _controller.complete(controller);
              });
            },
          ),

          Positioned(

      bottom: size.width * 0.1,
      right: size.width * 0.045,
      child: Stack(
        children: [

           AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              height: _height,
              width: 60,
              // color: Colors.red,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
              children: [
                
                GestureDetector(
                  onTap: () {
                    setState(() {
                      final mapTypeNew = MapType.normal;

                      if (mapType != MapType.normal ) {
                        mapType = mapTypeNew;
                        valor = false;
                      } else {
                         mapType = mapTypeNew;
                         valor = false;
                      } 
                    });
                  },
                  child: Opacity(
                    opacity:_opacity,
                    child: ItemOptions('assets/normal.JPG')
                  ),
                ),


                SizedBox(height: 5),

               GestureDetector(
                  onTap: () {
                    setState(() {
                      final mapTypeNew = MapType.satellite;

                      if (mapType != MapType.satellite ) {
                        mapType = mapTypeNew;
                        valor = false;
                      } else {
                         mapType = mapTypeNew;
                         valor = false;
                      } 
                    });
                  },
                  child: Opacity(
                    opacity:_opacity,
                    child: ItemOptions('assets/satelite.JPG')
                  ),
                ),

                SizedBox(height: 5),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      final mapTypeNew = MapType.normal;
                      final valorFianl = true;
                      if (mapType != MapType.normal ) {
                        mapType = mapTypeNew;
                        valor = valorFianl;
                      } else {
                         mapType = mapTypeNew;
                        valor = valorFianl;
                      } 
                    });
                  },
                  child: Opacity(
                    opacity:_opacity,
                    child: ItemOptions('assets/Calles.JPG')
                  ),
                ),
          
              ],
            ),
        ),
        ),

              Positioned(
                bottom: 0,
                child: GestureDetector(
                  onTap: (){
                    setState(() {
              
                      final double valor = 210;

                      // _height= valor;
              
                      if(_height == 65){
                        _height = valor;
                        Future.delayed(Duration(milliseconds: 200), () {
                          setState(() {
                        _opacity = 1;
                            
                          });
                        });
                      }else {

                        _height = 65;
                        Future.delayed(Duration(milliseconds: 200), () {
                          setState(() {
                        _opacity = 0;
                            
                          });
                        });
                        
                      }
                    });
                  },
                  child: BottomMap(),
                ),
              )
        ],
       
      ),
      
    )
    

        ],
      ),

    );
  } 
}

class ItemOptions extends StatelessWidget {

  final String assetData;

  const ItemOptions(this.assetData) ;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: AssetImage(assetData),
      radius: 22,
    );
  }
}

class IconMap extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      Positioned(   
        // left: 10,
        child: Container(
          margin: EdgeInsets.only(right: 20 , top: 24),
          decoration: BoxDecoration(
            // color: Colors.red,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.blue, width: 0.3)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.4),
              radius: 27,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: GradientIcon( icon: Icons.location_on, size: 34 , gradient: 
                LinearGradient(colors: [Colors.red , Color.fromRGBO(200, 60, 60, 1)]), 
                  )
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}

class BottomMap extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Hero(
      tag: 'Float',
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
 
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                spreadRadius: 1,
                offset: Offset(1, 3)
              )
            ],
            gradient: LinearGradient(colors: [
              Colors.cyan,
              Colors.blue,
            ])),
        child: Icon(
          Icons.web_stories,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
