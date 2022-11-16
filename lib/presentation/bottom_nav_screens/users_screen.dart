// import 'package:flutter/material.dart';
//
// class UsersScreen extends StatelessWidget {
//   const UsersScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(child: Text("UsersScreen"),),
//     );
//   }
// }
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/app_cubit/app_cubit.dart';
import '../../business_logic/app_cubit/app_states.dart';
import '../../constance/components.dart';
import '../../models/user_model.dart';
import '../chat_screen.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        print(' users :${cubit.users.length}');
        return ConditionalBuilder(
          condition: cubit.users.length >0,
          builder: (context) => Column(
            children: [
              ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      buildChatItem(cubit.users[index], context),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: cubit.users.length),
            ],
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildChatItem(UserModel model, context) => InkWell(
        onTap: () {
          navigateTo(
              context: context,
              widget: MessagesScreen(
                userModel: model,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(model.image!),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Text(
                model.name!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                width: 15.0,
              ),
            ],
          ),
        ),
      );
}
