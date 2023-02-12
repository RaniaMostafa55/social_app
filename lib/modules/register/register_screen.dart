import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/register/cubit/cubit.dart';
import 'package:social_app/modules/register/cubit/states.dart';

import '../../shared/components/default_form_field.dart';

import '../../shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SocialLayout(),
                ));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          "Login now to communicate with friends",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 30),
                        DefaultFormField(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Enter your name";
                            }
                            return null;
                          },
                          controller: nameController,
                          type: TextInputType.name,
                          label: "Username",
                          prefix: Icons.person,
                        ),
                        const SizedBox(height: 15),
                        DefaultFormField(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Enter your email address";
                            }
                            return null;
                          },
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: "Email Address",
                          prefix: Icons.email,
                        ),
                        const SizedBox(height: 15),
                        DefaultFormField(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Password is too short";
                            }
                            return null;
                          },
                          controller: passController,
                          type: TextInputType.visiblePassword,
                          label: "Password",
                          prefix: Icons.lock,
                          isObsecure: RegisterCubit.get(context).isPassword,
                          suffix: RegisterCubit.get(context).suffix,
                          suffixTap: () {
                            RegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                        ),
                        const SizedBox(height: 15),
                        DefaultFormField(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Enter your phone number";
                            }
                            return null;
                          },
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: "Phone Number",
                          prefix: Icons.phone,
                        ),
                        const SizedBox(height: 30),
                        (state is! RegisterLoadingState)
                            ? MaterialButton(
                                padding: const EdgeInsets.all(8),
                                minWidth: double.infinity,
                                color: defaultColor,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        pass: passController.text,
                                        name: nameController.text,
                                        phone: phoneController.text);
                                  }
                                },
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            : const Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
