import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/product/product_model.dart';
import '../../logic/services/formatter.dart';
import '../screens/auth/products/product_details_screen.dart';

class ProductPage extends StatelessWidget {
  final List<ProductModel> products;
  const ProductPage({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemBuilder: (context, index) {
        final product = products[index];

        return CupertinoButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              ProductDetailsScreen.routeName,
              arguments: product,
            );
          },
          padding: EdgeInsets.zero,
          child: Card(
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                  imageUrl:
                      "https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco,u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/24750e81-85ed-4b0e-8cd8-becf0cd97b2f/air-jordan-1-mid-shoes-7wnzmw.png",
                  // product.imageURL,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${product.title}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        Formatter.formatPrice(product.price!),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
