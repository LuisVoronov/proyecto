import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/persistencia/base_datos.dart';
import 'package:proyecto/vista/form_nuevo_cliente.dart';
import 'package:proyecto/vista/listado_tiendas.dart';
import 'package:proyecto/vista/vista_pedidos.dart';

class ProyectoMainView extends StatefulWidget
{
  @override
  State<ProyectoMainView> createState() => _ProyectoMainViewState();
}

class _ProyectoMainViewState extends State<ProyectoMainView> {
  List<String> images = [
    "images/listado_tiendas.png",
    "images/registro_clientes.png",
    "images/realizar_pedido.png",
    "images/configuracion.png"
  ];

  @override void initState()
  {
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen( (message)
    {
      if (message.notification != null)
      {
        print(message.notification!.body);
        print(message.notification!.title);
      }
      print(message);
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen( (messagge)
    {
      final routeMessagge = messagge.data["route"];
      },
    );
    super.initState();
  }

  Widget buildCelda(BuildContext context, index)
  {
      return GestureDetector(
        onTap: () {
          if(index == 0)
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VistaTiendas()),
            );
          }
          else if(index == 1)
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VistaNuevoCliente()),
            );
          }
          else if(index == 2)
          {
            BaseDatos.db.selectPedido().then((lista_productos)
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VistaPedidos(lista_productos)),
              );
            });
          }
          else if(index == 3)
          {
            //TODO: No olvidar implementar abrir la vista de pedidos
          }
        },
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(8),
          child: Image.asset(images[index]),
        ),
      );
  }

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text("Pedidos en Línea.com"), backgroundColor: Colors.redAccent),
        body: Container(
            padding: EdgeInsets.all(12.0),
            child: GridView.builder(
              itemCount: images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (context, index) => buildCelda(context, index),
            )),
      ),
    );
  }
}