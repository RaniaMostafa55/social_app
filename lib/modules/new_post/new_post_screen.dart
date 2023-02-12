import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';

import '../../shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var postTextController = TextEditingController();
        return Scaffold(
          appBar: AppBar(
            title: const Text("Create Post"),
            titleSpacing: 5,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(IconBroken.Arrow___Left_2)),
            actions: [
              TextButton(
                  onPressed: () {
                    (SocialCubit.get(context).postImage != null)
                        ? SocialCubit.get(context).uploadPostImage(
                            dateTime: DateTime.now().toString(),
                            text: postTextController.text)
                        : SocialCubit.get(context).createPost(
                            dateTime: DateTime.now().toString(),
                            text: postTextController.text);
                  },
                  child: const Text("Post"))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          "https://img.freepik.com/free-photo/joyful-dark-skinned-woman-with-satisfied-facial-expression-curly-hair-points-sideways-keeps-arms-crossed-chest-being-high-spirit-dressed-oversized-rosy-sweater-isolated-purple-wall_273609-26410.jpg?w=900&t=st=1675780836~exp=1675781436~hmac=85b82870bf9e3a9e99a027bd9aee17bb8661ba618013d1c597ede6af94c831d4"),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                        child: Text(
                      "Rania Mostafa",
                      style: TextStyle(height: 1.4),
                    )),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: postTextController,
                    decoration: const InputDecoration(
                      hintText: "What is on your mind ...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                FileImage(SocialCubit.get(context).postImage!),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: const CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.close,
                                size: 16,
                              )))
                    ],
                  ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(IconBroken.Image),
                              SizedBox(width: 5),
                              Text("add photo")
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {}, child: const Text("# tags")),
                    )
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
