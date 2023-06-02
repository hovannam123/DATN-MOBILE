import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_text_style.dart';
import '../../../../model/product.dart';
import '../../../../provider/product_detail_provider.dart';
import '../../../../provider/product_provider.dart';
import '../../product_detail/product_detail.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  List<Product> products = [];

  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false).getListProduct();

    super.initState();
  }

  @override
  void dispose() {
    print(products.length);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat decimalFormat =
        NumberFormat.simpleCurrency(locale: 'vi-VN');
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.listProduct;
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 20, left: 15),
      child: Column(children: [
        SizedBox(
          height: size.height / 2.2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Provider.of<ProductDetailProvider>(context, listen: false)
                      .getListProduct(products[index].id);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProductDetail()));
                },
                child: Container(
                  margin: EdgeInsets.only(right: 20),
                  width: size.width - 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white54,
                      border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                          style: BorderStyle.solid)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width - 180,
                        height: size.height / 3.4,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                NetworkImage('${products[index].imageOrigin}'),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, top: 10, right: 10),
                        child: Text(
                          '${products[index].name}',
                          style: AppTextStyle.heading3Black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                '${decimalFormat.format(double.parse(products[index].price))}'),
                            IconButton(
                                onPressed: () {},
                                icon: FaIcon(
                                  FontAwesomeIcons.circlePlus,
                                  color: Colors.pink.shade200,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
