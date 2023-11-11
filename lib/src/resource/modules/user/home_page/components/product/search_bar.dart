import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/category.dart';
import 'package:safe_food/src/resource/model/product.dart';
import 'package:safe_food/src/resource/provider/category_provider.dart';
import 'package:safe_food/src/resource/provider/product_provider.dart';

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
    Provider.of<CategoryProvider>(context, listen: false).getListCategory(2);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final Size size = MediaQuery.of(context).size;
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final List<Category> listCategory = categoryProvider.listCategory;
    final int selectedIndex = categoryProvider.selectedIndex;

    return Column(
      children: [
        Padding(
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
                            icon: const Icon(
                              Icons.search,
                              color: Colors.black,
                            ))),
                    Expanded(
                      child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                              hintText: 'Tìm kiếm',
                              hintStyle: AppTextStyle.h_grey_no_underline,
                              border: InputBorder.none),
                          onChanged: (value) => {
                                Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .searchProduct(
                                        listCategory[selectedIndex].id!, value)
                              }),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height / 15,
                margin: const EdgeInsets.only(left: 10),
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
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
              itemCount: listCategory.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    categoryProvider.setSelectedIndex(index);
                    Provider.of<ProductProvider>(context, listen: false)
                        .getListProductByCategory(listCategory[index].id!);

                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => ShowMovieByGenre(results: lstResults, genres: widget.lstGenres?[index]))
                    //     );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 16),
                    alignment: Alignment.center,
                    width: size.width / 4,
                    decoration: selectedIndex == index
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppTheme.color1)
                        : BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(12),
                          ),
                    child: Text(
                      '${listCategory[index].name}',
                      style: AppTextStyle.h_grey_no_underline,
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
