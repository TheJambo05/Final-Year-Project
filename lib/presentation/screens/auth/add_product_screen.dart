import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jumper/presentation/screens/auth/providers/add_product_provider.dart';
import 'package:jumper/presentation/widgets/gap_widget.dart';
import 'package:provider/provider.dart';
import '../../widgets/login_Button.dart';
import '../../widgets/primary_textfield.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

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
          key: provider.formKey, // Using form key for form validation
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        "Add Product",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  PrimaryTextField(
                    controller: provider.titleController,
                    labelText: "Name of Product",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "(Write your product name.)",
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(color: Colors.black),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  PrimaryTextField(
                    // Text field for password input
                    controller: provider.descriptionController,
                    labelText: "Description",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "(Describe your product briefly to showcase its features and benefits.)",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(color: Colors.black),
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  PrimaryTextField(
                    // Text field for password input
                    controller: provider.priceController,
                    labelText: "Price",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "(Enter the price of your product.)",
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(color: Colors.black),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  LoginButton(
                    // Button for login action
                    onPressed: provider.addProduct,
                    text: (provider.isLoading) ? "..." : "Add Product",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
