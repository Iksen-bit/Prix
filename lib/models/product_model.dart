// lib/models/product_model.dart

enum ProductCategory { proteina, quemador, preworkout, comida, otro }

class Product {
  final String id;
  final String name;
  final String description;
  final String imageUrl; // Usaremos URLs por ahora
  final double price;
  final ProductCategory category;
  final Map<String, String> nutritionalInfo; // Ej: {'Calorías': '120', 'Proteína': '25g'}

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.nutritionalInfo,
  });
}