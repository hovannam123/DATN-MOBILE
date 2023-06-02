import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cart_item/cart_item_screen.dart';
import 'components/category_bar.dart';
import 'components/item_page.dart';
import 'components/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;

  final tabs = [
    Column(
      children: [SearchBar(), CategoryBar(), ItemPage()],
    ),
    Center(
      child: Text('bbb'),
    ),
    Center(
      child: Text('cccc'),
    ),
    Center(
      child: Text('ho tro'),
    ),
  ];

  Future<void> _launchUrl(String url) async {
    if (await launchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.platformDefault);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: FaIcon(FontAwesomeIcons.bars),
            onPressed: () async {
              // String url = await ApiRequest.instance.createPayment();
              // _launchUrl(url);
              // _launchUrl('http://192.168.1.23:3000/api/v1/all-category');
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartItemScreen()));
                },
                icon: FaIcon(
                  FontAwesomeIcons.bagShopping,
                ))
          ],
        ),
        body: SingleChildScrollView(child: tabs[_selectedTab]),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
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
              items: const [
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.house), label: "Home"),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.solidBookmark),
                    label: "Favorite"),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.solidUser), label: "Profile"),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.gear), label: "More"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
