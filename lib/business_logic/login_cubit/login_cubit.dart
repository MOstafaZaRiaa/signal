import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signal/business_logic/login_cubit/login_states.dart';
import 'package:signal/models/user_model.dart';

import '../../constance/strings.dart';
import '../../helper/shared_prefrence_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void userLogin({email, password}) async {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          uId= value.user!.uid;
      SharedPreferenceHelper.saveData(key: uIdKey,value: value.user!.uid);
      emit(
        LoginSuccessState(),
      );
    }).catchError((onError) {
      print('login-error : ${onError.toString()}');
      emit(
        LoginErrorState('Check your internet connection.'),
      );
    });
  }

  bool isVisible = true;
  IconData suffix = Icons.visibility_off_outlined;

  void changePasswordVisibility() {
    isVisible = !isVisible;

    suffix =
        isVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(LoginChangePasswordVisibilityState());
  }
}
