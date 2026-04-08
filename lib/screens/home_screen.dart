import 'package:ecommerce_ui/data/dummy_products.dart';
import 'package:ecommerce_ui/providers/cart_provider.dart';
import 'package:ecommerce_ui/screens/cart_screen.dart';
import 'package:ecommerce_ui/screens/product_detail_screen.dart';
import 'package:ecommerce_ui/screens/settings_screen.dart';
import 'package:ecommerce_ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  int getColumns(double width) {
    if (width < 600) return 2;
    if (width < 900) return 3;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          // ✅ SETTINGS BUTTON (Theme toggle access)
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
          ),

          // 🛒 CART WITH BADGE
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CartScreen(),
                        ),
                      );
                    },
                  ),
                  if (cart.count > 0)
                    Positioned(
                      right: 5,
                      top: 5,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: const Color.fromARGB(255, 125, 218, 244),
                        child: Text(
                          cart.count.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color.fromARGB(255, 12, 12, 12),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getColumns(width),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final product = products[index];

          return ProductCard(
            product: product,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ProductDetailsScreen(product: product),
                ),
              );
            },
            onAdd: () {
              Provider.of<CartProvider>(context, listen: false)
                  .addToCart(product);
            },
          );
        },
      ),
    );
  }
}