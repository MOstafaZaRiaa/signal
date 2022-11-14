import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signal/constance/colors.dart';

import '../business_logic/app_cubit/app_cubit.dart';
import '../business_logic/app_cubit/app_states.dart';
import '../constance/components.dart';
import '../constance/icon_broken.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({Key? key}) : super(key: key);
  var postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is SocialCreatePostLoadingState) {
          postController.clear();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var postImage = AppCubit.get(context).postImagePicked;
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar:
          defaultAppBar(title: 'Create Post ', context: context, actions: [
            TextButton(
                onPressed: () {
                  if (cubit.postImagePicked == null) {
                    cubit
                        .createPost(text: postController.text);
                  } else {
                    cubit
                        .uploadPostImage(text: postController.text);
                  }
                },
                child: const Text(
                  'POST',
                  style: TextStyle(fontSize: 18),
                ))
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  const SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          cubit.userModel!.image!),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                        child: Text(
                          cubit.userModel!.name!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                      maxLines: 5,
                      controller: postController,
                      decoration: const InputDecoration(
                        hintText: "what is on your mind, mostafa ?",
                        border: InputBorder.none,
                      )),
                ),
                if (postImage != null)
                  const SizedBox(
                    height: 20,
                  ),
                if (postImage != null)
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          // height: 140,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                              image: DecorationImage(
                                image: Image.file(postImage).image,
                                fit: BoxFit.cover,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: MyColors.primarySwatch,
                            child: IconButton(
                                onPressed: () {
                                  cubit.removePostImage();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Theme.of(context).iconTheme.color,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                if (postImage != null)
                  const SizedBox(
                    height: 20,
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            cubit.getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('add photo')
                            ],
                          )),
                    ),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('# tags')))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
