import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat_details/chat_details.dart';
import 'package:social_app/shared/styles/colors.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return (SocialCubit.get(context).allUsers.isNotEmpty)
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return BuildChatItem(
                      model: SocialCubit.get(context).allUsers[index]);
                },
                separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Divider(
                        thickness: 1,
                        color: defaultColor,
                      ),
                    ),
                itemCount: SocialCubit.get(context).allUsers.length)
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class BuildChatItem extends StatelessWidget {
  final UserModel model;
  const BuildChatItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatDetailsScreen(userModel: model),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(model.image!),
            ),
            const SizedBox(width: 15),
            Text(
              model.name!,
              style: const TextStyle(height: 1.4, fontSize: 16),
            ),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
