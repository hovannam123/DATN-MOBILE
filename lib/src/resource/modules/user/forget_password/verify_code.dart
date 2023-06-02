import 'package:flutter/material.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/modules/user/forget_password/reset_password.dart';

import '../../../api/api_request.dart';

class VerifyCode extends StatefulWidget {
  const VerifyCode({super.key, required this.email});

  final String email;

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final TextEditingController verifyCodeController = TextEditingController();
  bool isVerifyCode = false;

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
                        : () {
                            ApiRequest.instance
                                .verify(widget.email, verifyCodeController.text)
                                .then((message) => {
                                      print(message),
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ResetPassword(
                                                      email: widget.email)))
                                    })
                                .catchError((mesaage) => {print(mesaage)});
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
    );
  }
}
