import 'package:attendence_mangement_system/Services/AuthServices/AuthController/LoginController.dart';
import 'package:attendence_mangement_system/Services/AuthServices/AuthController/LoginState.dart';
import 'package:attendence_mangement_system/View/AuthScreens/SignUpScreen.dart';
import 'package:attendence_mangement_system/Utils/Themes/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Utils/Validators/validator.dart';
import 'CommanWidgets/FieldText.dart';
import 'CommanWidgets/PasswordField.dart';

class LogInScreen extends ConsumerStatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LogInScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ref.listen(loginControllerProvider, (previous, next) {
      if (next is LoginErorrState) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.error)));
      }
    });
    final _key = GlobalKey<FormState>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              'LogIn',
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: primaryColor),
            ),
            const Spacer(),
            Form(
              key: _key,
              child: Column(
                children: [
                  CustomTextField(
                    iconData: Icons.email,
                    textEditingController: email,
                    validator: (value) {
                      if (!Validators.emailValidates(value.toString())) {
                        return 'Invalid email address ';
                      }
                    },
                    hint: 'Email',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomPasswordField(editingController: password),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text('Forget a password?',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: primaryColor)),
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Consumer(builder: (context, ref, _) {
              return GestureDetector(
                onTap: () {
                  if (_key.currentState!.validate()) {
                    ref
                        .read(loginControllerProvider.notifier)
                        .login(email.text, password.text);
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  alignment: Alignment.center,
                  child: Text(
                    'LogIn',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              );
            }),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dont have an account? ',
                  style: Theme.of(context).textTheme.caption,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text('SignUp'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
