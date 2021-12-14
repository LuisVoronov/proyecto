import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyecto/modelo/tienda_dto.dart';

class GoogleMapsView extends StatelessWidget
{
  final Tienda _tienda;

  GoogleMapsView(this._tienda);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps',
      home: GoogleMapsLocator(_tienda),
    );
  }
}

class GoogleMapsLocator extends StatefulWidget
{
  final Tienda _tienda;

  GoogleMapsLocator(this._tienda);

  @override
  State<GoogleMapsLocator> createState() => GoogleMapsLocatorState();
}

class GoogleMapsLocatorState extends State<GoogleMapsLocator> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context)
  {
    final ll =LatLng(double.parse(widget._tienda.coordenadas.split(',')[0]),
        double.parse(widget._tienda.coordenadas.split(',')[1]));
    final CameraPosition _camaraPrincipal = CameraPosition(
      target: ll,
      zoom: 14,
    );

    final mk = Marker(
          markerId: MarkerId(widget._tienda.id),
          position: ll,
          infoWindow: InfoWindow(
            title: widget._tienda.nombre,
            snippet: widget._tienda.tipo.toString().replaceAll('TipoNegocio.', ''),
          ),
          icon: BitmapDescriptor.defaultMarker,
        );

    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _camaraPrincipal,
        markers: {mk},
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print('Botón precionado');
        },
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }
}