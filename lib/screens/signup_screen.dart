import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';
import 'package:instagram_clone/resources/auth_methods.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final TextEditingController _bioController=TextEditingController();
  final TextEditingController _userNameController=TextEditingController();

  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
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
                //circular widget to accept and show our selected file
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1672782653936-2f152a7e0a70?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80"
                      ),
                    ),

                    Positioned(
                        bottom:-10,
                        left:80,
                        child: IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.add_a_photo),
                    ))
                  ],
                ),
                const SizedBox(height: 64),
                //text field input for userName
                TextFieldInput(textEditingController: _userNameController,
                    hintText: "Enter Your Name",
                    textInputType: TextInputType.text),
                const SizedBox(height: 24),

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
                //text field input for bio
                TextFieldInput(textEditingController: _bioController,
                    hintText: "Enter Your Bio",
                    textInputType: TextInputType.text),
                const SizedBox(height: 24),



                //button login
                InkWell(
                  onTap: () async {
                    String res= await AuthMethods().signUpUser(
                    email: _emailController.text,
                    userName: _userNameController.text,
                    password: _passwordController.text,
                    bio: _bioController.text);

                    print("res"+res);
                  },
                    child:Container(
                          child: Text("Sign up"),
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
                        child:Container(
                          child: const Text("Log in"
                              ,style:TextStyle(fontWeight: FontWeight.bold)),
                          padding: EdgeInsets.symmetric(vertical: 8),

                        )
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
