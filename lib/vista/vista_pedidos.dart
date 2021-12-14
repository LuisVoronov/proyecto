import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/modelo/producto_dto.dart';
import 'package:proyecto/persistencia/base_datos.dart';

class VistaPedidos extends StatelessWidget
{
  final List<Producto> productos;

  VistaPedidos(this.productos);

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'Listado de pedidos',
      home: VistaListadoPedidos(productos),
    );
  }
}

class VistaListadoPedidos extends StatefulWidget
{
  final List<Producto> productos;

  VistaListadoPedidos(this.productos);

  @override
  State<VistaListadoPedidos> createState()
  {
    return _VistaListadoPedidosState();
  }
}

class _VistaListadoPedidosState extends State<VistaListadoPedidos>
{
  final _biggerFont = const TextStyle(fontSize: 34.0, color: Colors.black87);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Su pedido:'), backgroundColor: Colors.redAccent,
      ),
      body: Container(
        width: double.infinity,
        child: _buildStoresList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(backgroundColor: Color.fromARGB(255, 255, 82, 82),
                content:
                Text('Pedido enviado', style: TextStyle(fontSize: 30.0, color: Colors.white))),
          );
        },
        label: Text('CONFIRMAR PEDIDO', style: TextStyle(fontSize: 20.0, color: Colors.white)),
        icon: Icon(Icons.thumb_up),
        backgroundColor: Colors.cyan,
      ),
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
      title: Text(pdt.nombre, style: _biggerFont),
      subtitle: Text(new String.fromCharCodes(new Runes('\u0024'))+pdt.precio.toString(), style: TextStyle(fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.bold)),
      leading: Icon(Icons.arrow_downward, color: Colors.cyan, size: 40.0,),
      trailing: IconButton(icon: Icon(Icons.delete, color: Colors.red, size: 50.0),
        onPressed: ()
        {
          BaseDatos.db.deletePedido(pdt);
          if (pdt.idTienda == pdt.idTienda)
          {
            BaseDatos.db.selectPedido().then((lista_productos)
            {
              Navigator.push(context, MaterialPageRoute(
              builder: (context) => VistaPedidos(lista_productos)));
            }
            );
          }
        }
      )
    );
  }
}