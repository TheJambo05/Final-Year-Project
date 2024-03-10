import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/product_cubit/product_state.dart';
import '../../../../logic/cubits/product_cubit/product_cubits.dart';

class AddProductProvider with ChangeNotifier {
  final BuildContext context;
  AddProductProvider(this.context) {
    _listenToProductCubit();
  }

  bool isLoading = false;
  String error = "";

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  StreamSubscription? _addProductSubscription;

  void _listenToProductCubit() {
    _addProductSubscription =
        BlocProvider.of<ProductCubit>(context).stream.listen(
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

  void addProduct() async {
    if (!formKey.currentState!.validate()) return;
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();
    String price = priceController.text.trim();
    BlocProvider.of<ProductCubit>(context)
        .addProduct(title: title, description: description, price: price);
  }

  @override
  void dispose() {
    _addProductSubscription?.cancel();
    super.dispose();
  }
}
