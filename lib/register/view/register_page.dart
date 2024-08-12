import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_shop/register/bloc/register_bloc.dart';
import 'package:new_shop/register/request/register_request.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController? nameController = TextEditingController(text: 'ppa');
  TextEditingController? emailController =
      TextEditingController(text: 'ppa@ppa.com');
  TextEditingController? passwordController =
      TextEditingController(text: 'password');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlocConsumer<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is RegisterInitial) {
                    //add textformfield for name, email, password
                    return RegisterForm(
                      nameController: nameController,
                      emailController: emailController,
                      passwordController: passwordController,
                    );
                  }
                  if (state is RegisterLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state is RegisterSuccess) {
                    return Column(
                      children: [
                        const Text('Register Success'),
                        Text('Name: ${state.response.name}'),
                        Text('Email: ${state.response.email}'),
                      ],
                    );
                  }
                  return RegisterForm(
                    nameController: nameController,
                    emailController: emailController,
                    passwordController: passwordController,
                  );
                },
              ),
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  if (state is RegisterSuccess) {
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          //call user tap login button event
                          context.read<RegisterBloc>().add(
                                UserTapLoginButtonEvent(),
                              );
                        },
                        child: const Text('Back To Login'),
                      ),
                    );
                  }
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        //call user tap register button event
                        context.read<RegisterBloc>().add(
                              UserTapRegisterButtonEvent(
                                request: RegisterRequest(
                                  name: nameController!.text,
                                  email: emailController!.text,
                                  password: passwordController!.text,
                                ),
                              ),
                            );
                      },
                      child: const Text('Register'),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController? nameController;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Name',
          ),
          controller: nameController,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Email',
          ),
          controller: emailController,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
          obscureText: true,
          controller: passwordController,
        ),
      ],
    );
  }
}
