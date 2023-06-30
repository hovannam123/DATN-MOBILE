import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/model/user_information.dart';
import 'package:safe_food/src/resource/modules/user/forget_password/forget_password.dart';
import 'package:safe_food/src/resource/provider/user_provider.dart';
import 'package:safe_food/src/resource/utils/enums/helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class DetailProfile extends StatefulWidget {
  const DetailProfile({super.key});

  @override
  State<DetailProfile> createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile> {
  String url = '';
  UserInformation userInformation = UserInformation();
  String dropdownValue = 'Nam';
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtBirtday = TextEditingController();
  TextEditingController txtPhoneNum = TextEditingController();

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getUserDetail();
    super.initState();
  }

  @override
  void dispose() {
    txtBirtday.dispose();
    txtFirstName.dispose();
    txtLastName.dispose();
    txtPhoneNum.dispose();
    super.dispose();
  }

  void reloadUI() {
    setState(() {
      Provider.of<UserProvider>(context, listen: false).getUserDetail();
      txtBirtday.text = "";
      txtFirstName.text = "";
      txtLastName.text = "";
      txtPhoneNum.text = "";
    });
  }

  Future<void> getImage() async {
    String imagePath = '';
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath = pickedFile.path;
    }
    setState(() {
      url = imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context);
    final User? user = userProvider.user;

    return Container(
      decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
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
            "PROFILE",
            style: AppTextStyle.heading2Black,
          ),
          centerTitle: true,
          actions: [
            user!.active! == false
                ? IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SendEmail(
                                    isResetPW: false,
                                  )));
                    },
                    icon: const Icon(
                      Icons.warning_amber,
                      color: Colors.red,
                    ))
                : SizedBox(),
          ],
        ),
        body: SingleChildScrollView(
          child: userProvider.isLoad
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  width: size.width,
                  height: size.height,
                  padding: const EdgeInsets.only(top: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            url == ''
                                ? Container(
                                    width: 140,
                                    height: 140,
                                    decoration: BoxDecoration(
                                        color: Colors.pink.shade100,
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(100)),
                                        image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: NetworkImage(user
                                                    .userInformation
                                                    ?.userImage ??
                                                'https://cdn-icons-png.flaticon.com/512/2815/2815428.png'))),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, right: 8),
                                        child: IconButton(
                                          icon: const FaIcon(
                                            FontAwesomeIcons.images,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () {
                                            getImage();
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                : Stack(
                                    children: [
                                      SizedBox(
                                        width: 140,
                                        height: 140,
                                        child: ClipOval(
                                          child: Image.file(
                                            File(url),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 75),
                                        child: IconButton(
                                          icon: FaIcon(
                                            FontAwesomeIcons.images,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () {
                                            getImage();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  user.userInformation?.firstName ?? " ",
                                  style: AppTextStyle.heading2Black,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  user.userInformation?.lastName ?? " ",
                                  style: AppTextStyle.heading2Black,
                                ),
                              ],
                            ),
                            Text(
                              '${user.email}',
                              style: AppTextStyle.heading3Black,
                            ),
                            Text(
                              user.userInformation?.birthday?.split("T")[0] ??
                                  " ",
                              style: AppTextStyle.heading3Black,
                            ),
                            Text(
                              user.phoneNumber ?? " ",
                              style: AppTextStyle.heading3Black,
                            ),
                          ],
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
                          controller: txtFirstName,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon:
                                    Image.asset('assets/images/btnCancel.png'),
                                onPressed: () {},
                              ),
                              hintText: 'Nhập họ',
                              hintStyle: AppTextStyle.heading4Grey,
                              border: InputBorder.none,
                              errorStyle: AppTextStyle.heading4Grey),
                          onChanged: (value) {
                            userInformation.firstName = value.toString();
                          },
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
                          controller: txtLastName,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon:
                                    Image.asset('assets/images/btnCancel.png'),
                                onPressed: () {},
                              ),
                              hintText: 'Nhập tên',
                              hintStyle: AppTextStyle.heading4Grey,
                              border: InputBorder.none,
                              errorStyle: AppTextStyle.heading4Grey),
                          onChanged: (value) {
                            userInformation.lastName = value.toString();
                          },
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
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/vietnam_flag.png',
                              width: 35,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: txtPhoneNum,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    hintText: 'Nhập số điện thoại',
                                    hintStyle: AppTextStyle.heading4Grey,
                                    border: InputBorder.none,
                                    errorStyle: AppTextStyle.heading4Grey),
                                onChanged: (value) {
                                  userInformation.firstName = value.toString();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 15, right: 5),
                          margin: const EdgeInsets.only(top: 20),
                          height: 50,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            border: Border.all(color: Colors.black, width: 0.8),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: DropdownButton<String>(
                            hint: const Text(
                              'Chọn giới tính',
                              style: AppTextStyle.heading4Grey,
                            ),
                            value: dropdownValue,
                            // icon: const Icon(Icons.arrow_downward),
                            // iconSize: 15,
                            elevation: 16,
                            style: AppTextStyle.heading4Black,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>['Nam', 'Nữ']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )),
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
                          controller: txtBirtday,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon:
                                    Image.asset('assets/images/btnCancel.png'),
                                onPressed: () {},
                              ),
                              hintText: 'Nhập ngày sinh',
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
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: TextButton(
                          child: const Text(
                            'Cập nhập',
                            style: AppTextStyle.heading2Light,
                          ),
                          onPressed: () async {
                            await userProvider
                                .updateUserInformation(
                                    txtFirstName.text,
                                    txtLastName.text,
                                    dropdownValue == 'Nam' ? true : false,
                                    txtBirtday.text)
                                .then((message) => {
                                      showSuccessDialog(context, message),
                                      reloadUI()
                                    })
                                .catchError((error) =>
                                    {showErrorDialog(context, error)});
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
