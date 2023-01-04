import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();

  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width:double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(),flex:2),
              //svg image
                SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  color: primaryColor,
                  height: 64,
                ),
              const SizedBox(height: 64),
              //text field input for email
              TextFieldInput(textEditingController: _emailController,
                  hintText: "Enter Your Email",
                  textInputType: TextInputType.emailAddress),
              const SizedBox(height: 24),
              //text field input for password
              TextFieldInput(textEditingController: _passwordController,
                isPaas: true,
                  hintText: "Enter Your Password",
                  textInputType: TextInputType.text,
                  ),

              const SizedBox(height: 24),

              //button login
              InkWell(
                child: Text("Log in"),
                width: double.infinity,
                alignment : Alignment.center,
                padding : const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4)
                      ),
                    ),
                    color:blueColor
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
                    onTap: (){},
                    child: const Text("Sign Up"
                     ,style:TextStyle(fontWeight: FontWeight.bold)),
                    padding: EdgeInsets.symmetric(vertical: 8),

                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
