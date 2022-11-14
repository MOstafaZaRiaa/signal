import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signal/business_logic/app_cubit/app_cubit.dart';
import 'package:signal/business_logic/app_cubit/app_states.dart';
import 'package:signal/constance/components.dart';
import 'package:signal/helper/shared_prefrence_helper.dart';
import 'package:signal/presentation/auth_screens/login_screen.dart';

import '../constance/icon_broken.dart';
import '../constance/strings.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is! AppGetUserDataSuccessesState) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is AppGetUserDataErrorState) {
          showToast(text: state.error, color: ToastColors.ERROR);
        }
      },
      builder: (context, state) {
        final cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(IconBroken.Notification)),
              IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    uId = '';
                    SharedPreferenceHelper.removeData(key: uIdKey);
                    navigateAndFinish(context: context, widget: LoginScreen());
                  },
                  icon: const Icon(IconBroken.Logout)),
            ],
            shadowColor: Colors.black,
          ),
          body: Center(
            child: cubit.userModel == null
                ? const CircularProgressIndicator()
                : cubit.bottomScreens[cubit.currentIndex],
          ),
          bottomNavigationBar:  BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'Chats'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload), label: 'Post'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location), label: 'Users'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: 'Settings'),
            ],
            currentIndex: cubit.currentIndex,
            selectedItemColor:Color(0xFFee1119),
            type: BottomNavigationBarType.fixed,
            onTap: (index){
             cubit.changeBottom(index, context);
            },
          ),
        );
      },
    );
  }
}
