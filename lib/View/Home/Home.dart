import 'package:attendence_mangement_system/Services/DataBaseServices/DataControllers/GetDataController.dart';
import 'package:attendence_mangement_system/Utils/Themes/Colors.dart';
import 'package:attendence_mangement_system/View/Home/DashBord.dart';
import 'package:attendence_mangement_system/View/Home/Profile.dart';
import 'package:attendence_mangement_system/View/Home/ScannerScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Providers/DataProviders/DataProviders.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _controller;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, _) {
        final data = ref.watch(userprofileProvider);
        return data.when(
            data: (user) {
              return PageView(
                controller: _controller,
                onPageChanged: (value) => setState(() {
                  _currentIndex = value;
                }),
                children: [
                  ScanerScreen(
                    user: user,
                  ),
                  StudentScreen(
                    user: user,
                  ),
                ],
              );
            },
            error: (error, s) {
              return Center(child: Text(error.toString()));
            },
            loading: () => const Center(
                  child: CupertinoActivityIndicator(),
                ));
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) => _controller.jumpToPage(value),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
