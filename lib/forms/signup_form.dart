import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../extensions/validation.dart';
import '../resources/auth_methods.dart';
import '../utils/colors.dart';
import '../utils/screen.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);

    setState(() {
      _image = img;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      profilePicture: _image!,
    );

    setState(() {
      _isLoading = false;
    });

    // if (res != 'User added successfully') {
    //   showSnackBar(res, context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    double percentage = Screen.isWeb(context) ? 30 : double.infinity;
    final width = Screen.width(context, percentage: percentage);

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          //Profile Image
          Stack(
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_image!),
                    )
                  : const CircleAvatar(
                      radius: 64,
                      backgroundImage: AssetImage('assets/default_profile.jpg'),
                    ),
              Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                  onPressed: () => selectImage(),
                  icon: const Icon(Icons.add_a_photo, color: blueColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          //Text input username
          SizedBox(
            width: width,
            child: TextFieldInput(
              hintText: 'Choose a username',
              textInputType: TextInputType.text,
              textEditingController: _usernameController,
              // inputFormatters: [
              //   FilteringTextInputFormatter.allow(
              //     RegExp(r"[a-zA-Z]+|\s"),
              //   )
              // ],
              // validator: (val) {
              //   if (val != null && !val.isValidName) return 'Enter valid name';
              // },
            ),
          ),
          const SizedBox(height: 24),

          //Text input email
          SizedBox(
            width: width,
            child: TextFieldInput(
              hintText: 'Enter your email',
              textInputType: TextInputType.emailAddress,
              textEditingController: _emailController,
              // validator: (val) {
              //   if (val != null && !val.isValidEmail)
              //     return 'Enter valid email address';

              //   return null;
              // },
            ),
          ),
          const SizedBox(height: 24),

          //Text input password
          SizedBox(
            width: width,
            child: TextFieldInput(
              hintText: 'Enter your password',
              textInputType: TextInputType.text,
              isPassword: true,
              textEditingController: _passwordController,
              // validator: (val) {
              //   if (val != null && !val.isValidPassword) {
              //     return 'Use an uppercase, lowercase, digit, and special character. 8 characters minimum';
              //   }

              //   return null;
              // },
            ),
          ),
          const SizedBox(height: 24),

          // //Text input confirm password
          // SizedBox(
          //   width: width,
          //   child: TextFieldInput(
          //     hintText: 'Confirm password',
          //     textInputType: TextInputType.text,
          //     isPassword: true,
          //     textEditingController: _passwordConfirmController,
          //     validator: (val) {
          //       if (val != null && val != _passwordController.text) {
          //         return 'Passwords don\'t match';
          //       }

          //       return null;
          //     },
          //   ),
          // ),
          // const SizedBox(height: 24),

          //Text input bio
          SizedBox(
            width: width,
            child: TextFieldInput(
              hintText: 'Enter your bio',
              textInputType: TextInputType.text,
              textEditingController: _bioController,
              // validator: (val) {
              //   if (val != '') return 'Bio can\'t be blank';

              //   return null;
              // },
            ),
          ),
          const SizedBox(height: 24),

          //Sign up button
          InkWell(
            // TODO: Add validation to compare passwords for equality etc
            onTap: () => signUpUser(),
            child: Container(
              height: 48,
              child: _isLoading
                  ? const Center(
                      child: SizedBox(
                        height: 35,
                        width: 35,
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
                    )
                  : const Text('Sign up'),
              width: width,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                color: blueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
