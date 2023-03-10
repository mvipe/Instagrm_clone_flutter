import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();

  bool _isLoading=false;

  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async{
    setState(() {
      _isLoading=true;
    });
    String res=await AuthMethods().loginUser(email: _emailController.text, password: _passwordController.text);
    print(res);
    if(res=='success'){
Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const ResponsiveLayout(mobileScreenLayout: MobileScreenLayout() ,webScreenLayout: WebScreenLayout(),)));
  
    }else{
      showSnackbar(res, context);
    }
    setState(() {
      _isLoading=false;
    });
  }

  void navigateToSignUp(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SignUpScreen()));
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
                onTap: loginUser,
                child: Container(
                  child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: primaryColor,),
                      ): Text("Log in"),
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
                      onTap: navigateToSignUp,
                      child:Container(

                        child: const Text("Sign Up"
                            ,style:TextStyle(fontWeight: FontWeight.bold)),
                        padding: EdgeInsets.symmetric(vertical: 8),

                      )
                  ),

                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
