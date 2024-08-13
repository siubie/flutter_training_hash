import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
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
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  bool? _validate() {
    return _form.currentState?.validate();
  }

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
                  if (state is RegisterFailed) {
                    final List<String>? errorMessage = state.response.message;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: errorMessage!
                              .map((e) => Text(
                                    e,
                                    style: const TextStyle(fontSize: 16),
                                  ))
                              .toList(),
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is RegisterInitial) {
                    //add textformfield for name, email, password
                    return RegisterForm(
                      form: _form,
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
                    form: _form,
                    nameController: nameController,
                    emailController: emailController,
                    passwordController: passwordController,
                  );
                },
              ),
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  if (state is RegisterSuccess) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          //call back to registration page
                          context
                              .read<RegisterBloc>()
                              .add(UserTapLoginButtonEvent());
                        },
                        child: const Text('Back To Registration'),
                      ),
                    );
                  }
                  return SizedBox(
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
                        }
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
    required GlobalKey<FormState> form,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  }) : _form = form;

  final GlobalKey<FormState> _form;
  final TextEditingController? nameController;
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
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
            validator: ValidationBuilder().minLength(5).maxLength(50).build(),
            controller: nameController,
          ),
          const SizedBox(
            height: 10,
          ),
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
