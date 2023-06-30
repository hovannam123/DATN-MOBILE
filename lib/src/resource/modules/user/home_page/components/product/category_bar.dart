import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/category.dart';
import 'package:safe_food/src/resource/provider/category_provider.dart';
import 'package:safe_food/src/resource/provider/product_provider.dart';

class CategoryBar extends StatefulWidget {
  const CategoryBar({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryBar> createState() => _CategoryBarState();
}

class _CategoryBarState extends State<CategoryBar> {
  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false).getListCategory(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final categoryProvider = Provider.of<CategoryProvider>(context);
    final List<Category> listCategory = categoryProvider.listCategory;
    final int selectedIndex = categoryProvider.selectedIndex;

    return SizedBox(
      height: size.height / 15,
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
    );
  }
}
