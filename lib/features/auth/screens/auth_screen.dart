import 'package:flutter/material.dart';
import 'package:foody/common/widgets/custom_button.dart';
import 'package:foody/common/widgets/custom_textfield.dart';
import 'package:foody/constants/global_variable.dart';
import 'package:foody/features/auth/services/auth_services.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signInFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();
  final AuthServices authServices = AuthServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authServices.signUpUser(
      context: context,
      email: _emailController.text,
      name: _nameController.text,
      password: _passwordController.text,
    );
  }

  void signInUser() {
    authServices.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'images/a.jpg', // Path to your Amazon logo image asset
                  height: 200,
                ),
                SizedBox(height: 20),
                ListTile(
                  tileColor: _auth == Auth.signup
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundCOlor,
                  title: Text(
                    'Create Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _auth == Auth.signup ? Colors.black : Colors.black,
                    ),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signup,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signup) _buildSignUpForm(),
                ListTile(
                  tileColor: _auth == Auth.signin
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundCOlor,
                  title: Text(
                    'Sign-In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _auth == Auth.signin ? Colors.black : Colors.black,
                    ),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signin) _buildSignInForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpForm() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: GlobalVariables.backgroundColor,
      child: Form(
        key: _signUpFormKey,
        child: Column(
          children: [
            CustomTextField(
              controller: _nameController,
              hintText: 'Name',
            ),
            SizedBox(height: 10),
            CustomTextField(
              controller: _emailController,
              hintText: 'Email',
            ),
            SizedBox(height: 10),
            CustomTextField(
              controller: _passwordController,
              hintText: 'Password',
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Sign Up',
              onTap: () {
                if (_signUpFormKey.currentState!.validate()) {
                  signUpUser();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSignInForm() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: GlobalVariables.backgroundColor,
      child: Form(
        key: _signInFormKey,
        child: Column(
          children: [
            CustomTextField(
              controller: _emailController,
              hintText: 'Email',
            ),
            SizedBox(height: 10),
            CustomTextField(
              controller: _passwordController,
              hintText: 'Password',
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Sign In',
              onTap: () {
                if (_signInFormKey.currentState!.validate()) {
                  signInUser();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
