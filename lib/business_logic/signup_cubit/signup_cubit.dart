import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signal/business_logic/signup_cubit/signup_states.dart';

import '../../constance/strings.dart';
import '../../helper/shared_prefrence_helper.dart';
import '../../models/user_model.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;

  void userSignUp({
    email,
    password,
    name,
    phone,
  }) async {
    emit(SignUpLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      SharedPreferenceHelper.saveData(
        key: uIdKey,
        value: value.user!.uid,
      );
      emit(SignUpSuccessState());
      saveUserDataToFireStore(
        name: name,
        email: email,
        phone: phone,
        uid: value.user!.uid,
      );
    }).catchError((onError) {
      print('signUp-error : ${onError.toString()}');
      emit(
        SignUpErrorState('Check your internet connection.'),
      );
    });
  }

  saveUserDataToFireStore({name, email, phone, uid}) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'bio': 'write your bio...',
      'image':
          'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=740&t=st=1668407142~exp=1668407742~hmac=be4bf0994b80a7bd71dca33f42d530381001728dfe4e2d8f8a1da79ad9e66be4',
      'cover':
          'https://img.freepik.com/free-photo/lamp-mat-near-quran_23-2147868927.jpg?w=740&t=st=1668407187~exp=1668407787~hmac=48974da6934c433d3f906f3ad2244f1917a2f1c34d31ae7ab54fce1c34b4966e',
    }).then((value) {
      userModel = UserModel(phone: phone, email: email, name: name, uid: uid);
      emit(SaveUserDataSuccessState());
    }).catchError((error) {
      print("Failed to add user: $error");
      emit(SaveUserDataErrorState());
    });
  }

  bool isVisible = true;
  IconData suffix = Icons.visibility_off_outlined;

  void changePasswordVisibility() {
    isVisible = !isVisible;

    suffix =
        isVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SignUpChangePasswordVisibilityState());
  }
}
