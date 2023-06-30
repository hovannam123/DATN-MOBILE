import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/model/user_information.dart';
import 'package:safe_food/src/resource/modules/user/forget_password/forget_password.dart';
import 'package:safe_food/src/resource/provider/user_provider.dart';
import 'package:safe_food/src/resource/provider/voucher_provider.dart';
import 'package:safe_food/src/resource/utils/enums/helpers.dart';

class CreateVoucherScreen extends StatefulWidget {
  const CreateVoucherScreen({super.key});

  @override
  State<CreateVoucherScreen> createState() => _CreateVoucherScreenState();
}

class _CreateVoucherScreenState extends State<CreateVoucherScreen> {
  TextEditingController txtPercent = TextEditingController();
  TextEditingController txtStartAt = TextEditingController();
  TextEditingController txtEndAt = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    txtPercent.dispose();
    txtStartAt.dispose();
    txtEndAt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final voucherProvider = Provider.of<VoucherProvider>(context);

    return Container(
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 240, 242, 247)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "Create voucher",
            style: AppTextStyle.heading2Black,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
              width: size.width,
              height: size.height,
              padding: const EdgeInsets.only(top: 10),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 5),
                    margin: const EdgeInsets.only(top: 20),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      border: Border.all(color: Colors.black, width: 0.8),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: TextFormField(
                      controller: txtPercent,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Image.asset('assets/images/btnCancel.png'),
                            onPressed: () {},
                          ),
                          hintText: 'Value percent',
                          hintStyle: AppTextStyle.heading4Grey,
                          border: InputBorder.none,
                          errorStyle: AppTextStyle.heading4Grey),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 5),
                    margin: const EdgeInsets.only(top: 20),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      border: Border.all(color: Colors.black, width: 0.8),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: TextFormField(
                      controller: txtStartAt,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Image.asset('assets/images/btnCancel.png'),
                            onPressed: () {},
                          ),
                          hintText: 'Start At (yyyy-mm-dd)',
                          hintStyle: AppTextStyle.heading4Grey,
                          border: InputBorder.none,
                          errorStyle: AppTextStyle.heading4Grey),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 5),
                    margin: const EdgeInsets.only(top: 20),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      border: Border.all(color: Colors.black, width: 0.8),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: TextFormField(
                      controller: txtEndAt,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Image.asset('assets/images/btnCancel.png'),
                            onPressed: () {},
                          ),
                          hintText: 'End at (yyyy-mm-dd)',
                          hintStyle: AppTextStyle.heading4Grey,
                          border: InputBorder.none,
                          errorStyle: AppTextStyle.heading4Grey),
                      onChanged: (value) {},
                    ),
                  ),
                  Container(
                    width: size.width - 50,
                    height: 50,
                    margin: const EdgeInsets.only(top: 50),
                    decoration: const BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: TextButton(
                      child: const Text(
                        'Create',
                        style: AppTextStyle.heading2Light,
                      ),
                      onPressed: () async {
                        await voucherProvider
                            .createVoucher(
                              txtPercent.text,
                              txtStartAt.text,
                              txtEndAt.text,
                            )
                            .then((message) => {
                                  showSuccessDialog(context, message),
                                  voucherProvider.getAllVoucher(),
                                  Navigator.pop(context),
                                })
                            .catchError(
                                (error) => {showErrorDialog(context, error)});
                      },
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
