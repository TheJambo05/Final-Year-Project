// product_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/product_cubit/product_state.dart';
import '../../../data/models/product/product_model.dart';
import '../../../data/repositories/product_repository.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState()) {
    _initialize();
  }

  final ProductRepository _productRepository = ProductRepository();

// void sortAndLoad(List<ProductModel> items) {
//     items.sort((a, b) => b.product!.title!.compareTo(a.product!.title!));

//     emit(ProductLoadedState(items));
// }

  void addProduct({
    required String title,
    required String description,
    required String price,
  }) async {
    emit(ProductLoadingState(state.products));

    try {
      ProductModel productModel = await _productRepository.addProduct(
        title: title,
        description: description,
        price: price,
      );
      List<ProductModel> updatedProducts = List.from(state.products)
        ..add(productModel);
      emit(ProductLoadedState(updatedProducts));
    } catch (ex) {
      emit(ProductErrorState(ex.toString(), state.products));
    }
  }

  void _initialize() async {
    emit(ProductLoadingState(state.products));
    try {
      List<ProductModel> products = await _productRepository.fetchAllProducts();
      emit(ProductLoadedState(products));
    } catch (ex) {
      emit(ProductErrorState(ex.toString(), state.products));
    }
  }
}
