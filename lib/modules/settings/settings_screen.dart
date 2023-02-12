import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import '../edit_profile/edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('${userModel!.cover}'),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 55,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage("${userModel.image}"),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "${userModel.name}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                "${userModel.bio}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              "100",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "Posts",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              "265",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "Photos",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              "10k",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "Followers",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              "64",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "Following",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        "Add Photos",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfileScreen(),
                            ));
                      },
                      child: const Icon(
                        IconBroken.Edit,
                        size: 18,
                      )),
                ],
              ),
              Row(
                children: [
                  OutlinedButton(
                      onPressed: () {
                        FirebaseMessaging.instance
                            .subscribeToTopic("announcement");
                      },
                      child: const Text("Subscribe")),
                  const SizedBox(width: 20),
                  OutlinedButton(
                      onPressed: () {
                        FirebaseMessaging.instance
                            .unsubscribeFromTopic("announcement");
                      },
                      child: const Text("Unsubscribe")),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
