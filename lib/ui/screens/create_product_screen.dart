import 'package:flutter/material.dart';
import '../../data/models/producto.dart';
import '../../data/repositories/producto_creation_repository.dart';

class CreateProductScreen extends StatefulWidget {
  @override
  _CreateProductScreenState createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _descriptionController = TextEditingController();
  final _stockController = TextEditingController();
  final _priceController = TextEditingController();

  final productoCreationRepository = ProductoCreationRepository();

  void _crearProducto() async {
    final description = _descriptionController.text;
    final stock = int.tryParse(_stockController.text) ?? 0;
    final price = _priceController.text;

    final producto = Producto(
      id: 0, // El ID será generado por el servidor
      description: description,
      stock: stock,
      price: price,
    );

    try {
      await productoCreationRepository.crearProducto(producto);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Producto creado con éxito',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al crear producto')),
      );
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crear Nuevo Producto',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple, // Mismo color que en ProductListScreen
        elevation: 10,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.blue], // Degradado similar
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 600, // Limitar ancho del contenido
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCardField(
                    controller: _descriptionController,
                    label: 'Descripción',
                    hint: 'Ingrese la descripción del producto',
                  ),
                  SizedBox(height: 16.0),
                  _buildCardField(
                    controller: _stockController,
                    label: 'Stock',
                    hint: 'Ingrese el stock disponible',
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16.0),
                  _buildCardField(
                    controller: _priceController,
                    label: 'Precio',
                    hint: 'Ingrese el precio del producto',
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: _crearProducto,
                    child: Text('Guardar Producto'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Colors.purple, // Mismo color del botón flotante
                      minimumSize: Size(double.infinity, 50),
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      textStyle: TextStyle(
                        fontSize: 16,
                      ),
                      elevation: 8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return Card(
      color: Colors.white.withOpacity(0.9), // Fondo translúcido
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
            color: Colors.purpleAccent,
            width: 2), // Mismo estilo que en ProductListScreen
      ),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.purple, // Color al enfocar
                    width: 2,
                  ),
                ),
              ),
              keyboardType: keyboardType,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.purple[300],
      thickness: 1,
    );
  }
}
