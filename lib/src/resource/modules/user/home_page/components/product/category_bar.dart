import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';

class CategoryBar extends StatefulWidget {
  const CategoryBar({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryBar> createState() => _CategoryBarState();
}

class _CategoryBarState extends State<CategoryBar> {
  int? selectedIndex;
  late List<String> lstGenres = ["Tất cả", "Áo sơ mi", "Áo polo", "Áo T-shirt"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 15,
      child: ListView.builder(
          itemCount: lstGenres.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ShowMovieByGenre(results: lstResults, genres: widget.lstGenres?[index]))
                //     );
                print(lstGenres[0]);
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
                  '${lstGenres[index]}',
                  style: AppTextStyle.h_grey_no_underline,
                ),
              ),
            );
          }),
    );
  }
}
