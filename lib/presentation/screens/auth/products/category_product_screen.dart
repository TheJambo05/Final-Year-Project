import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/category_product_cubit/category_product_cubit.dart';
import 'package:jumper/logic/cubits/category_product_cubit/category_product_state.dart';
import 'package:jumper/presentation/widgets/product_page.dart';

class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({super.key});

  static const routeName = "category_product";

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CategoryProductCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${cubit.category.title}"),
      ),
      body: SafeArea(
        child: BlocBuilder<CategoryProductCubit, CategoryProductState>(
          builder: (context, state) {
            if (state is CategoryProductLoadingState &&
                state.products.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CategoryProductLoadedState &&
                state.products.isEmpty) {
              return const Center(
                child: Text("No Products Found"),
              );
            }
            return ProductPage(products: state.products);
          },
        ),
      ),
    );
  }
}
