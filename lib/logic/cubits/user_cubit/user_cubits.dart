// Importing necessary packages and files
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/data/repositories/user_repository.dart';
import 'package:jumper/logic/cubits/user_cubit/user_state.dart';
import '../../../data/models/user/user_model.dart';
import '../../services/preferences.dart';

// Cubit class responsible for managing user-related state and business logic
class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState()) {
    _initialize();
  }

  final UserRepository _userRepository = UserRepository();

  void _initialize() async {
    final userDetails = await Preferences.fetchUserDetails();
    String? email = userDetails["email"];
    String? password = userDetails["password"];

    if (email == null || password == null) {
      emit(UserLoggedOutState());
    } else {
      signIn(email: email, password: password);
    }
  }

  void _emitLoggedInState({
    required UserModel userModel,
    required String email,
    required String password,
  }) async {
    await Preferences.saveUserDetails(email, password);
    emit(UserLoggedInState(userModel));
  }

  // Method to sign in user
  void signIn({
    required String email,
    required String password,
  }) async {
    emit(UserLoadingState());

    try {
      UserModel userModel =
          await _userRepository.signIn(email: email, password: password);

      _emitLoggedInState(
          userModel: userModel, email: email, password: password);
    } catch (ex) {
      emit(UserErrorState(ex.toString()));
    }
  }

  // Method to create user account
  void createAccount({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String address,
    required String city,
  }) async {
    emit(UserLoadingState());
    try {
      UserModel userModel = await _userRepository.createAccount(
        email: email,
        password: password,
        fullName: fullName, // Pass full name to repository method
        phoneNumber: phoneNumber, // Pass phone number to repository method
        address: address, // Pass address to repository method
        city: city, // Pass city to repository method
      );

      _emitLoggedInState(
          userModel: userModel, email: email, password: password);
    } catch (ex) {
      emit(UserErrorState(ex.toString()));
    }
  }

  void signOut() async {
    //preferences wala code
    await Preferences.clear();
    emit(UserLoggedOutState());
  }
}
