import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_carousel_slider/carousel_slider.dart";
import "package:jumper/presentation/widgets/gap_widget.dart";
import '../../../../data/models/product/product_model.dart';
import "../../../../logic/services/formatter.dart";
import "../../../widgets/login_Button.dart";

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductDetailsScreen({super.key, required this.productModel});

  static const routeName = "product_details";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.productModel.title}"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width,
              child: CarouselSlider.builder(
                itemCount: widget.productModel.images?.length ?? 0,
                slideBuilder: (index) {
                  String url = widget.productModel.images![index];

                  return CachedNetworkImage(
                    imageUrl: url,
                  );
                },
              ),
            ),
            const GapWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.productModel.title}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25)),
                  Text(
                    Formatter.formatPrice(widget.productModel.price!),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const GapWidget(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoginButton(
                        // Button for login action
                        onPressed: () {},
                        text: "Add to Cart",
                      ),
                    ],
                  ),
                  const GapWidget(),
                  const Text(
                    "Description",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text(
                    "${widget.productModel.description}",
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
