import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/presentation/screens/auth/order/order_placed_screen.dart';
import 'package:jumper/presentation/screens/auth/providers/order_detail_provider.dart';
import 'package:jumper/presentation/widgets/cart_list_view.dart';
import 'package:jumper/presentation/widgets/small_widgets/gap_widget.dart';
import 'package:jumper/presentation/widgets/small_widgets/primary_button.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/user/user_model.dart';
import '../../../../logic/cubits/cart_cuibit/cart_cubit.dart';
import '../../../../logic/cubits/cart_cuibit/cart_state.dart';
import '../../../../logic/cubits/order_cubit/order_cubit.dart';
import '../../../../logic/cubits/user_cubit/user_cubits.dart';
import '../../../../logic/cubits/user_cubit/user_state.dart';
import '../../../widgets/small_widgets/login_Button.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({Key? key});

  static const routeName = "order_detail";

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoadingState) {
                  return const CircularProgressIndicator();
                }
                if (state is UserLoggedInState) {
                  UserModel user = state.userModel;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${user.fullName}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const GapWidget(),
                      const Text(
                        "Items",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  );
                }
                if (state is UserErrorState) {
                  return Text(state.message);
                }
                return const SizedBox();
              },
            ),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is CartLoadingState && state.items.isEmpty) {
                  return const CircularProgressIndicator();
                }
                if (state is CartErrorState && state.items.isEmpty) {
                  return Text(state.message);
                }

                return CartListView(
                  items: state.items,
                  noScroll: true,
                  shrinkWrap: true,
                );
              },
            ),
            const GapWidget(),
            const Text(
              "Payments",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Consumer<OrderDetailProvider>(
              builder: (context, provider, child) {
                return Column(
                  children: [
                    RadioListTile(
                      value: "pay-on-delivery",
                      groupValue: provider.paymentMethod,
                      contentPadding: EdgeInsets.zero,
                      onChanged: provider.changePaymentMethod,
                      title: const Text("Pay on delivery"),
                    ),
                    RadioListTile(
                      value: "pay-now",
                      groupValue: provider.paymentMethod,
                      contentPadding: EdgeInsets.zero,
                      onChanged: provider.changePaymentMethod,
                      title: const Text("Pay now"),
                    ),
                  ],
                );
              },
            ),
            const GapWidget(),
            LoginButton(
              onPressed: () async {
                bool success =
                    await BlocProvider.of<OrderCubit>(context).createOrder(
                  items: BlocProvider.of<CartCubit>(context).state.items,
                  paymentmethod:
                      Provider.of<OrderDetailProvider>(context, listen: false)
                          .paymentMethod
                          .toString(),
                );
                if (success) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushNamed(context, OrderPlacedScreen.routeName);
                }
              },
              text: "Place Order",
            ),
          ],
        ),
      ),
    );
  }
}
