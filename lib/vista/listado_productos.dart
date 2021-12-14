import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/modelo/producto_dto.dart';
import 'package:proyecto/modelo/tienda_dto.dart';
import 'package:proyecto/persistencia/base_datos.dart';
import 'package:proyecto/persistencia/producto_dao.dart';
import 'package:proyecto/vista/google_maps.dart';
import 'package:proyecto/vista/vista_pedidos.dart';
import 'google_maps.dart';

class VistaProductos extends StatelessWidget
{
  final List<Producto> productos;
  final Tienda _tienda;

  VistaProductos(this.productos, this._tienda);

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'Listado de Productos',
      home: VistaListadoProductos(productos, _tienda),
    );
  }
}

class VistaListadoProductos extends StatefulWidget
{
  final List<Producto> productos;
  final Tienda _tienda;

  VistaListadoProductos(this.productos, this._tienda);

  @override
  State<VistaListadoProductos> createState()
  {
    return _VistaListadoProductosState();
  }
}

class _VistaListadoProductosState extends State<VistaListadoProductos>
{
  var _prodDao = ProductosDao();
  final _biggerFont = const TextStyle(fontSize: 34.0, color: Colors.black87);

  void handleClick(int item)
  {
    switch (item) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GoogleMapsView(widget._tienda)),
        );
        break;
      case 1:
        BaseDatos.db.selectPedido().then((lista_productos)
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VistaPedidos(lista_productos)),
          );
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final _productos = _prodDao.ObtenerProductosDelServidor('4');
    return Scaffold(
      appBar: AppBar(
          title: const Text('Lista de productos: '), backgroundColor: Colors.redAccent,
          actions: <Widget>[
            PopupMenuButton<int>(
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(value: 0, child: Text('Ver mapa')),
                PopupMenuItem<int>(value: 1, child: Text('Ver carrito de Compras')),
              ],
            ),
          ],
      ),
      body: _buildStoresList(),
    );
  }

  Widget _buildStoresList()
  {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        //Visualiza las tiendas que hay en la lista sin repetir
        itemCount: widget.productos.length * 2,
        itemBuilder: (context, i)
        {
          if (i.isOdd)
            return const Divider();
          final index = i ~/ 2;
          return _buildRow(widget.productos[index]);
        }
    );
  }

  Widget _buildRow(Producto pdt)
  {
    return ListTile(
      title: Text(
        pdt.nombre,
        style: _biggerFont,
      ),
      subtitle: Text(new String.fromCharCodes(new Runes('\u0024'))+pdt.precio.toString(), style: TextStyle(fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.bold)),
      leading: Icon(Icons.sports_bar, color: Colors.cyan, size: 40.0,),
      trailing: IconButton(icon: Icon(Icons.add_circle, color: Colors.cyan, size: 50.0),
      onPressed: ()
          {
            pdt.compra = 1;
            BaseDatos.db.insertarProducto(pdt);
          },
      ),
    );
  }
}