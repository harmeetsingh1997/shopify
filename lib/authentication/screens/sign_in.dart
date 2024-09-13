import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/authentication/bloc/sign_up_bloc.dart';
import 'package:shopify/authentication/bloc/sign_up_event.dart';
import 'package:shopify/authentication/bloc/sign_up_state.dart';
import 'package:shopify/authentication/screens/password_reset.dart';
import 'package:shopify/authentication/widgets/custom_button.dart';
import 'package:shopify/product/screens/product_screens.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {


  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade200, Colors.pink.shade100],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: BlocConsumer<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state is SignUpSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>  const ProductScreen()),
                );
              } else if (state is SignUpFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
              else if (state is SignUpWithGoogle){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>  const ProductScreen()),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Sign In',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight*0.05,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Email',
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Password',
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: const Icon(Icons.visibility),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>const ResetPasswordScreen()));
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.tealAccent),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                final email = emailController.text.trim();
                                final password = passwordController.text.trim();
                                context.read<SignUpBloc>().add(
                                  SignInButtonPressed(
                                    email: email,
                                    password: password,
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          const Row(
                            children: [
                              Expanded(
                                child: Divider(color: Colors.white),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'or',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Expanded(
                                child: Divider(color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),

                          SocialSignInButton(
                            icon: Icons.g_translate,
                            text: 'Sign in with Google',
                            color: Colors.redAccent,
                            onPressed: () {
                              context.read<SignUpBloc>().add(GoogleSignInRequested());
                            },
                          ),
                          SizedBox(
                            height: screenHeight*0.02,
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
