import 'package:flutter/material.dart';
import '../../data/models/producto.dart';
import '../../data/repositories/producto_update_repository.dart';

class EditProductScreen extends StatefulWidget {
  final Producto producto;

  EditProductScreen({required this.producto});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _descriptionController = TextEditingController();
  final _stockController = TextEditingController();
  final _priceController = TextEditingController();

  final productoUpdateRepository = ProductoUpdateRepository();

  @override
  void initState() {
    super.initState();
    _descriptionController.text = widget.producto.description;
    _stockController.text = widget.producto.stock.toString();
    _priceController.text = widget.producto.price;
  }

  void _updateProduct() async {
    final updatedProducto = Producto(
      id: widget.producto.id,
      description: _descriptionController.text,
      stock: int.tryParse(_stockController.text) ?? 0,
      price: _priceController.text,
    );

    try {
      await productoUpdateRepository.actualizarProducto(updatedProducto);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Producto actualizado con éxito',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(
          context, updatedProducto); // Retorna el producto actualizado
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar producto')),
      );
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Producto',
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 600, // Limitar ancho del contenido
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(
                      color: Colors.white.withOpacity(0.9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.purpleAccent, width: 2),
                      ),
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _descriptionController,
                              decoration: InputDecoration(
                                labelText: 'Descripción',
                                labelStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide(
                                    color: Colors.purpleAccent,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _stockController,
                              decoration: InputDecoration(
                                labelText: 'Stock',
                                labelStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide(
                                    color: Colors.purpleAccent,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.9),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _priceController,
                              decoration: InputDecoration(
                                labelText: 'Precio',
                                labelStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide(
                                    color: Colors.purpleAccent,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.9),
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                            ),
                            SizedBox(height: 24.0),
                            ElevatedButton(
                              onPressed: _updateProduct,
                              child: Text('Guardar Cambios'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.purple,
                                minimumSize: Size(double.infinity, 50),
                                padding: EdgeInsets.symmetric(vertical: 14.0),
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                elevation: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
