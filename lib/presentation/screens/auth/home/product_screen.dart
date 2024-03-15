import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/presentation/widgets/product_page.dart';
import 'package:jumper/presentation/widgets/product_list_view.dart';
import '../../../../logic/cubits/product_cubit/product_cubits.dart';
import '../../../../logic/cubits/product_cubit/product_state.dart';
import '../../../../logic/cubits/category_cubit/category_cubits.dart';
import '../../../../logic/cubits/category_cubit/category_state.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<CategoryCubit, CategoryState>(
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
              return SizedBox(
                  height: 60, // Adjust height according to your UI
                  child: ProductListView(categories: state.categories));
            },
          ),
          Expanded(
            child: BlocBuilder<ProductCubit, ProductState>(
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

                return ProductPage(products: state.products);
              },
            ),
          ),
        ],
      ),
    );
  }
}
