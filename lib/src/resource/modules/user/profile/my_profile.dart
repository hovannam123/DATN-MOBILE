import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/product.dart';
import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/modules/user/profile/detail_profile.dart';
import 'package:safe_food/src/resource/provider/product_provider.dart';
import 'package:safe_food/src/resource/provider/user_provider.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getUserDetail();
    super.initState();
  }

  // void reloadUI() {
  //   setState(() {
  //     Provider.of<UserProvider>(context, listen: false).getListFavorite();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context);
    final User? user = userProvider.user;

    return userProvider.isLoad
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            width: size.width,
            height: size.height,
            padding: const EdgeInsets.only(top: 10),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              children: [
                SizedBox(
                  width: size.width,
                  child: Row(
                    children: [
                      SizedBox(
                          child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                            color: Colors.pink.shade100,
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(user
                                        ?.userInformation?.userImage ??
                                    'https://cdn-icons-png.flaticon.com/512/2815/2815428.png'))),
                      )),
                      const SizedBox(
                        width: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                user?.userInformation?.firstName ?? " ",
                                style: AppTextStyle.heading2Black,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                user?.userInformation?.lastName ?? " ",
                                style: AppTextStyle.heading2Black,
                              ),
                            ],
                          ),
                          Text(
                            '${user?.email}',
                            style: AppTextStyle.heading3Black,
                          ),
                          Text(
                            user?.userInformation?.birthday?.split("T")[0] ??
                                " ",
                            style: AppTextStyle.heading3Black,
                          ),
                          Text(
                            user?.phoneNumber ?? " ",
                            style: AppTextStyle.heading3Black,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height / 1.8,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListView(children: [
                    SelectionWidget(
                      icData: FontAwesomeIcons.person,
                      title: 'Tài khoản',
                      description: 'Thay đổi tài khoản của bạn',
                      icData2: Icons.warning_amber,
                      icData3: Icons.arrow_forward_ios_outlined,
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailProfile()));
                      },
                    ),
                    SelectionWidget(
                      icData: Icons.local_shipping,
                      title: 'Đơn hàng',
                      description: 'Lịch sử đơn hàng của bạn',
                      icData3: Icons.arrow_forward_ios_outlined,
                      onPress: () {
                        print('object');
                      },
                    ),
                    SelectionWidget(
                      icData: FontAwesomeIcons.bell,
                      title: 'Thông báo',
                      description: 'Cài đặt thông báo',
                      icData3: Icons.arrow_forward_ios_outlined,
                      onPress: () {
                        print('object');
                      },
                    ),
                    SelectionWidget(
                      icData: Icons.lock,
                      title: 'Face ID/ Touch ID',
                      description: 'Quản lí bảo mật của bạn',
                      icData3: FontAwesomeIcons.toggleOff,
                      onPress: () {
                        print('object');
                      },
                    ),
                    SelectionWidget(
                      icData: FontAwesomeIcons.info,
                      title: 'Help/Support',
                      description: 'Call helpdesk',
                      icData3: Icons.arrow_forward_ios_outlined,
                      onPress: () {
                        print('object');
                      },
                    ),
                    SelectionWidget(
                      icData: Icons.privacy_tip_outlined,
                      title: 'About App',
                      description: 'Chính sách của ứng dụng',
                      icData3: Icons.arrow_forward_ios_outlined,
                      onPress: () {
                        print('object');
                      },
                    ),
                    SelectionWidget(
                      icData: Icons.logout,
                      title: 'Log out',
                      description: '',
                      icData3: Icons.arrow_forward_ios_outlined,
                      onPress: () {
                        print('object');
                      },
                    ),
                  ]),
                )
              ],
            ));
  }
}

class SelectionWidget extends StatelessWidget {
  const SelectionWidget({
    super.key,
    @required this.icData,
    @required this.title,
    @required this.description,
    this.icData2,
    @required this.icData3,
    this.onPress,
  });
  final IconData? icData;
  final String? title;
  final String? description;
  final IconData? icData2;
  final IconData? icData3;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final User? user = userProvider.user;
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        // border: Border.all(color: Colors.grey, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100))),
                    child: Icon(icData)),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      style: AppTextStyle.heading3Black,
                    ),
                    Text(description!, style: AppTextStyle.heading4Black),
                  ],
                ),
              ],
            ),
            icData2 != null
                ? user!.active!
                    ? SizedBox()
                    : Column(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Icon(
                              icData2,
                              color: Colors.red,
                            ),
                          ),
                          const Text(
                            'Not Verify',
                            style: AppTextStyle.heading4Red,
                          )
                        ],
                      )
                : SizedBox(),
            IconButton(onPressed: () {}, icon: Icon(icData3))
          ],
        ),
      ),
    );
  }
}
