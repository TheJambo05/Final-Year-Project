import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/product_cubit/product_state.dart';
import '../../../data/models/user/product/product_model.dart';
import '../../../data/repositories/product_repository.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState()) {
    _initialize();
  }
  final ProductRepository _productRepository = ProductRepository();

  void addProduct({
    required String name,
    required String description,
    required String price,
  }) async {
    try {
      ProductModel productModel = await _productRepository.addProduct(
          name: name, description: description, price: price);
      emit(ProductAddedState(state.products, productModel));
    } catch (ex) {
      emit(ProductErrorState(ex.toString(), state.products));
    }
  }

  void _initialize() async {
    emit(ProductLoadedState(state.products));
    try {
      List<ProductModel> products = await _productRepository.fetchAllProducts();
      emit(ProductLoadedState(products));
    } catch (ex) {
      emit(ProductErrorState(ex.toString(), state.products));
    }
  }
}
