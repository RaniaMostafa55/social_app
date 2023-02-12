import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = (isPassword)
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangeRegisterPasswordVisibilityState());
  }

  void userCreate({
    required String email,
    required String phone,
    required String name,
    required String uId,
  }) {
    UserModel model = UserModel(
        email: email,
        name: name,
        phone: phone,
        uId: uId,
        isEmailVerified: false,
        bio: "Write your bio ...",
        cover:
            'https://img.freepik.com/free-photo/joyful-dark-skinned-woman-with-satisfied-facial-expression-curly-hair-points-sideways-keeps-arms-crossed-chest-being-high-spirit-dressed-oversized-rosy-sweater-isolated-purple-wall_273609-26410.jpg?w=900&t=st=1675780836~exp=1675781436~hmac=85b82870bf9e3a9e99a027bd9aee17bb8661ba618013d1c597ede6af94c831d4',
        image:
            'https://img.freepik.com/free-photo/cute-curly-haired-girl-showing-golden-credit-card-mobile-phone-screen_176420-20210.jpg?w=900&t=st=1675791036~exp=1675791636~hmac=f543a0fc82436c18e66c4afc835ef846d1d08d9433462dcde27b5991f8268c33');

    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }

  void userRegister(
      {required String email,
      required String pass,
      required String name,
      required String phone}) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(email: email, name: name, phone: phone, uId: value.user!.uid);
    }).catchError((error) {
      emit(RegisterErrorState(error));
    });
  }
}
