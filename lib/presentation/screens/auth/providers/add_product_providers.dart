// Importing necessary packages and files
import 'dart:async'; // Dart package for asynchronous programming
import 'dart:developer';
import 'package:flutter/material.dart'; // Flutter package for building UI
import 'package:flutter_bloc/flutter_bloc.dart'; // Flutter package for implementing BLoC architecture
import 'package:jumper/logic/cubits/product_cubit/product_cubits.dart';
import 'package:jumper/logic/cubits/product_cubit/product_state.dart';

// Class responsible for providing login functionality and managing state
class AddProductProvider with ChangeNotifier {
  final BuildContext context;
  AddProductProvider(this.context) {
    _listenToAddProductCubit();
  }

  bool isLoading = false;
  String error = "Errorrrrrrrrr";

  final newProductController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  StreamSubscription? _productSubscription;

  // Method to listen to changes in the UserCubit
  void _listenToAddProductCubit() {
    log("Sandip don dadadadadadad");
    _productSubscription = BlocProvider.of<ProductCubit>(context).stream.listen(
      (productState) {
        if (productState is ProductLoadingState) {
          isLoading = true;
          error = "";
          notifyListeners();
        } else if (productState is ProductErrorState) {
          isLoading = false;
          error = productState.message;
          notifyListeners();
        } else {
          isLoading = false;
          error = "";
          notifyListeners();
        }
      },
    );
  }

  // Method to initiate the login process
  void addProduct() async {
    if (!formkey.currentState!.validate()) return;

    String name = newProductController.text.trim();
    String description = descriptionController.text.trim();
    String price = priceController.text.trim();
    BlocProvider.of<ProductCubit>(context)
        .addProduct(name: name, description: description, price: price);
  }

  @override
  void dispose() {
    _productSubscription?.cancel();
    super.dispose();
  }
}
