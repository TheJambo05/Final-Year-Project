import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/user_cubit/user_cubits.dart';
import 'package:jumper/logic/cubits/user_cubit/user_state.dart';

import '../../../../data/models/user/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const String routeName = "edit_profile";

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserErrorState) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is UserLoggedInState) {
            return editProfile(state.userModel);
          }
          return const Center(
            child: Text("An error occured"),
          );
        }),
      ),
    );
  }

  Widget editProfile(UserModel userModel) {
    return ListView();
  }
}
