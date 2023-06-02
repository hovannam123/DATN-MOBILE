import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        children: [
          Container(
            height: size.height / 15,
            width: size.width - 100,
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ))),
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                        hintText: 'Search',
                        hintStyle: AppTextStyle.h_grey_no_underline,
                        border: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: size.height / 15,
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {},
              icon: FaIcon(FontAwesomeIcons.sliders),
            ),
          ),
        ],
      ),
    );
  }
}
