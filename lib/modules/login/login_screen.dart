import 'package:bmi_a/shared/components/components.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword =true;
  IconData suffixIcon = Icons.visibility;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: 'Email',
                    prefixIcon: Icons.email,
                    validate: (value) {
                      if((value??'').isEmpty){
                        return'email must not be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    label: 'Password',
                    prefixIcon: Icons.lock,
                    suffixIcon: isPassword ? Icons.visibility : Icons.visibility_off,
                    isPassword: isPassword,
                    validate: (value) {
                      if((value??'').isEmpty){
                        return'password is too short';
                      }
                      return null;
                    },
                    suffixIconOnPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        print(emailController.text);
                        print(passwordController.text);
                      }
                    },
                    text: 'login',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    onPressed: () {
                      print(emailController.text);
                      print(passwordController.text);
                    },
                    text: 'ReGIster',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account ?'),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Register Now'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
