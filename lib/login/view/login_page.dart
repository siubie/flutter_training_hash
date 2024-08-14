import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:new_shop/login/bloc/login_bloc.dart';
import 'package:new_shop/login/request/login_request.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? emailController =
      TextEditingController(text: 'ppa@ppa.com');
  TextEditingController? passwordController =
      TextEditingController(text: 'password');
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  bool? _validate() {
    return _form.currentState?.validate();
  }

  @override
  void initState() {
    super.initState();
    //add event to login bloc
    context.read<LoginBloc>().add(SystemCheckTokenEvent());
  }

  @override
  void dispose() {
    emailController!.dispose();
    passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                //if state is LoginSuccess then navigate to /home
                if (state is LoginSuccess) {
                  Navigator.of(context).pushNamed('/home');
                }
              },
              builder: (context, state) {
                if (state is LoginInitial) {
                  //add textformfield for name, email, password
                  return LoginForm(
                      form: _form,
                      emailController: emailController,
                      passwordController: passwordController);
                }
                //if state is login loading then show loading
                if (state is LoginLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return LoginForm(
                  form: _form,
                  emailController: emailController,
                  passwordController: passwordController,
                );
              },
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (_validate() != null && _validate()!) {
                            //call user tap login button event
                            context.read<LoginBloc>().add(
                                  UserTapLoginButtonEvent(
                                    request: LoginRequest(
                                      email: emailController!.text,
                                      password: passwordController!.text,
                                    ),
                                  ),
                                );
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
                    //add text button for register
                    TextButton(
                      onPressed: () {
                        _navigateAndWaitForResult(context);
                      },
                      child: const Text('Register'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateAndWaitForResult(BuildContext context) async {
    //await for navigator push named
    final result = await Navigator.of(context).pushNamed('/register');
    if (!context.mounted) return;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    if (result != null) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('$result'),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {
                // Code to execute when the action is pressed
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
    }
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required GlobalKey<FormState> form,
    required this.emailController,
    required this.passwordController,
  }) : _form = form;

  final GlobalKey<FormState> _form;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            validator: ValidationBuilder().email().build(),
            controller: emailController,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            controller: passwordController,
            validator: ValidationBuilder().minLength(5).maxLength(50).build(),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
