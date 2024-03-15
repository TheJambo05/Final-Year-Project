import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/data/models/category/category_model.dart';
import 'package:jumper/data/models/product/product_model.dart';
import 'package:jumper/data/repositories/product_repository.dart';
import 'category_product_state.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  final CategoryModel category;

  CategoryProductCubit(this.category) : super(CategoryProductInitialState()) {
    _initialize();
  }

  final _productRepository = ProductRepository();

  void _initialize() async {
    emit(CategoryProductLoadingState(state.products));
    try {
      // Fetch products by category
      final List<ProductModel> products =
          await _productRepository.fetchProductsByCategory(category.sId!);
      emit(CategoryProductLoadedState(products));
    } catch (ex) {
      emit(CategoryProductErrorState(ex.toString(), state.products));
    }
  }
}
