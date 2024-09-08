import 'package:flutter/material.dart';
import '../../data/models/producto.dart';
import '../../data/repositories/producto_repository.dart';
import 'create_product_screen.dart';
import 'details_product_screen.dart';
import 'edit_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Producto> _allProducts = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await obtenerProductos();
      setState(() {
        _allProducts = products;
      });
    } catch (e) {
      print('Error loading products: $e');
    }
  }

  Future<void> _refreshProductos() async {
    await _loadProducts();
  }

  Future<void> _deleteProduct(Producto producto) async {
    try {
      await eliminarProducto(producto.id);
      await _refreshProductos();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  Future<void> _editProduct(Producto producto) async {
    final updatedProduct = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductScreen(producto: producto),
      ),
    );

    if (updatedProduct != null) {
      await _refreshProductos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Productos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple, // Color juvenil para la AppBar
        elevation: 10,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.blue],
          ),
        ),
        child: RefreshIndicator(
          onRefresh: _refreshProductos,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  color: Colors.white.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.purpleAccent, width: 2),
                  ),
                  elevation: 8,
                  child: DataTable(
                    columns: [
                      DataColumn(
                          label: Text('ID',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Descripción',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Stock',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Acciones',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                    ],
                    rows: _allProducts.map((producto) {
                      return DataRow(
                        cells: [
                          DataCell(Text(producto.id.toString(),
                              style: TextStyle(fontSize: 14))),
                          DataCell(Text(producto.description,
                              style: TextStyle(fontSize: 14))),
                          DataCell(Text(producto.stock.toString(),
                              style: TextStyle(fontSize: 14))),
                          DataCell(
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    _editProduct(producto);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Eliminar Producto'),
                                        content: Text(
                                            '¿Estás seguro de que deseas eliminar el producto ${producto.description}?'),
                                        actions: [
                                          TextButton(
                                            child: Text('Cancelar'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Eliminar',
                                                style: TextStyle(
                                                    color: Colors.red)),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              _deleteProduct(producto);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                        onSelectChanged: (selected) {
                          if (selected != null && selected) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsProductoScreen(
                                  producto: producto,
                                ),
                              ),
                            );
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateProductScreen()),
          );
          _refreshProductos();
        },
        child: Icon(Icons.add, size: 30),
        backgroundColor: Colors.purple, // Color juvenil para el botón
        foregroundColor: Colors.white, // Color del ícono
        elevation: 8,
        tooltip: 'Nuevo Producto',
      ),
    );
  }
}
