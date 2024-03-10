// // Importing necessary packages and files
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:jumper/data/repositories/user_repository.dart';
// import 'package:jumper/logic/cubits/add_Product_cubit.dart/add_product_state.dart';
// import '../../../data/models/user/product/product_model.dart';
// import '../../../data/repositories/product_repository.dart';

// // Cubit class responsible for managing user-related state and business logic
// class AddProductCubit extends Cubit<AddProductState> {
//   AddProductCubit() : super(AddProductInitialState()) {
//     _initialize();
//   }

//   final ProductRepository _productRepository = ProductRepository();

//   // Method to sign in user
//   void createAccount({
//     required String title,
//     required String description,
//     required String price,
//   }) async {
//     emit(AddProductLoadingState());

//     try {
//       ProductModel products = await _productRepository.createAccount(
//           title: title, description: description, price: price);

//       emit(AddProductLoggedInState(products));
//     } catch (ex) {
//       emit(AddProductErrorState(ex.toString()));
//     }
//   }

//   void _initialize() async {
//     //preferences wala code
//     // await Preferences.clear();
//     emit(AddProductErrorState());
//   }
// }
