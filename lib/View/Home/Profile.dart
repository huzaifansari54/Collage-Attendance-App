import 'package:attendence_mangement_system/Services/DataBaseServices/DataControllers/GetDataController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Data/Models/User.dart';
import '../../Services/AuthServices/AuthController/LoginController.dart';
import '../../Utils/Themes/Colors.dart';

class StudentScreen extends ConsumerStatefulWidget {
  const StudentScreen({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  ConsumerState<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends ConsumerState<StudentScreen> {
  @override
  Widget build(BuildContext context) {
    final textThemes = Theme.of(context).textTheme;
    return Scaffold(
        body: Column(
      children: [
        const Spacer(),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 3, color: primaryColor)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: widget.user.imageUrl,
                      fit: BoxFit.cover,
                      height: 80,
                      width: 80,
                      placeholder: (context, url) =>
                          Image.asset('assets/download.png'),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '@${widget.user.name}',
                    style: textThemes.subtitle1,
                  ),
                  Text(
                    ' ${widget.user.lastName}',
                    style: textThemes.subtitle1,
                  ),
                ],
              ),
              Text(
                'Roll number ${widget.user.rollNumber}',
                style: textThemes.bodyText2,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        _CustomTile(
          title: 'Setting',
          onPressed: (() {
            setState(() {});
          }),
          trailIcon: Icons.settings,
        ),
        _CustomTile(
          title: 'Update Profile',
          onPressed: (() {}),
          trailIcon: Icons.edit,
        ),
        _CustomTile(
          title: 'Log Out',
          onPressed: (() {
            ref.read(loginControllerProvider.notifier).signOut();
          }),
          trailIcon: Icons.logout,
        ),
        const Spacer(
          flex: 2,
        ),
      ],
    ));
  }
}

class _CustomTile extends StatelessWidget {
  const _CustomTile({
    required this.onPressed,
    Key? key,
    required this.title,
    required this.trailIcon,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String title;
  final IconData trailIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: fillColor, borderRadius: BorderRadius.circular(15)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title),
        TextButton(
          child: Icon(
            trailIcon,
            color: primaryColor,
          ),
          onPressed: onPressed,
        )
      ]),
    );
  }
}
