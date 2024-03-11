import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const routeName = "cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(
                // leading: ,
                title: const Text("Product Name"),
                subtitle: const Text("price x quantity = total"),
                trailing: InputQty(
                  onQtyChanged: (value) {},
                ));
          },
        ),
      ),
    );
  }
}
