import 'package:ecommerce_ui/model/product_model.dart';
import 'package:ecommerce_ui/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: isLandscape
          ? Row(
              children: [
                Expanded(
                  child: Image.asset(product.image, fit: BoxFit.cover,),
                ),
                Expanded(
                  child: _buildDetails(),
                ),
              ],
            )
          : Column(
              children: [
                Image.asset(product.image, fit: BoxFit.cover),
                Expanded(child: _buildDetails()),
              ],
            ),
    );
  }

  Widget _buildDetails() {
    return Padding(
      padding:  EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style:  TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
           SizedBox(height: 10),
          Text(
            "₹${product.price}",
            style:  TextStyle(fontSize: 18),
          ),
           SizedBox(height: 10),
          Row(
            children: [
               Icon(Icons.star),
              Text(product.rating.toString()),
            ],
          ),
           SizedBox(height: 20),
          Text(product.description),
           Spacer(),
          Builder(
  builder: (context) {
    return ElevatedButton(
      onPressed: () {
        Provider.of<CartProvider>(context, listen: false)
            .addToCart(product);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Added to cart"),
            duration: Duration(seconds: 1),
          ),
        );
      },
      child: const Text("Add to Cart"),
    );
  },
)
        ],
      ),
    );
  }
}