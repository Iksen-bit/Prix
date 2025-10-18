// lib/shop_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/cart_provider.dart';
import 'package:myapp/data/dummy_data.dart';
import 'package:myapp/models/product_model.dart';
import 'package:myapp/widgets/product_item.dart';
import 'package:myapp/cart_page.dart';
// Importaremos cart_page.dart más adelante
// import 'package:myapp/cart_page.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  ProductCategory? _selectedCategory; // Null significa mostrar todos

  // Función para obtener el nombre legible de la categoría
  String _getCategoryName(ProductCategory category) {
    switch (category) {
      case ProductCategory.proteina: return 'Proteína';
      case ProductCategory.quemador: return 'Quemador';
      case ProductCategory.preworkout: return 'Pre-entreno';
      case ProductCategory.comida: return 'Comida';
      case ProductCategory.otro: return 'Otros';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filtra los productos según la categoría seleccionada
    final List<Product> displayedProducts = _selectedCategory == null
        ? allProducts
        : allProducts.where((prod) => prod.category == _selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda de Suplementos'),
        actions: [
          // Widget para mostrar el número de items en el carrito y navegar a él
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge( // Widget Badge para el contador
              label: Text(cart.itemCount.toString()),
              child: ch!,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                // ***** CAMBIO AQUÍ *****
                // Navegar a la página del carrito
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => const CartPage()));
                // print('Navegar al carrito'); // Elimina el placeholder
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de Filtros
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: SizedBox(
              height: 50, // Altura fija para los botones
              child: ListView(
                scrollDirection: Axis.horizontal, // Scroll horizontal
                children: [
                  // Botón para mostrar "Todos"
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: FilterChip(
                      label: const Text('Todos'),
                      selected: _selectedCategory == null,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = null;
                        });
                      },
                    ),
                  ),
                  // Botones para cada categoría
                  ...ProductCategory.values.map((category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: FilterChip(
                        label: Text(_getCategoryName(category)),
                        selected: _selectedCategory == category,
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory = selected ? category : null;
                          });
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Cuadrícula de Productos
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: displayedProducts.length,
              // Define cómo se ve cada item usando nuestro widget ProductItem
              itemBuilder: (ctx, i) => ProductItem(product: displayedProducts[i]),
              // Define la estructura de la cuadrícula
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columnas
                childAspectRatio: 2 / 3, // Proporción ancho/alto de cada tarjeta
                crossAxisSpacing: 10, // Espacio horizontal entre tarjetas
                mainAxisSpacing: 10, // Espacio vertical entre tarjetas
              ),
            ),
          ),
        ],
      ),
    );
  }
}