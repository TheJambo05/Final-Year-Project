import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/data/models/cart/cart_item_model.dart';
import 'package:jumper/data/repositories/cart_repository.dart';
import 'package:jumper/logic/cubits/cart_cuibit/cart_state.dart';
import 'package:jumper/logic/cubits/user_cubit/user_cubits.dart';
import 'package:jumper/logic/cubits/user_cubit/user_state.dart';

import '../../../data/models/product/product_model.dart';

class CartCubit extends Cubit<CartState> {
  final UserCubit _userCubit;
  StreamSubscription? _userSubscription;

  CartCubit(this._userCubit) : super(CartInitialState()) {
    //initial value
    _handleUserState(_userCubit.state);

    //Listening to user cubit (for future updates)
    _userSubscription = _userCubit.stream.listen(_handleUserState);
  }

  void _handleUserState(UserState userState) {
    if (userState is UserLoggedInState) {
      _initialize(userState.userModel.sId!);
    } else if (userState is UserLoggedOutState) {
      emit(CartInitialState());
    }
  }

  final _cartRepository = CartRepository();

  void _initialize(String userId) async {
    emit(CartLoadingState(state.items));
    try {
      final items = await _cartRepository.fetchCartForUser(userId);
      emit(CartLoadedState(items));
    } catch (ex) {
      emit(CartErrorState(ex.toString(), state.items));
    }
  }

  void addToCart(ProductModel product, int quantity) async {
    try {
      if (_userCubit.state is UserLoggedInState) {
        UserLoggedInState userState = _userCubit.state as UserLoggedInState;

        CartItemModel newItem =
            CartItemModel(product: product, quantity: quantity);
        final items =
            await _cartRepository.addToCart(newItem, userState.userModel.sId!);
        emit(CartLoadedState(items));
      } else {
        throw "An error occurred while adding the item";
      }
    } catch (ex) {
      emit(CartErrorState(ex.toString(), state.items));
    }
  }

  void removeFromCart(ProductModel product) async {
    try {
      if (_userCubit.state is UserLoggedInState) {
        UserLoggedInState userState = _userCubit.state as UserLoggedInState;

        final items = await _cartRepository.removeFromCart(
            userState.userModel.sId!, product.sId!);
        emit(CartLoadedState(items));
      } else {
        throw "An error occurred while removing the item";
      }
    } catch (ex) {
      emit(CartErrorState(ex.toString(), state.items));
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
