import 'package:flutter/material.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/modules/user/forget_password/verify_code.dart';

import '../../../api/api_request.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Tìm mật khẩu',
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
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Email',
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
                        errorStyle: AppTextStyle.heading4Grey),
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
                    'Nhập địa chỉ email bạn đã đăng ký và chúng tôi sẽ gửi cho bạn URL đặt lại mật khẩu.',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.4),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  width: size.width,
                  height: 44,
                  color: AppTheme.brandBlue,
                  child: ElevatedButton(
                    onPressed: () {
                      ApiRequest.instance
                          .forgetPassword(emailController.text)
                          .then((message) => {
                                print(message),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VerifyCode(
                                            email: emailController.text)))
                              })
                          .catchError((message) => {print(message)});
                    },
                    child: const Text(
                      'Tiếp tục',
                      style: AppTextStyle.heading3Light,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
