import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/category_cubit/category_cubits.dart';
import 'package:jumper/logic/cubits/category_cubit/category_state.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoadingState && state.categories.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CategoryErrorState && state.categories.isEmpty) {
          return Center(
            child: Text(
              state.message.toString(),
            ),
          );
        }
        return ListView.builder(
          scrollDirection: Axis.horizontal, // Horizontal scroll
          itemCount: state.categories.length,
          itemBuilder: (context, index) {
            final category = state.categories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  // Navigate to product page passing the category object
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ProductPage(category: category),
                  //   ),
                  // );
                },
                child: Chip(
                  label: Text(
                    "${category.title}",
                    style: const TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.amber,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
