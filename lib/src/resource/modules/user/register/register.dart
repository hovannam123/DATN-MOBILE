import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/modules/user/login/login.dart';
import 'package:safe_food/src/resource/provider/auth_provider.dart';
import 'package:safe_food/src/resource/utils/enums/helpers.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPWController = TextEditingController();
  bool checkbox = false;
  bool passwordVisible = false;
  bool confirm = false;

  bool checkConfirm() {
    bool check = true;
    if (passwordController.text == confirmPWController.text) {
      check = true;
    } else {
      check = false;
    }
    return check;
  }

  @override
  void initState() {
    passwordVisible = true;
    confirm = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Đăng kí',
            style: AppTextStyle.heading3Black,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 5),
                    child: Text(
                      'Số điện thoại',
                      style: AppTextStyle.heading4Medium,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 5),
                    height: 44,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.8),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: TextFormField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Image.asset('assets/images/btnCancel.png'),
                            onPressed: () {
                              phoneNumberController.clear();
                            },
                          ),
                          hintText: 'Nhập só điện thoại',
                          hintStyle: AppTextStyle.heading4Grey,
                          border: InputBorder.none,
                          errorStyle: AppTextStyle.heading4Red),
                      validator: (value) {
                        return (value == null || value.isEmpty)
                            ? 'Vui lòng nhập số điện thoại'
                            : null;
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 20),
                    child: Text(
                      'Email',
                      style: AppTextStyle.heading4Medium,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 5),
                    height: 44,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.8),
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
                          errorStyle: AppTextStyle.heading4Red),
                      validator: (value) {
                        return (value == null || value.isEmpty)
                            ? 'Vui lòng nhập email'
                            : null;
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 20),
                    child: Text(
                      'Mật khẩu',
                      style: AppTextStyle.heading4Medium,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 5),
                    height: 44,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.8),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                passwordVisible
                                    ? passwordVisible = false
                                    : passwordVisible = true;
                              });
                            },
                          ),
                          hintText: 'Nhập mật khẩu',
                          hintStyle: AppTextStyle.heading4Grey,
                          border: InputBorder.none,
                          errorStyle: AppTextStyle.heading4Red),
                      obscureText: passwordVisible,
                      validator: (value) {
                        return (value == null || value.isEmpty)
                            ? 'Vui lòng nhập mật khẩu'
                            : null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 14),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppTheme.grey5,
                    ),
                    child: const Text(
                      'Vui lòng nhập mật khẩu có ít nhất 8 ký tự kết hợp giữa chữ và số, bao gồm ít nhất một chữ cái viết hoa.',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.4),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 20),
                    child: Text(
                      'Nhập lại mật khẩu',
                      style: AppTextStyle.heading4Medium,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 5),
                    height: 44,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.8),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: TextFormField(
                      controller: confirmPWController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              confirm ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                confirm ? confirm = false : confirm = true;
                              });
                            },
                          ),
                          hintText: 'Kiểm tra mật khẩu',
                          hintStyle: AppTextStyle.heading4Grey,
                          border: InputBorder.none,
                          errorStyle: AppTextStyle.heading4Red),
                      obscureText: confirm,
                      validator: (value) {
                        return (value == null || value.isEmpty)
                            ? 'Vui lòng nhập lại mật khẩu'
                            : null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Row(
                      children: [
                        Checkbox(
                            value: checkbox,
                            onChanged: (value) => setState(() {
                                  checkbox = value!;
                                })),
                        SizedBox(
                          width: size.width - 80,
                          child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Tôi đồng ý với các điều khoản và chính sách của E-Shopping',
                                maxLines: 2,
                                style: AppTextStyle.h_underline,
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: size.width,
                    height: 44,
                    color: AppTheme.brandBlue,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!checkbox) {
                          showMaterialDialog(
                              context, '', 'Bạn chưa đồng ý với điều khoản',
                              () {
                            Navigator.pop(context);
                          });
                        } else {
                          if (checkConfirm()) {
                            await authProvider
                                .signup(
                                    emailController.text,
                                    passwordController.text,
                                    phoneNumberController.text)
                                .then((message) => {
                                      showSuccessDialog(context, message),
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()))
                                    })
                                .catchError((error) =>
                                    {showErrorDialog(context, error)});
                          } else {
                            showMaterialDialog(
                                context, '', 'Xác nhận mật khẩu sai', () {
                              Navigator.pop(context);
                            });
                          }
                        }
                      },
                      child: const Text(
                        'Đăng kí',
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Bạn đã có tài khoản chưa?',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          height: 2.0,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      TextButton(
                        child: const Text(
                          'Đăng nhhập',
                          style: AppTextStyle.h_underline_grey,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
