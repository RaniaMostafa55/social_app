import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';

import '../modules/new_post/new_post_screen.dart';
import '../shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewPostScreen(),
              ));
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(IconBroken.Notification)),
              IconButton(onPressed: () {}, icon: const Icon(IconBroken.Search))
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: "Chats"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload), label: "Post"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location), label: "Users"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: "Settings"),
            ],
            onTap: (value) {
              cubit.changeBottomNav(value);
            },
            currentIndex: cubit.currentIndex,
          ),
          //(SocialCubit.get(context).userModel != null)
          //     ? Column(
          //         children: [
          //           if (!FirebaseAuth.instance.currentUser!.emailVerified)
          //             Container(
          //               color: Colors.amber.withOpacity(0.6),
          //               child: Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: Row(
          //                   children: [
          //                     const Icon(Icons.info_outline),
          //                     const SizedBox(width: 15),
          //                     const Expanded(
          //                         child: Text("Please Verify Email")),
          //                     const Spacer(),
          //                     TextButton(
          //                         onPressed: () {
          //                           FirebaseAuth.instance.currentUser!
          //                               .sendEmailVerification()
          //                               .then((value) {
          //                             showFlutterToast(
          //                                 message: "Check your email",
          //                                 state: ToastStates.success);
          //                           });
          //                         },
          //                         child: const Text("Send"))
          //                   ],
          //                 ),
          //               ),
          //             )
          //         ],
          //       )
          //     : const Center(child: CircularProgressIndicator())
        );
      },
    );
  }
}
