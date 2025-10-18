// lib/widgets/product_item.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/product_model.dart';
import 'package:myapp/cart_provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  // Función para mostrar el pop-up de información
  void _showProductInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(product.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Para que el pop-up no sea gigante
            children: [
              Text(product.description),
              const SizedBox(height: 16),
              const Text('Información Nutrimental:', style: TextStyle(fontWeight: FontWeight.bold)),
              const Divider(),
              // Muestra cada dato nutrimental
              ...product.nutritionalInfo.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${entry.key}:'),
                      Text(entry.value, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cerrar'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Escucha al CartProvider para poder añadir items
    final cart = Provider.of<CartProvider>(context, listen: false);

    return ClipRRect( // Para redondear las esquinas de la tarjeta
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            product.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
          // Botón de información
          leading: IconButton(
            icon: const Icon(Icons.info_outline),
            color: Theme.of(context).colorScheme.secondary, // Usa un color secundario si lo defines
            onPressed: () => _showProductInfo(context),
            tooltip: 'Ver información',
          ),
          // Precio y botón de añadir al carrito
          trailing: Text(
             '\$${product.price.toStringAsFixed(2)}', // Formatea el precio
             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        // La imagen del producto (con manejo de errores)
        child: GestureDetector(
           onTap: () {
            cart.addItem(product);
            // Muestra una confirmación rápida (SnackBar)
            ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Oculta SnackBar anterior si existe
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.name} añadido al carrito!'),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'DESHACER',
                  onPressed: () {
                    cart.removeSingleItem(product.id);
                  },
                ),
              ),
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            // Muestra un indicador mientras carga
            loadingBuilder: (ctx, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            // Muestra un ícono si la imagen falla
            errorBuilder: (ctx, error, stackTrace) => const Center(child: Icon(Icons.broken_image, size: 50)),
          ),
        ),
      ),
    );
  }
}