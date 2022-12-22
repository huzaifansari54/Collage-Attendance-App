import 'dart:async';
import 'dart:io';

import 'package:attendence_mangement_system/Data/Models/User.dart';
import 'package:attendence_mangement_system/Providers/DataProviders/DataProviders.dart';
import 'package:attendence_mangement_system/Services/DataBaseServices/DataControllers/DataSate.dart';
import 'package:attendence_mangement_system/Utils/Themes/Colors.dart';
import 'package:attendence_mangement_system/Utils/Validators/validator.dart';
import 'package:attendence_mangement_system/View/SplashScreen/splashScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'CommanWidgets/FieldText.dart';
import 'CommanWidgets/PasswordField.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final name = TextEditingController();
  final lastName = TextEditingController();
  final rollNumber = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final enrollNumber = TextEditingController();
  final classText = TextEditingController();
  final semText = TextEditingController();
  File? _file;
  bool _isload = false;

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              _isload
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: primaryColor,
                    ))
                  : const SizedBox(),
              Text(
                'SignUp',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: primaryColor),
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    child: _file != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              _file!,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              'assets/download.png',
                              height: 100,
                            ),
                          ),
                    backgroundColor: fillColor,
                    radius: 60,
                  ),
                  Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          color: backgroundColor, shape: BoxShape.circle),
                      child: GestureDetector(
                          onTap: (() {
                            _loadImage(ImageSource.gallery);
                          }),
                          child: const Icon(Icons.camera_alt)))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _key,
                child: Column(
                  children: [
                    CustomTextField(
                      iconData: Icons.person,
                      textEditingController: name,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Please enter your name';
                        }
                      },
                      hint: 'Name',
                    ),
                    CustomTextField(
                      iconData: Icons.person,
                      textEditingController: lastName,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Please enter your last name';
                        }
                      },
                      hint: 'Last Name',
                    ),
                    CustomTextField(
                      iconData: Icons.numbers,
                      type: TextInputType.number,
                      textEditingController: rollNumber,
                      validator: (value) {
                        if (value != null && value.isEmpty ||
                            value!.length != 10) {
                          return 'Please enter your  10 digit roll no';
                        }
                      },
                      hint: 'Roll Number',
                    ),
                    CustomTextField(
                        iconData: Icons.group,
                        hint: 'Class Or Program',
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter your Class';
                          }
                        },
                        textEditingController: classText),
                    CustomTextField(
                        iconData: Icons.cast_for_education,
                        hint: 'Semster',
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter your Semster';
                          }
                        },
                        textEditingController: semText),
                    CustomTextField(
                        iconData: Icons.numbers,
                        hint: 'Enroll Number A-',
                        type: TextInputType.number,
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter your Enroll Number';
                          }
                        },
                        textEditingController: enrollNumber),
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
                    CustomPasswordField(
                      editingController: password,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Consumer(builder: (context, ref, _) {
                ref.listen(dataControllerProvider, (previous, next) {
                  if (next is DataErorr) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(next.erorr)));
                  } else if (next is DataUplpaded) {
                    setState(() {
                      _isload = false;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SplashScreen()));
                  } else if (next is DataUploading) {
                    setState(() {
                      _isload = true;
                    });
                  }
                });
                return GestureDetector(
                  onTap: (() {
                    if (_key.currentState!.validate() && _file != null) {
                      final newUser = UserModel(
                          imageUrl: '',
                          name: name.text.trim(),
                          lastName: lastName.text.trim(),
                          rollNumber: rollNumber.text.trim(),
                          enrollNumber: enrollNumber.text.trim(),
                          semster: semText.text.trim(),
                          classProgram: classText.text.trim(),
                          uid: '');
                      ref.read(dataControllerProvider.notifier).upload(_file!,
                          newUser, email.text.trim(), password.text.trim());
                    }
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please select Profile image')));
                  }),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      alignment: Alignment.center,
                      child: Text(
                        'SignUp',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
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
                    'Already have an account?',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text('LogIn'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _loadImage(ImageSource imageSource) async {
    final file = await ImagePicker().pickImage(source: imageSource);
    try {
      setState(() {
        _file = File(file!.path);
      });
    } on IOException catch (error) {
      print('somthing went wrong ${error}');
      throw (error);
    }
  }
}
