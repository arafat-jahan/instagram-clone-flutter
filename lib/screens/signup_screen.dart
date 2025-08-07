import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';

import '../utils/colors.dart';
import '../utils/utils.dart';

// Custom TextFieldInput widget (constructor + design)
class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  Uint8List? _image;

   TextFieldInput({
    Key? key,
    required this.textEditingController,
    required this.isPass,
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: textInputType,
      obscureText: isPass,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

// ✅ Main Login Screen
class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Controller create korchi
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;

  // Memory leak na hoy, tai dispose()
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();


  }
  void selectImage() async{
    Uint8List? im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;

    });

  }
void signUpUser() async {
  String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo or top spacing
              Flexible(child: Container(), flex: 2),
              //svg image

              // App name
              // SVG Instagram logo
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 64),
              //circle widget to accept and  show our selected file
              Stack(
                children: [
                  _image!=null?CircleAvatar(
                    radius: 64,
                    backgroundImage:MemoryImage(_image!)
                  )
                 : const CircleAvatar(
                    radius: 64,
                    backgroundImage:NetworkImage('https://i.stack.imgur.com/l60Hf.png') ,
                  ),
                  Positioned(

                    bottom: -10,
                    left: 80,
                    child:IconButton (onPressed: selectImage,
                      icon:const Icon(Icons.add_a_photo) ,),),

                ],
              ),
              const SizedBox(height: 24),

              //textfld input for username
              TextFieldInput(
                hintText: 'Enter your username',
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
                isPass: true,
              ),
              const SizedBox(height: 24),


              // Email input
              TextFieldInput(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
                isPass: false,
              ),
              const SizedBox(height: 24),

              // Password input
              TextFieldInput(
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),
              const SizedBox(height: 24),

              //textfld input for bio
              TextFieldInput(
                hintText: 'Enter your bio',
                textInputType: TextInputType.text,
                textEditingController: _bioController,
                isPass: true,
              ),

              // Login button
              InkWell(
                onTap: signUpUser,


                child: Container(
                  child: const Text('Log in'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: Colors.blue, // Button background color
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Transition to sign up
              Flexible(child: Container(), flex: 2),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Don't have an account?"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to sign up screen
                    },
                    child: Container(
                      child: const Text(
                        'Sign up',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}