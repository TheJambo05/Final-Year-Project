import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/cart_cuibit/cart_cubit.dart';
import 'package:jumper/logic/cubits/order_cubit/order_state.dart';
import '../../../data/models/cart/cart_item_model.dart';
import '../../../data/models/order/order_model.dart';
import '../../../data/repositories/order_repository.dart';
import '../user_cubit/user_cubits.dart';
import '../user_cubit/user_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final UserCubit _userCubit;
  final CartCubit _cartCubit;
  StreamSubscription? _userSubscription;

  OrderCubit(this._userCubit, this._cartCubit) : super(OrderInitialState()) {
    //initial value
    _handleUserState(_userCubit.state);

    //Listening to user cubit (for future updates)
    _userSubscription = _userCubit.stream.listen(_handleUserState);
  }

  void _handleUserState(UserState userState) {
    if (userState is UserLoggedInState) {
      _initialize(userState.userModel.sId!);
    } else if (userState is UserLoggedOutState) {
      emit(OrderInitialState());
    }
  }

  final _orderRepository = OrderRepository();

  void _initialize(String userId) async {
    emit(OrderLoadingState(state.orders));
    try {
      final orders = await _orderRepository.fetchOrdersForUser(userId);
      emit(OrderLoadedState(orders));
    } catch (ex) {
      emit(OrderErrorState(ex.toString(), state.orders));
    }
  }

  Future<bool> createOrder(
      {required List<CartItemModel> items,
      required String paymentmethod}) async {
    emit(OrderLoadingState(state.orders));
    try {
      if (_userCubit.state is! UserLoggedInState) {
        return false;
      }
      OrderModel newOrder = OrderModel(
          user: (_userCubit.state as UserLoggedInState).userModel,
          items: items,
          status: (paymentmethod == "pay-on-delivery")
              ? "order-placed"
              : "payment-pending");
      final order = await _orderRepository.createOrder(newOrder);

      List<OrderModel> orders = [...state.orders, order];

      emit(OrderLoadedState(orders));

      //clear the cart
      _cartCubit.clearCart();
      return true;
    } catch (ex) {
      emit(OrderErrorState(ex.toString(), state.orders));
      return false;
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
