import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jumper/data/models/product/product_model.dart';
import 'package:jumper/logic/cubits/cart_cuibit/cart_cubit.dart';
import 'package:jumper/presentation/widgets/small_widgets/login_Button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import '../../../../logic/services/formatter.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel productModel;

  const ProductDetailsScreen({Key? key, required this.productModel})
      : super(key: key);

  static const routeName = "product_details";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _productAdded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.productModel.title}",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  SizedBox(
                    height: 300,
                    child: CarouselSlider.builder(
                      itemCount: widget.productModel.images?.length ?? 0,
                      slideBuilder: (index) {
                        return CachedNetworkImage(
                          imageUrl:
                              "https://i.pinimg.com/564x/09/7c/a0/097ca0b428754128c164b4fc5e050982.jpg",
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Price",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    Formatter.formatPrice(widget.productModel.price!),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  LoginButton(
                    onPressed: () {
                      BlocProvider.of<CartCubit>(context)
                          .addToCart(widget.productModel, 1);
                      setState(() {
                        _productAdded = true;
                      });
                    },
                    text: _productAdded ? "Product Added" : "Add to Cart",
                    color: _productAdded ? Colors.green : null,
                  ),
                  const SizedBox(height: 24),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Description",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${widget.productModel.description}",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
