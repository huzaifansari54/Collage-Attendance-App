import 'package:attendence_mangement_system/Providers/AuthProvider/AuthProviders.dart';
import 'package:attendence_mangement_system/Services/DataBaseServices/DataControllers/GetDataController.dart';
import 'package:attendence_mangement_system/View/AuthScreens/LogInScreen.dart';
import 'package:attendence_mangement_system/View/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(authUser);
    final userModel = ref.watch(userprofileProvider).value;
    return user.when(data: (user) {
      if (user != null && userModel != null) return const HomeScreen();
      return const LogInScreen();
    }, error: (__, _) {
      return const LogInScreen();
    }, loading: () {
      return const LogInScreen();
    });
  }
}
