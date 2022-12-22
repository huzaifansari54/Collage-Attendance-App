import 'dart:ui';
import 'package:attendence_mangement_system/Data/Models/AttendanceModel.dart';
import 'package:attendence_mangement_system/Data/Models/User.dart';
import 'package:attendence_mangement_system/Providers/DataProviders/DataProviders.dart';
import 'package:attendence_mangement_system/Services/DataBaseServices/DataControllers/DataSate.dart';
import 'package:attendence_mangement_system/Services/DataBaseServices/DataControllers/GetDataState.dart';
import 'package:attendence_mangement_system/Utils/Routes/Routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:attendence_mangement_system/Utils/Themes/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Providers/LocationProvider/LocationProvider.dart';

class ScanerScreen extends ConsumerStatefulWidget {
  const ScanerScreen({Key? key, required this.user}) : super(key: key);
  final UserModel user;
  @override
  ConsumerState<ScanerScreen> createState() => _ScanerScreenState();
}

class _ScanerScreenState extends ConsumerState<ScanerScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final MobileScannerController mobileScannerController;
  bool isLoad = false;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    animationController.repeat(reverse: true);
    mobileScannerController = MobileScannerController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final local = ref.watch(locationProvider);
    final attendanceProvider = ref.read(dataControllerProvider.notifier);
    late final AttendanceModel model;
    // final watch = ref.watch(
    //     getDataControllerProvider.select((value) => value as AttendanceLoaded));
    // if (watch.attendanceModel != null) {
    //   Navigator.popAndPushNamed(context, Routes.dashBord,
    //       arguments: watch.attendanceModel);
    // }
    ref.listen<GetDataState>(
        getDataControllerProvider.select((value) => value as AttendanceLoaded),
        ((previous, next) async {
      if (next is AttendanceLoaded) {
        setState(() {
          isLoad = true;
        });
        await Future.delayed(
          const Duration(seconds: 3),
        );

        Navigator.popAndPushNamed(context, Routes.dashBord,
            arguments: next.attendanceModel);
      }
    }));
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            local.when(
                data: (data) {
                  model = AttendanceModel(
                      numOfPresents: 0,
                      attendance: 'Present',
                      currentAddress: data.street!,
                      dateTime:
                          DateTime.now().millisecondsSinceEpoch.toString(),
                      enrollNumber: 'A-6186',
                      lastName: widget.user.lastName,
                      name: widget.user.name,
                      rollNumber: widget.user.rollNumber);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        data.street!,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: primaryColor),
                      ),
                      Text(DateFormat.yMEd().add_jms().format(DateTime.now())),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  );
                },
                error: (e, s) {
                  return TextButton(
                      onPressed: () async {
                        Location.instance.requestService().then((value) {
                          if (value) {
                            ref.refresh(locationProvider);
                          }
                        });
                      },
                      child: const Text('Refresh'));
                },
                loading: () =>
                    const Center(child: CupertinoActivityIndicator())),
            Container(
                height: size.height * .75,
                width: size.width * 0.90,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25))),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Stack(
                    children: [
                      MobileScanner(
                        controller: mobileScannerController,
                        allowDuplicates: false,
                        onDetect: (barcode, args) {},
                      ),
                      AnimatedButton(
                        animationController,
                        onAnimation: () async {
                          mobileScannerController.barcodes.first
                              .then((Barcode barcode) {
                            if (barcode.rawValue != null) {
                              final String code = barcode.rawValue!;
                              if (code == 'huzaifa') {
                                attendanceProvider.uploadAttendance(model);
                              }
                            }
                          });

                          attendanceProvider.uploadAttendance(model);
                        },
                      ),
                      isLoad
                          ? Positioned(
                              top: 10,
                              left: size.width * .5 - 35,
                              child: const CircularProgressIndicator())
                          : const Positioned(child: SizedBox()),
                      Positioned(
                        bottom: 5,
                        left: size.width * 0.5 + 23,
                        child: GestureDetector(
                          onTap: () async {
                            await mobileScannerController.switchCamera();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              child: CircleAvatar(
                                  radius: 20,
                                  child: ValueListenableBuilder(
                                      valueListenable: mobileScannerController
                                          .cameraFacingState,
                                      builder: (context, value, _) {
                                        switch (value as CameraFacing) {
                                          case CameraFacing.back:
                                            return const Icon(
                                                Icons.rotate_left);
                                          case CameraFacing.front:
                                            return const Icon(
                                                Icons.rotate_right);
                                        }
                                      }),
                                  backgroundColor: fillColor),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2.5, color: primaryColor),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: size.width * 0.5 + 23,
                        child: GestureDetector(
                          onTap: () async {
                            await mobileScannerController.toggleTorch();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              child: CircleAvatar(
                                  radius: 20,
                                  child: ValueListenableBuilder(
                                      valueListenable:
                                          mobileScannerController.torchState,
                                      builder: (context, value, _) {
                                        switch (value as TorchState) {
                                          case TorchState.off:
                                            return const Icon(Icons.flash_off);
                                          case TorchState.on:
                                            return const Icon(Icons.flash_on);
                                        }
                                      }),
                                  backgroundColor: fillColor),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2.5, color: primaryColor),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    mobileScannerController.dispose();

    super.dispose();
  }

  _showDialog(AttendanceModel attendanceModel) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Your attendance is mark please press OK'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, Routes.dashBord,
                            arguments: attendanceModel)
                        .then((value) => Navigator.pop(context));
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }
}

class AnimatedButton extends AnimatedWidget {
  const AnimatedButton(
    Animation<double> animation, {
    required this.onAnimation,
    Key? key,
  }) : super(key: key, listenable: animation);
  final VoidCallback onAnimation;

  @override
  Widget build(BuildContext context) {
    final value = (listenable as Animation<double>).value;
    final newVlaue = lerpDouble(0.5, 1.0, value)!;
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: onAnimation,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(6),
                child: const CircleAvatar(
                    radius: 25.0,
                    child: Icon(Icons.scatter_plot),
                    backgroundColor: fillColor),
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: primaryColor),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Center(
              child: Container(
                child: CircleAvatar(
                    radius: 30.0 * newVlaue,
                    backgroundColor: primaryColor.withOpacity(0.7)),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Center(
              child: Container(
                child: CircleAvatar(
                    radius: 22.0 * newVlaue, backgroundColor: primaryColor),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
