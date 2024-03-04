import 'package:jumper/data/models/user/product/product_model.dart';

abstract class ProductState {
  final List<ProductModel> products;
  ProductState(this.products);
}

class ProductInitialState extends ProductState {
  ProductInitialState() : super([]);
}

class ProductLoadingState extends ProductState {
  ProductLoadingState(super.products);
}

class ProductAddedState extends ProductState {
  final ProductModel productModel;
  ProductAddedState(super.products, this.productModel);
}

class ProductLoadedState extends ProductState {
  ProductLoadedState(super.products);
}

class ProductErrorState extends ProductState {
  final String message;
  ProductErrorState(this.message, super.products);
}