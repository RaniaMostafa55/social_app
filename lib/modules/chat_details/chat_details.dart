// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  final UserModel userModel;
  const ChatDetailsScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receiverId: userModel.uId!);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var messageController = TextEditingController();

            return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(userModel.image!),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(userModel.name!)
                    ],
                  ),
                ),
                body: (SocialCubit.get(context).messages.isNotEmpty)
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var message = SocialCubit.get(context)
                                        .messages[index];
                                    if (SocialCubit.get(context)
                                            .userModel!
                                            .uId ==
                                        message.senderId) {
                                      return BuildSenderMessage(model: message);
                                    }
                                    return BuildReceiverMessage(model: message);
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(height: 15);
                                  },
                                  itemCount:
                                      SocialCubit.get(context).messages.length),
                            ),
                            Container(
                              height: 50,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey[300]!, width: 1),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 15),
                                      child: TextFormField(
                                        controller: messageController,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                "Type your message here ..."),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: defaultColor,
                                    height: 50,
                                    child: MaterialButton(
                                      minWidth: 1,
                                      onPressed: () {
                                        SocialCubit.get(context).sendMessage(
                                            receiverId: userModel.uId!,
                                            dateTime: DateTime.now().toString(),
                                            text: messageController.text);
                                      },
                                      child: const Icon(
                                        IconBroken.Send,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ));
          },
        );
      },
    );
  }
}

class BuildReceiverMessage extends StatelessWidget {
  final MessageModel model;
  const BuildReceiverMessage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10))),
        child: Text(model.text!),
      ),
    );
  }
}

class BuildSenderMessage extends StatelessWidget {
  final MessageModel model;

  const BuildSenderMessage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: defaultColor.withOpacity(0.2),
            borderRadius: const BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10))),
        child: Text(model.text!),
      ),
    );
  }
}
