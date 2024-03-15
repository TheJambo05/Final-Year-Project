import 'package:flutter/material.dart';
import 'package:jumper/data/models/category/category_model.dart';
import 'package:jumper/presentation/screens/auth/products/category_product_screen.dart';

class ProductListView extends StatelessWidget {
  final List<CategoryModel> categories;

  const ProductListView({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, CategoryProductScreen.routeName,
                  arguments: category);
            },
            child: Chip(
              label: Text(
                "${category.title}",
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black87,
            ),
          ),
        );
      },
    );
  }
}
