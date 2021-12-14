import 'package:flutter/material.dart';
import 'package:proyecto/modelo/tienda_dto.dart';
import 'package:proyecto/persistencia/producto_dao.dart';
import 'package:proyecto/persistencia/tienda_dao.dart';

import 'listado_productos.dart';

class VistaTiendas extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'Listado de Tiendas',
      home: VistaListadoTiendas(),
    );
  }
}

class VistaListadoTiendas extends StatefulWidget
{
  @override
  State<VistaListadoTiendas> createState()
  {
    return _VistaListadoTiendasState();
  }
}

class _VistaListadoTiendasState extends State<VistaListadoTiendas>
{
  final _stores = TiendasDao.tiendas;
  final _biggerFont = const TextStyle(fontSize: 34.0, color: Colors.black87);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tiendas Afiliadas'), backgroundColor: Colors.redAccent
      ),
      body: _buildStoresList(),
    );
  }

  Widget _buildStoresList()
  {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        //Visualiza las tiendas que hay en la lista sin repetir
        itemCount: _stores.length * 2,
        itemBuilder: (context, i)
        {
          if (i.isOdd)
            return const Divider();
          final index = i ~/ 2;
          return _buildRow(_stores[index]);
        }
    );
  }

  Widget _buildRow(Tienda st)
  {
    return ListTile(
      title: Text(
        st.nombre,
        style: _biggerFont,
      ),
      subtitle: Text(st.direccion, style: TextStyle(fontSize: 15.0, color: Colors.orange)),
      leading: Image.network("https://drive.google.com/uc?export=view&id=" + st.logo),
      trailing: Icon(Icons.shopping_basket_rounded, color: Colors.cyan, size: 40.0),
      onTap: () {
        var pDao = ProductosDao();
        pDao.ObtenerProductosDelServidor(st.id).then((lista_productos) =>
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VistaProductos(lista_productos, st)),
            ),
        );
      },
    );
  }
}