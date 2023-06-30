import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/provider/auth_provider.dart';
import 'package:safe_food/src/resource/utils/enums/helpers.dart';
import '../login/login.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key, required this.email});

  final String email;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPWController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPWController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(color: Colors.white),
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
            'Đặt lại mật khẩu',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            icon: Image.asset('assets/images/btnCancel.png'),
                            onPressed: () {
                              passwordController.clear();
                            },
                          ),
                          hintText: 'Nhập mật khẩu mới',
                          hintStyle: AppTextStyle.heading4Grey,
                          border: InputBorder.none,
                          errorStyle: AppTextStyle.heading4Grey),
                      obscureText: true,
                      validator: (value) {},
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
                            icon: Image.asset('assets/images/btnCancel.png'),
                            onPressed: () {
                              confirmPWController.clear();
                            },
                          ),
                          hintText: 'Kiểm tra mật khẩu',
                          hintStyle: AppTextStyle.heading4Grey,
                          border: InputBorder.none,
                          errorStyle: AppTextStyle.heading4Grey),
                      obscureText: true,
                      validator: (value) {},
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    width: size.width,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppTheme.brandBlue),
                      ),
                      onPressed: () async {
                        await authProvider
                            .resetPassword(
                                widget.email, passwordController.text)
                            .then((message) => {
                                  showSuccessDialog(context, message),
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()))
                                })
                            .catchError(
                                (error) => {showErrorDialog(context, error)});
                      },
                      child: const Text(
                        'Xác minh',
                        style: AppTextStyle.heading3Light,
                      ),
                    ),
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
