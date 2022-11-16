import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signal/business_logic/app_cubit/app_cubit.dart';

import '../business_logic/app_cubit/app_states.dart';
import '../constance/strings.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';

class MessagesScreen extends StatefulWidget {
  final UserModel userModel;

  const MessagesScreen({
    Key? key,
     required this.userModel,
  }) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final messageController  = TextEditingController();
  @override
  void initState() {
    super.initState();

    AppCubit.get(context).getMessages(recieverId: widget.userModel.uid!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.userModel.name!,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (AppCubit.get(context).messages.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (AppCubit.get(context).messages[index].senderId == uId) {
                          return MyItem(
                            model: AppCubit.get(context).messages[index],
                          );
                        }

                        return UserItem(
                          model: AppCubit.get(context).messages[index],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10,),
                      itemCount: AppCubit.get(context).messages.length,
                    ),
                  ),
                if (AppCubit.get(context).messages.isEmpty)
                  const Expanded(
                    child: Center(
                      child: CupertinoActivityIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: messageController,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'type message',
                    border: const OutlineInputBorder(),
                    suffixIcon: MaterialButton(
                      minWidth: 1,
                      onPressed: () {
                        AppCubit.get(context).sendMessage(recieverId: widget.userModel.uid!,text: messageController.text);
                        messageController.text='';
                      },
                      child: const Icon(
                        Icons.send,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyItem extends StatelessWidget {
  final MessageModel model;

  const MyItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 10.0,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(
                  15.0,
                ),
                topEnd: Radius.circular(
                  15.0,
                ),
                bottomStart: Radius.circular(
                  15.0,
                ),
              ),
              color: Colors.teal,
            ),
            child: Text(
              model.message!,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class UserItem extends StatelessWidget {
  final MessageModel model;

  const UserItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(
                  15.0,
                ),
                topEnd: Radius.circular(
                  15.0,
                ),
                bottomEnd: Radius.circular(
                  15.0,
                ),
              ),
              color: Colors.grey[200],
            ),
            child: Text(
              model.message!,
              style: const TextStyle(),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}