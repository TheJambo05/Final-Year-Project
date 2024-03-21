import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jumper/logic/cubits/user_cubit/user_cubits.dart';
import 'package:jumper/logic/cubits/user_cubit/user_state.dart';
import 'package:jumper/presentation/widgets/small_widgets/gap_widget.dart';
import 'package:jumper/presentation/widgets/small_widgets/profile_textfield.dart';

import '../../../../data/models/user/user_model.dart';
import '../../../widgets/small_widgets/primary_textfield2.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  static const String routeName = "edit_profile";

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
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
              child: Text("An error occurred"),
            );
          },
        ),
      ),
    );
  }

  Widget editProfile(UserModel userModel) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _getImage,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _image != null
                      ? Image.file(
                          _image!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : const Center(
                          child: Text(
                            'Tap to select image',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileTextField(
                      labelText: "Full Name",
                      initialValue: userModel.fullName,
                      onChanged: (value) {
                        userModel.fullName = value;
                      },
                      placeholder: "Enter your full name",
                      keyboardType: TextInputType.text,
                    ),
                    const GapWidget(),
                    ProfileTextField(
                      labelText: "Email",
                      initialValue: userModel.email,
                      onChanged: (value) {
                        userModel.email = value;
                      },
                      placeholder: "Enter your email",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const GapWidget(),
                    ProfileTextField(
                      labelText: "Phone Number",
                      initialValue: userModel.phoneNumber,
                      onChanged: (value) {
                        userModel.phoneNumber = value;
                      },
                      placeholder: "Enter your phone number",
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () async {
              bool success = await BlocProvider.of<UserCubit>(context)
                  .updateUser(userModel);
              if (success) {
                Navigator.pop(context);
              }
            },
            child: const Text("Save Changes"),
          ),
          const GapWidget(),
          TextButton(
            onPressed: () {
              // Add functionality to upload profile picture
            },
            child: const Text("Upload Profile Picture"),
          ),
        ],
      ),
    );
  }
}
