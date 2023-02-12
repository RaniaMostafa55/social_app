import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/default_form_field.dart';
import 'package:social_app/shared/styles/colors.dart';

import '../../shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        var nameController = TextEditingController();
        var bioController = TextEditingController();
        var phoneController = TextEditingController();
        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Edit Profile"),
            titleSpacing: 5,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(IconBroken.Arrow___Left_2)),
            actions: [
              TextButton(
                onPressed: () {
                  SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      bio: bioController.text,
                      phone: phoneController.text);
                },
                child: const Text("Update"),
              ),
              const SizedBox(width: 15)
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    const LinearProgressIndicator(),
                  SizedBox(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4)),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: (coverImage == null)
                                        ? NetworkImage('${userModel.cover}')
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: const CircleAvatar(
                                      radius: 20,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 16,
                                      )))
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 55,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 50.0,
                                backgroundImage: (profileImage == null)
                                    ? NetworkImage("${userModel.image}")
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: const CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 16,
                                    )))
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (profileImage != null || coverImage != null)
                    Row(
                      children: [
                        if (profileImage != null)
                          Expanded(
                            child: MaterialButton(
                              color: defaultColor,
                              onPressed: () {
                                SocialCubit.get(context).uploadProfileImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text);
                              },
                              child: const Text(
                                "Update Profile",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        const SizedBox(width: 5),
                        if (coverImage != null)
                          Expanded(
                            child: MaterialButton(
                              color: defaultColor,
                              onPressed: () {
                                SocialCubit.get(context).uploadCoverImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text);
                              },
                              child: const Text(
                                "Update Cover",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(height: 5),
                  if (state is SocialProfileUpdateLoadingState ||
                      state is SocialCoverUpdateLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 20),
                  DefaultFormField(
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Name must not be empty";
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      type: TextInputType.name,
                      label: "Name",
                      prefix: IconBroken.User),
                  const SizedBox(height: 10),
                  DefaultFormField(
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Bio must not be empty";
                        } else {
                          return null;
                        }
                      },
                      controller: bioController,
                      type: TextInputType.text,
                      label: "Bio",
                      prefix: IconBroken.Info_Circle),
                  const SizedBox(height: 10),
                  DefaultFormField(
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "phone must not be empty";
                        } else {
                          return null;
                        }
                      },
                      controller: phoneController,
                      type: TextInputType.phone,
                      label: "Phone",
                      prefix: IconBroken.Call)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
