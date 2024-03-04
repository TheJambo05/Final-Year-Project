// Importing necessary packages and files
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/user_cubit/user_state.dart';
import '../../../../logic/cubits/product_cubit/product_cubits.dart';
import '../../../../logic/cubits/product_cubit/product_state.dart';
import '../../../../logic/cubits/user_cubit/user_cubits.dart';

// Class responsible for providing login functionality and managing state
class AddProductProvider with ChangeNotifier {
  final BuildContext context;
  AddProductProvider(this.context) {
    _listenToProductCubit();
  }

  bool isLoading = false;
  String error = "";

  final addProductController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final formkey =
      GlobalKey<FormState>(); // GlobalKey for accessing the form state
  StreamSubscription?
      _addProductSubscription; // Subscription to user state changes

  // Method to listen to changes in the UserCubit
  void _listenToProductCubit() {
    _addProductSubscription =
        BlocProvider.of<ProductCubit>(context).stream.listen(
      (productState) {
        if (productState is ProductLoadingState) {
          isLoading = true; // Setting isLoading to true during loading state
          error = ""; // Clearing any previous error message
          notifyListeners(); // Notifying listeners of state change
        } else if (productState is ProductErrorState) {
          isLoading = false; // Setting isLoading to false
          error =
              productState.message; // Setting error message received from state
          notifyListeners(); // Notifying listeners of state change
        } else {
          isLoading = false; // Setting isLoading to false
          error = ""; // Clearing any previous error message
          notifyListeners(); // Notifying listeners of state change
        }
      },
    );
  }

  // Method to initiate the login process
  void addProduct() async {
    if (!formkey.currentState!.validate()) return;

    String name =
        addProductController.text.trim(); // Extracting email from text field
    String description = descriptionController.text.trim();
    String price = descriptionController.text.trim();
    BlocProvider.of<ProductCubit>(context).addProduct(
        name: name,
        description: description,
        price:
            price); // Initiating sign-in process with provided email and password
  }

  // Method to clean up resources when the provider is disposed
  @override
  void dispose() {
    _addProductSubscription
        ?.cancel(); // Cancelling subscription to user state changes
    super.dispose(); // Calling super class dispose method
  }
}
