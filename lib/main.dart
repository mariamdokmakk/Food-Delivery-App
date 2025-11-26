// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:food_delivery_app/presentation/screens/home_screen.dart';
// import 'package:food_delivery_app/presentation/screens/main_home_screen.dart';
// import 'package:food_delivery_app/presentation/theme/app_theme.dart';
// import 'package:food_delivery_app/presentation/theme/theme_manager.dart';
// import '/presentation/screens/checkout_screen.dart';
// import '/presentation/screens/splash_screen.dart';
// import 'firebase_options.dart';
// import 'logic/cubit/user_cubit.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   runApp(
//     BlocProvider(
//       create: (_) => UserCubit(),
//       child: FoodDeliverApp(),
//     ),
//   );
// }
//
// class FoodDeliverApp extends StatelessWidget {
//   FoodDeliverApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: Size(375, 812),
//       builder: (_, __) {
//         return AnimatedBuilder(
//           animation: ThemeManager.themeModeNotifier,
//           builder: (context, _) {
//             return MaterialApp(
//               debugShowCheckedModeBanner: false,
//               theme: AppTheme.lightTheme,
//               darkTheme: AppTheme.darkTheme,
//               themeMode: ThemeManager.themeModeNotifier.value,
//               routes: {
//                 '/checkout': (context) => const CheckoutScreen(),
//               },
//               home: StreamBuilder(
//                 stream: FirebaseAuth.instance.authStateChanges(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                   if (snapshot.hasData) {
//                     return MainHomeScreen();
//                   } else {
//                     return SplashScreen();
//                   }
//                 },
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
// }
//


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/presentation/screens/main_home_screen.dart';
import 'package:food_delivery_app/presentation/theme/app_theme.dart';
import 'package:food_delivery_app/presentation/theme/theme_manager.dart';
import '/presentation/screens/checkout_screen.dart';
import '/presentation/screens/splash_screen.dart';
import 'firebase_options.dart';
import 'logic/cubit/user_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    BlocProvider(
      create: (_) => UserCubit(),
      child: FoodDeliverApp(),
    ),
  );
}

class FoodDeliverApp extends StatelessWidget {
  FoodDeliverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (_, __) {
        return AnimatedBuilder(
          animation: ThemeManager.themeModeNotifier,
          builder: (context, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeManager.themeModeNotifier.value,

              routes: {
                '/checkout': (context) => const CheckoutScreen(),
              },

              home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    return MainHomeScreen();
                  } else {
                    return SplashScreen();
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
//

