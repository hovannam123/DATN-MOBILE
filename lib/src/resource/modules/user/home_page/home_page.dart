import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/modules/user/home_page/components/favourite/favourite_screen.dart';
import 'package:safe_food/src/resource/modules/user/home_page/components/product/favourite_item.dart';
import 'package:safe_food/src/resource/modules/user/home_page/components/product_by_category/product_by_category.dart';
import 'package:safe_food/src/resource/modules/user/profile/my_profile.dart';
import 'package:safe_food/src/resource/provider/category_provider.dart';
import 'package:safe_food/src/resource/provider/product_provider.dart';
import 'package:safe_food/src/resource/provider/user_provider.dart';
import 'package:safe_food/src/resource/repositories/category_repo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cart_item/cart_item_screen.dart';
import 'components/product/category_bar.dart';
import 'components/product/item_page.dart';
import 'components/product/search_bar.dart';
import 'components/product/top_product_selling_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;
  int? selectedindex;

  late final tabs = [
    Column(
      children: const [
        SearchBar(),
        // CategoryBar(),
        ItemPage(),
        TopProductSellingItem(),
        TopFavouriteItem()
      ],
    ),
    const FavouriteScreen(),
    const Center(
      child: Text('ho tro'),
    ),
    const MyProfile(),
  ];

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getUserDetail();
    selectedindex =
        Provider.of<CategoryProvider>(context, listen: false).selectedIndex;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    User? user = userProvider.user;

    return Container(
      decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: IconButton(
            icon: const FaIcon(FontAwesomeIcons.bars),
            onPressed: () {},
          ),
          // title: Padding(
          //   padding: const EdgeInsets.only(left: 50),
          //   child: Text(
          //     'Xin chào ${user?.userInformation?.lastName ?? ''}',
          //     style: AppTextStyle.heading3Light,
          //   ),
          // ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartItemScreen()));
                },
                icon: const FaIcon(
                  FontAwesomeIcons.bagShopping,
                ))
          ],
        ),
        body: SingleChildScrollView(child: tabs[_selectedTab]),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BottomNavigationBar(
              backgroundColor: Colors.black,
              currentIndex: _selectedTab,
              onTap: (index) => setState(() {
                _selectedTab = index;
              }),
              selectedItemColor: AppTheme.color1,
              unselectedItemColor: Colors.black,
              selectedLabelStyle: AppTextStyle.heading3Light,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_outline), label: "Favorite"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.mail_outline), label: "Mail"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline), label: "Profile"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
