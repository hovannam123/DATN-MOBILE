import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/product.dart';
import 'package:safe_food/src/resource/provider/product_provider.dart';
import 'package:safe_food/src/resource/utils/enums/helpers.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false).getListFavorite();

    super.initState();
  }

  void reloadUI() {
    setState(() {
      Provider.of<ProductProvider>(context, listen: false).getListFavorite();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final NumberFormat decimalFormat =
        NumberFormat.simpleCurrency(locale: 'vi-VN');
    final productProvider = Provider.of<ProductProvider>(context);
    final List<Product> products = productProvider.listFavourite;
    return productProvider.isLoad
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : products.isEmpty
            ? const Center(
                child: Text(
                  'Không có sản phẩm yêu thích',
                  style: AppTextStyle.h_grey_no_underline,
                ),
              )
            : Container(
                width: size.width,
                height: size.height - 200,
                padding: EdgeInsets.only(top: 10),
                margin: EdgeInsets.all(5),
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      width: size.width,
                      padding: const EdgeInsets.only(top: 10),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Stack(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Image.network(
                                    '${products[index].imageOrigin}'),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 260,
                                    child: Text(
                                      '${products[index].name}',
                                      style: AppTextStyle.heading3Black,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    'Giá: ${decimalFormat.format(double.parse(products[index].price!))}',
                                    style: AppTextStyle.heading3Black,
                                  ),
                                  Text(
                                    'Tình trạng: ${products[index].status! ? 'Còn hàng' : 'Hết hàng'}',
                                    style: AppTextStyle.heading3Black,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                onPressed: () async {
                                  await productProvider
                                      .deleteProductFavourite(
                                          products[index].id!)
                                      .then((message) => {
                                            showSuccessDialog(context, message),
                                            reloadUI()
                                          });
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.solidHeart,
                                  color: Colors.pink.shade500,
                                )),
                          )
                        ],
                      ),
                    );
                  },
                ));
  }
}
