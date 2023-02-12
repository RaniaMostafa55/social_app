import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/login_screen/login_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/components/flutter_toast.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/enums.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/themes.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  showFlutterToast(
      message: "On background message", state: ToastStates.success);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // DioHelper.init();
  // if (Platform.isWindows) {
  //   await DesktopWindow.setMinWindowSize(const Size(350.0, 650.0));
  // }

  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showFlutterToast(message: "On message", state: ToastStates.success);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showFlutterToast(
        message: "On message opened app", state: ToastStates.success);
  });
  FirebaseMessaging.onBackgroundMessage((firebaseMessagingBackgroundHandler));
  bool isDark = CacheHelper.getBool(key: "isDark");
  // bool isboarding = CacheHelper.getBool(key: "onboarding");

  Widget widget;
  var uId = CacheHelper.getString(key: "uId");
  if (uId != null) {
    widget = const SocialLayout();
  } else {
    widget = LoginScreen();
  }
  // print(isboarding);
  runApp(MyApp(
    isDark: isDark,
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? widget;

  const MyApp({super.key, this.isDark, this.widget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                AppCubit()..changeAppMode(fromShared: isDark)),
        BlocProvider(
            create: (BuildContext context) => SocialCubit()
              ..getUserData()
              ..getPosts()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            // (AppCubit.get(context).isDark)
            //     ? ThemeMode.dark
            //     : ThemeMode.light,
            home: widget,
          );
        },
      ),
    );
  }
}
