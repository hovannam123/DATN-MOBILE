import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/modules/user/forget_password/verify_code.dart';
import 'package:safe_food/src/resource/provider/auth_provider.dart';
import 'package:safe_food/src/resource/utils/enums/helpers.dart';

class SendEmail extends StatefulWidget {
  const SendEmail({super.key, required this.isResetPW});
  final bool isResetPW;

  @override
  State<SendEmail> createState() => _SendEmailState();
}

class _SendEmailState extends State<SendEmail> {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
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
            'Xác minh',
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
                      'Nhập địa chỉ email bạn đã đăng ký và chúng tôi sẽ gửi cho bạn mã code có 6 chữ số.',
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
                      onPressed: () async {
                        await authProvider
                            .forgetPassword(emailController.text)
                            .then((message) => {
                                  showSuccessDialog(context, message),
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VerifyCode(
                                                email: emailController.text,
                                                isResetPW: widget.isResetPW,
                                              )))
                                })
                            .catchError(
                                (error) => {showErrorDialog(context, error)});
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
      ),
    );
  }
}
