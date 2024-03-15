import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:jumper/logic/cubits/cart_cuibit/cart_cubit.dart';
import 'package:jumper/logic/cubits/cart_cuibit/cart_state.dart';
import 'package:jumper/logic/services/calculations.dart';
import 'package:jumper/logic/services/formatter.dart';
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
                    child: ListView.builder(
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final item = state.items[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: '#F5F5F5'
                                  .toColor(), // Set container color to amber
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text(
                                "${item.product?.title}",
                                style: const TextStyle(
                                    color: Colors.black), // Product title color
                              ),
                              subtitle: Text(
                                "${Formatter.formatPrice(item.product!.price!)} x ${item.quantity} = ${Formatter.formatPrice(item.product!.price! * item.quantity!)}",
                                style: const TextStyle(
                                    color: Colors.black87), // Subtitle color
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    child: InputQty(
                                      qtyFormProps: const QtyFormProps(
                                          enableTyping: false),
                                      minVal: 1,
                                      maxVal: 99,
                                      initVal: item.quantity!,
                                      onQtyChanged: (value) {
                                        if (value != null) {
                                          int intValue = value.toInt();
                                          BlocProvider.of<CartCubit>(context)
                                              .addToCart(
                                                  item.product!, intValue);
                                        }
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red.shade300,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Confirmation"),
                                            content: const Text(
                                                "Are you sure you want to remove this item from your cart?"),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                },
                                                child: const Text("No"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  // Remove the item from the cart
                                                  BlocProvider.of<CartCubit>(
                                                          context)
                                                      .removeFromCart(
                                                          item.product!);
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                },
                                                child: const Text("Yes"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
                            onPressed: () {},
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
