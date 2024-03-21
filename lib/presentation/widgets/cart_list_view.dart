import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:jumper/data/models/cart/cart_item_model.dart';
import 'package:jumper/presentation/widgets/small_widgets/color.dart';
import '../../logic/cubits/cart_cuibit/cart_cubit.dart';
import '../../logic/services/formatter.dart';

class CartListView extends StatelessWidget {
  final List<CartItemModel> items;
  final bool shrinkWrap;
  final bool noScroll;

  const CartListView(
      {super.key,
      required this.items,
      this.shrinkWrap = false,
      this.noScroll = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: (noScroll) ? const NeverScrollableScrollPhysics() : null,
      shrinkWrap: shrinkWrap,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: '#F5F5F5'.toColor(), // Set container color to amber
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
                style:
                    const TextStyle(color: Colors.black), // Product title color
              ),
              subtitle: Text(
                "${Formatter.formatPrice(item.product!.price!)} x ${item.quantity} = ${Formatter.formatPrice(item.product!.price! * item.quantity!)}",
                style: const TextStyle(color: Colors.black87), // Subtitle color
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 80,
                    child: InputQty(
                      qtyFormProps: const QtyFormProps(enableTyping: false),
                      minVal: 1,
                      maxVal: 99,
                      initVal: item.quantity!,
                      onQtyChanged: (value) {
                        if (value != null) {
                          int intValue = value.toInt();
                          BlocProvider.of<CartCubit>(context)
                              .addToCart(item.product!, intValue);
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
                                  BlocProvider.of<CartCubit>(context)
                                      .removeFromCart(item.product!);
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
    );
  }
}
