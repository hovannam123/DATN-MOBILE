import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/modules/admin/home_page_admin/admin_home_page.dart';
import 'package:safe_food/src/resource/provider/auth_provider.dart';
import 'package:safe_food/src/resource/store_data/store_data.dart';
import 'package:safe_food/src/resource/utils/enums/app_strings.dart';
import 'package:safe_food/src/resource/utils/enums/helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../forget_password/forget_password.dart';
import '../home_page/home_page.dart';
import '../introduce/introduce.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Color colorValidate = Colors.black;

  bool emailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  void onError(error) {
    print('Error: $error');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final authProvider = Provider.of<AuthProvider>(context);

    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => IntroScreen())),
          ),
          title: const Text(
            'Đăng nhập',
            style: AppTextStyle.heading3Black,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.8,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Form(
              key: _loginKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Email',
                      style: AppTextStyle.heading4Medium,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: colorValidate, width: 0.8),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Image.asset('assets/images/btnCancel.png'),
                            onPressed: () {
                              emailController.clear();
                            },
                          ),
                          hintText: 'Nhập email của bạn',
                          hintStyle: AppTextStyle.heading4Grey,
                          border: InputBorder.none,
                          errorStyle: AppTextStyle.heading4Black),
                      validator: (input) {
                        if (!emailValid(input!)) {
                          setState(() {
                            colorValidate = Colors.red;
                          });
                        } else {
                          setState(() {
                            colorValidate = Colors.black;
                          });
                        }
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 25),
                    child: Text(
                      'Mật khẩu',
                      style: AppTextStyle.heading4Medium,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.8),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Image.asset('assets/images/btnCancel.png'),
                            onPressed: () {
                              passwordController.clear();
                            },
                          ),
                          hintText: 'Nhập mật khẩu',
                          hintStyle: AppTextStyle.heading4Grey,
                          border: InputBorder.none,
                          errorStyle: AppTextStyle.heading2Medium),
                      obscureText: true,
                      validator: (value) {},
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    width: size.width,
                    height: 44,
                    color: AppTheme.brandBlue,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_loginKey.currentState!.validate()) {
                          await authProvider
                              .login(
                                  emailController.text, passwordController.text)
                              .then((token) async {
                            await StoreData().retrieveUser().then((user) => {
                                  if (user.roleId == 1)
                                    {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminHomePage()))
                                    }
                                  else if (user.roleId == 2)
                                    {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomePage()))
                                    }
                                });
                          }).catchError((error) {
                            showErrorDialog(context, error);
                          });
                        }
                      },
                      child: const Text(
                        'Đăng nhập',
                        style: AppTextStyle.heading3Light,
                      ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      child: const Text('Quên mật khẩu',
                          style: AppTextStyle.h_underline_grey),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SendEmail(
                                      isResetPW: true,
                                    )));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
