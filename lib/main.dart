import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signal/presentation/auth_screens/login_screen.dart';
import 'package:signal/presentation/main_screen.dart';
import 'package:signal/presentation/on_boarding_screen.dart';

import 'business_logic/app_cubit/app_cubit.dart';
import 'business_logic/app_cubit/app_states.dart';
import 'constance/strings.dart';
import 'constance/thems.dart';
import 'helper/bloc_observer.dart';
import 'helper/shared_prefrence_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferenceHelper.init();
  Bloc.observer = MyBlocObserver();

  bool isFirstUSe = true;
  Widget widget = const OnBoardingScreen();
  isFirstUSe = SharedPreferenceHelper.getData(key: isFirstUse) ?? true;


  bool? isUserUidSaved;
  if (SharedPreferenceHelper.getData(key: uIdKey) == null) {
    isUserUidSaved = false;
  } else {
    isUserUidSaved = true;
  }

  if (isFirstUSe) {
    widget = const OnBoardingScreen();
  } else {
    if (isUserUidSaved) {
      uId = SharedPreferenceHelper.getData(key: uIdKey);
      widget = const MainScreen();
    } else {
      widget = LoginScreen();
    }
  }
  runApp(MyApp(
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? widget;

  MyApp({
    super.key,
    required this.widget,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()..getTheme()..getUserData()..getPosts()..getAllUsers(),
        )
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, states) {},
        builder: (context, states) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppCubit.get(context).isDarkTheme ? darkMode : lightMode,
            home: widget,
          );
        },
      ),
    );
  }
}
