import 'package:ecommerce_ui/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onAdd;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.asset(product.image),
              ),
              const SizedBox(height: 5),
              Text(
  product.name,
  style: const TextStyle(
    fontWeight: FontWeight.bold, // Title
  ),
),

Text(
  "₹${product.price}",
  style: const TextStyle(
    fontWeight: FontWeight.w600, // Price
  ),
),

Text(
  "Nice product",
  style: const TextStyle(
    fontWeight: FontWeight.w300, // Description
  ),
),
              Row(
                children: [
                  const Icon(Icons.star, size: 16),
                  Text(product.rating.toString()),
                ],
              ),
              ElevatedButton(
                onPressed: onAdd,
                child: const Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}