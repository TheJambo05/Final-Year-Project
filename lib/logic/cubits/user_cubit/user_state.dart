// Importing user model for user-related data
import '../../../data/models/user/user/user_model.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class ProductAddedState extends UserState {
  final UserModel userModel;
  ProductAddedState(this.userModel);
}

class UserLoggedOutState extends UserState {}

class UserErrorState extends UserState {
  final String message;
  UserErrorState(this.message);
}
