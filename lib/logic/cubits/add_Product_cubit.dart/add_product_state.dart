// Importing user model for user-related data
import '../../../data/models/product/product_model.dart';

abstract class AddProductState {}

class AddProductInitialState extends AddProductState {}

class AddProductLoadingState extends AddProductState {}

class AddProductLoggedInState extends AddProductState {
  final ProductModel addProductModel;
  AddProductLoggedInState(this.addProductModel);
}

class AddProductLoggedOutState extends AddProductState {}

class AddProductErrorState extends AddProductState {
  final String message;
  AddProductErrorState(this.message);
}
