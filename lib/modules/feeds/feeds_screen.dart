import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return (SocialCubit.get(context).posts.isNotEmpty &&
                SocialCubit.get(context).userModel != null)
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      elevation: 5,
                      margin: const EdgeInsets.all(8),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          const Image(
                            image: NetworkImage(
                                'https://img.freepik.com/free-photo/happy-cheerful-dark-skinned-woman-looks-with-glad-surprised-expression-indicates-right-shows-copy-space-your-promotional-content_273609-45555.jpg?w=1060&t=st=1675779680~exp=1675780280~hmac=2b5f1a4f30660cb7edde9cd95bec90dfce0947f42df529fde427e7f96ba7323c'),
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Communicate with friends",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        return BuildPostItem(
                          model: SocialCubit.get(context).posts[index],
                          index: index,
                        );
                      },
                      itemCount: SocialCubit.get(context).posts.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                    const SizedBox(
                      height: 8,
                    )
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class BuildPostItem extends StatelessWidget {
  final PostModel model;
  final int index;
  const BuildPostItem({super.key, required this.model, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(model.image!),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            model.name!,
                            style: const TextStyle(height: 1.4),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 16,
                          )
                        ],
                      ),
                      Text(
                        model.dateTime!,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(height: 1.4),
                      )
                    ],
                  )),
                  const SizedBox(width: 15),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 16,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                model.text!,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(height: 1.3, fontSize: 14),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 25,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          child: Text(
                            "#software",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: defaultColor),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 25,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          child: Text(
                            "#flutter",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: defaultColor),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 5),
              if (model.postImage != "")
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(model.postImage!),
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              const Icon(
                                IconBroken.Heart,
                                size: 18,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                SocialCubit.get(context)
                                    .postLikes[index]
                                    .toString(),
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                IconBroken.Chat,
                                size: 18,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "0 comment",
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                                SocialCubit.get(context).userModel!.image!),
                          ),
                          const SizedBox(width: 15),
                          Text("write a comment ...",
                              style: Theme.of(context).textTheme.bodySmall!
                              // .copyWith(height: 1.4),
                              ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context)
                          .likePost(SocialCubit.get(context).postsId[index]);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Heart,
                          size: 18,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Like",
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
