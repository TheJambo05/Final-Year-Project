import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:jumper/logic/cubits/cart_cuibit/cart_cubit.dart';
import 'package:jumper/logic/cubits/cart_cuibit/cart_state.dart';
import 'package:jumper/logic/services/calculations.dart';
import 'package:jumper/logic/services/formatter.dart';
import 'package:jumper/presentation/screens/auth/home/order_screen.dart';
import 'package:jumper/presentation/screens/auth/order/order_detail_screen.dart';
import 'package:jumper/presentation/widgets/cart_list_view.dart';
import 'package:jumper/presentation/widgets/small_widgets/color.dart';

import '../../../widgets/small_widgets/login_Button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key); // Added key parameter

  static const routeName = "cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cart",
          style: TextStyle(color: Colors.black), // Change title color
        ),
        backgroundColor: Colors.white, // Set app bar background color
        iconTheme: const IconThemeData(color: Colors.black), // Set icon color
      ),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoadingState && state.items.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is CartErrorState && state.items.isEmpty) {
              return Center(
                child: Text(
                  state.message,
                  style:
                      const TextStyle(color: Colors.red), // Error message color
                ),
              );
            }
            if (state is CartLoadedState && state.items.isEmpty) {
              return const Center(
                child: Text("Cart item will show here..."),
              );
            }
            return Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: CartListView(items: state.items),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${state.items.length} items",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "Total: ${Formatter.formatPrice(Calculations.cartTotal(state.items))}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: LoginButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, OrderDetailScreen.routeName);
                            },
                            text: "Order",
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
