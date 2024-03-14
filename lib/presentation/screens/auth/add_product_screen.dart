import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jumper/presentation/screens/auth/providers/add_product_provider.dart';
import 'package:jumper/presentation/widgets/primary_textfield2.dart';
import 'package:provider/provider.dart';
import '../../widgets/login_Button.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  static const String routeName = "addProduct";

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddProductProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: provider.formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Product",
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                PrimaryTextField2(
                  controller: provider.titleController,
                  labelText: "Name of Product",
                  placeholder: "Enter product name",
                ),
                const SizedBox(height: 10),
                const Text(
                  "Write your product name",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                PrimaryTextField2(
                  controller: provider.descriptionController,
                  labelText: "Description",
                  placeholder: "Enter product description",
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Describe your product briefly",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                PrimaryTextField2(
                  controller: provider.priceController,
                  labelText: "Price",
                  placeholder: "Enter product price",
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Enter the price of your product",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Center(
                  // Wrapping LoginButton with Center widget
                  child: LoginButton(
                    onPressed: provider.addProduct,
                    text: (provider.isLoading) ? "..." : "Add Product",
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
