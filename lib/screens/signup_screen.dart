import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screens.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:instagram_clone/utils/utils.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        userName: _userNameController.text,
        password: _passwordController.text,
        bio: _bioController.text,
        file: _image!);

    if (res != 'success') {
      showSnackbar(res, context);
    }else{
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const ResponsiveLayout(mobileScreenLayout: MobileScreenLayout() ,webScreenLayout: WebScreenLayout(),)));
    }

    setState(() {
      _isLoading = false;
    });
  }

  void navigateToLogIn(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const LoginScreen()));
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
            Flexible(child: Container(), flex: 2),
            //svg image
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: primaryColor,
              height: 64,
            ),

            const SizedBox(height: 64),
            //circular widget to accept and show our selected file
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            "data:image/png;base64,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"),
                      ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: () {
                        selectImage();
                      },
                      icon: const Icon(Icons.add_a_photo),
                    ))
              ],
            ),
            const SizedBox(height: 64),
            //text field input for userName
            TextFieldInput(
                textEditingController: _userNameController,
                hintText: "Enter Your Name",
                textInputType: TextInputType.text),
            const SizedBox(height: 24),

            //text field input for email
            TextFieldInput(
                textEditingController: _emailController,
                hintText: "Enter Your Email",
                textInputType: TextInputType.emailAddress),
            const SizedBox(height: 24),
            //text field input for password
            TextFieldInput(
              textEditingController: _passwordController,
              isPaas: true,
              hintText: "Enter Your Password",
              textInputType: TextInputType.text,
            ),
            const SizedBox(height: 24),
            //text field input for bio
            TextFieldInput(
                textEditingController: _bioController,
                hintText: "Enter Your Bio",
                textInputType: TextInputType.text),
            const SizedBox(height: 24),

            //button login
            InkWell(
              onTap: signUpUser,
              child: Container(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: primaryColor,),
                      )
                    : Text("Sign up"),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor),
              ),
            ),

            const SizedBox(height: 12),

            //Transitioning to signing up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text("Don't have an account?"),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                    onTap: navigateToLogIn,
                    child: Container(
                      child: const Text("Log in",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ))
              ],
            )
          ],
        ),
      ),
    ));
  }
}
