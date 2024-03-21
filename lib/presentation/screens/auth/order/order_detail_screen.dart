import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/presentation/widgets/cart_list_view.dart';

import '../../../../data/models/user/user_model.dart';
import '../../../../logic/cubits/cart_cuibit/cart_cubit.dart';
import '../../../../logic/cubits/cart_cuibit/cart_state.dart';
import '../../../../logic/cubits/user_cubit/user_cubits.dart';
import '../../../../logic/cubits/user_cubit/user_state.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  static const routeName = "order_detail";

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Order'),
      ),
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
                    children: [
                      Text(
                        "${user.fullName}",
                        style: TextStyle(),
                      ),
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
          ],
        ),
      ),
    );
  }
}
