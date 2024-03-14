import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jumper/logic/cubits/category_cubit/category_cubits.dart';
import 'package:jumper/logic/cubits/category_cubit/category_state.dart';
import 'package:jumper/logic/cubits/product_cubit/product_cubits.dart';
import 'package:jumper/logic/cubits/product_cubit/product_state.dart';

class UserFeedScreen extends StatelessWidget {
  const UserFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadingState && state.products.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is ProductErrorState && state.products.isEmpty) {
          return Center(
            child: Text(state.message),
          );
        }

        return Scaffold(
          backgroundColor: Colors.grey[200], // Changed color to grey[200]
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                  child: Text(
                    "New Arrivals",
                    style: GoogleFonts.belleza(
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(
                  height: 60, // Adjust height according to your UI
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.products.length >= 10
                        ? 10
                        : state.products.length,
                    itemBuilder: (context, index) {
                      final category = state.products[
                          index]; // Get category from state.categories
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            // Filter products based on category selection
                            // BlocProvider.of<ProductCubit>(context)
                            //     .filterProductsByCategory(category.id);
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
                  ),
                ),
                // SingleChildScrollView( // Unnecessary SingleChildScrollView
                //   child: Column(
                //     children: [
                //       Column(
                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                //         children: [
                //           // Post(),
                //           // Post2(),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
