import 'package:attendence_mangement_system/Data/Models/AttendanceModel.dart';
import 'package:attendence_mangement_system/Services/DataBaseServices/DataControllers/GetDataState.dart';
import 'package:attendence_mangement_system/View/Home/DashBord.dart';
import 'package:attendence_mangement_system/View/Home/Home.dart';
import 'package:attendence_mangement_system/View/SplashScreen/splashScreen.dart';

import 'package:flutter/material.dart';
import '../../View/AuthScreens/LogInScreen.dart';
import '../../View/AuthScreens/SignUpScreen.dart';

class Routes {
  static String dashBord = '/dashbord';
  static String? home = '/';
  static String login = '/login';
  static String signup = '/signup';
  static Route<dynamic> onRoutes(RouteSettings settings) {
    final model = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: ((context) => const SplashScreen()));
      case '/dashbord':
        if (model is AttendanceModel) {
          return MaterialPageRoute(
              builder: ((context) => DashBord(model: model)));
        }
        return MaterialPageRoute(builder: ((context) => const ErorrScreen()));

      case '/login':
        return MaterialPageRoute(builder: ((context) => const LogInScreen()));
      case '/signup':
        return MaterialPageRoute(builder: ((context) => const SignUpScreen()));
      default:
        return MaterialPageRoute(builder: ((context) => const ErorrScreen()));
    }
  }
}

class ErorrScreen extends StatelessWidget {
  const ErorrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [Text('Erorr Screen')],
      ),
    );
  }
}
