import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/modules/user/forget_password/reset_password.dart';
import 'package:safe_food/src/resource/modules/user/home_page/home_page.dart';
import 'package:safe_food/src/resource/provider/auth_provider.dart';
import 'package:safe_food/src/resource/utils/enums/helpers.dart';

class VerifyCode extends StatefulWidget {
  const VerifyCode({super.key, required this.email, required this.isResetPW});

  final String email;
  final bool isResetPW;

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final TextEditingController verifyCodeController = TextEditingController();
  bool isVerifyCode = false;
  @override
  void dispose() {
    verifyCodeController.dispose();
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
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Nhập mã xác minh gồm 6 chữ số',
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
                  Text(
                    'Nhập mã xác minh gồm 6 chữ số được gửi tới ${widget.email}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        height: 1.4),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 5),
                    margin: const EdgeInsets.only(top: 10),
                    height: 44,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.8),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: TextFormField(
                      controller: verifyCodeController,
                      decoration: const InputDecoration(
                          hintText: 'Mã số',
                          hintStyle: AppTextStyle.heading4Grey,
                          border: InputBorder.none,
                          errorStyle: AppTextStyle.heading4Grey),
                      onChanged: (value) {
                        setState(() {
                          isVerifyCode = true;
                        });
                        if (value.isEmpty) {
                          setState(() {
                            isVerifyCode = false;
                          });
                        }
                      },
                      validator: (_) {},
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    width: size.width,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            !isVerifyCode ? Colors.grey : AppTheme.brandBlue),
                      ),
                      onPressed: !isVerifyCode
                          ? null
                          : () async {
                              await authProvider
                                  .verify(
                                      widget.email, verifyCodeController.text)
                                  .then((message) => {
                                        showSuccessDialog(context, message),
                                        if (widget.isResetPW)
                                          {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ResetPassword(
                                                            email:
                                                                widget.email)))
                                          }
                                        else
                                          {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomePage()))
                                          }
                                      })
                                  .catchError((error) =>
                                      {showErrorDialog(context, error)});
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
