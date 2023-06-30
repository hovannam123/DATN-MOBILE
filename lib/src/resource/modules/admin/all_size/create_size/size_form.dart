import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/provider/size_provider.dart';
import 'package:safe_food/src/resource/utils/enums/helpers.dart';

class SizeForm extends StatefulWidget {
  const SizeForm({super.key});

  @override
  State<SizeForm> createState() => _SizeFormState();
}

class _SizeFormState extends State<SizeForm> {
  TextEditingController txtSizeName = TextEditingController();
  TextEditingController txtWeigh = TextEditingController();
  TextEditingController txtHeight = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    txtSizeName.dispose();
    txtWeigh.dispose();
    txtHeight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizeProvider = Provider.of<SizeProvider>(context);
    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'CREATE SIZE',
              style: AppTextStyle.heading2Black,
            ),
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 5),
                  child: Text(
                    'Nhập tên size',
                    style: AppTextStyle.heading4Grey,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 5),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    border: Border.all(color: Colors.black, width: 0.8),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextFormField(
                    controller: txtSizeName,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Image.asset('assets/images/btnCancel.png'),
                          onPressed: () {},
                        ),
                        hintText: 'Nhập tên size',
                        hintStyle: AppTextStyle.heading4Grey,
                        border: InputBorder.none,
                        errorStyle: AppTextStyle.heading4Red),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Hãy nhập tên size';
                      }
                      return null;
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 5),
                  child: Text(
                    'Nhập chiều cao',
                    style: AppTextStyle.heading4Grey,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 5),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    border: Border.all(color: Colors.black, width: 0.8),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextFormField(
                    controller: txtHeight,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Image.asset('assets/images/btnCancel.png'),
                          onPressed: () {},
                        ),
                        hintText: 'Nhập chiều cao',
                        hintStyle: AppTextStyle.heading4Grey,
                        border: InputBorder.none,
                        errorStyle: AppTextStyle.heading4Red),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Hãy nhập chiều cao';
                      }
                      return null;
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 5),
                  child: Text(
                    'Nhập cân nặng',
                    style: AppTextStyle.heading4Grey,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 5),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    border: Border.all(color: Colors.black, width: 0.8),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextFormField(
                    controller: txtWeigh,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Image.asset('assets/images/btnCancel.png'),
                          onPressed: () {},
                        ),
                        hintText: 'Nhập cân nặng',
                        hintStyle: AppTextStyle.heading4Grey,
                        border: InputBorder.none,
                        errorStyle: AppTextStyle.heading4Red),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Hãy nhập cân nặng';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  width: size.width,
                  padding: const EdgeInsets.only(left: 15, right: 5),
                  margin: const EdgeInsets.only(top: 50),
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppTheme.color1,
                    border: Border.all(color: Colors.black, width: 0.8),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextButton(
                    child: const Text(
                      'Create size',
                      style: AppTextStyle.heading3Black,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await sizeProvider
                            .createSize(
                                txtSizeName.text, txtWeigh.text, txtHeight.text)
                            .then(
                              (message) => {
                                showSuccessDialog(context, message),
                                sizeProvider.getListSize(),
                                Navigator.pop(context)
                              },
                            )
                            .catchError(
                                (error) => {showErrorDialog(context, error)});
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
