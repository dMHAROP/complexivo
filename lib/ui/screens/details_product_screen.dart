import 'package:complexivodh/data/models/producto.dart';
import 'package:flutter/material.dart';

class DetailsProductoScreen extends StatelessWidget {
  final Producto producto;

  DetailsProductoScreen({required this.producto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles del Producto',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor:
            Colors.purple, // Mismo color que en CreateProductScreen
        elevation: 10,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.blue], // Mismo degradado
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 600, // Limitar el ancho del contenido
              ),
              child: Card(
                color: Colors.white.withOpacity(0.9), // Fondo translúcido
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                      color: Colors.purpleAccent,
                      width: 2), // Borde similar al de CreateProductScreen
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 16),
                      // Información del producto
                      Text(
                        'Descripción: ${producto.description}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Stock: ${producto.stock}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Precio: ${producto.price}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      // Agrega más campos si es necesario
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
