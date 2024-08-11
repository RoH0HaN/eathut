import 'package:eathut/repositories/cart_repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'constants/constants.dart';
import 'repositories/authentication_repository/authentication_repository.dart';
import 'utils/routes/routes.dart';
import 'utils/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(AuthenticationRepository());
  Get.put(CartRepository());
  await GetStorage.init();
  final box = GetStorage();
  AuthenticationRepository.instance.onBoarding = box.read('onBoarding') ?? 0;

  await box.write('onBoarding', 1);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(width, height),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chef App',
          // You can use the library anywhere in the app even in theme
          theme: AppTheme.lightTheme,
          initialRoute: AppRoutes.splash,
          getPages: AppRoutes.routes,
        );
      },
    );
  }
}
