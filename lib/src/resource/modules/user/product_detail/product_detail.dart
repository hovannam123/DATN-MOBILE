import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/api/api_request.dart';
import 'package:safe_food/src/resource/provider/product_detail_provider.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:safe_food/src/resource/store_data/store_data.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int index_size = -1;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final NumberFormat decimalFormat =
        NumberFormat.simpleCurrency(locale: 'vi-VN');
    final productdetailProvider = Provider.of<ProductDetailProvider>(context);
    final productDetail = productdetailProvider.productDetail;
    return Container(
      decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
      child: productdetailProvider.isLoad
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              bottomNavigationBar: Container(
                color: Colors.white54,
                padding: const EdgeInsets.only(
                    top: 10, bottom: 20, right: 15, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: size.width / 2.5,
                      height: 40,
                      decoration: const BoxDecoration(
                          color: AppTheme.color2,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextButton(
                        onPressed: () async {
                          if (index_size != -1) {
                            int? user_id = await StoreData().retrieveUserId();
                            await ApiRequest.instance
                                .addToCart(
                                    productDetail.id,
                                    productDetail.sizeData[index_size].size.id,
                                    1,
                                    user_id!)
                                .then((message) => {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          '$message',
                                          style: const TextStyle(
                                              color: AppTheme.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        backgroundColor: Colors.grey,
                                      ))
                                    })
                                // ignore: invalid_return_type_for_catch_error
                                .catchError((err) => {
                                      if (err is Exception)
                                        {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                              err
                                                  .toString()
                                                  .split("Exception: ")[1],
                                              style: const TextStyle(
                                                  color: AppTheme.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            backgroundColor: Colors.grey,
                                          ))
                                        }
                                    });
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                'Vui lòng chọn size',
                                style: TextStyle(
                                    color: AppTheme.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: Colors.grey,
                            ));
                          }
                        },
                        child: const Center(
                          child: Text(
                            'Thêm vào giỏ',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                height: 1.6,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width / 2.5,
                      height: 40,
                      decoration: const BoxDecoration(
                          color: AppTheme.color2,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextButton(
                        onPressed: () {},
                        child: const Center(
                          child: Text(
                            'Mua ngay',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                height: 1.6,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: FaIcon(FontAwesomeIcons.bagShopping))
                ],
              ),
              body: SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                    width: size.width - 120,
                    height: size.height / 2.4,
                    decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image:
                      //       NetworkImage('${productDetail.imageOrigin}'),
                      //   fit: BoxFit.fill,
                      // ),
                      border: Border.all(
                          color: Colors.white,
                          width: 3,
                          style: BorderStyle.solid),
                    ),
                    child: ImageSlideshow(children: [
                      Image.network(
                        '${productDetail.imageOrigin}',
                        loadingBuilder: (context, child, loadingProgress) {
                          return loadingProgress == null
                              ? child
                              : Text('No image exist');
                        },
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        '${productDetail.imageOrigin}',
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        '${productDetail.imageOrigin}',
                        fit: BoxFit.cover,
                      ),
                    ]),
                  ),
                  Container(
                    width: size.width,
                    height: size.height / 2.2,
                    margin: EdgeInsets.only(top: 20),
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    decoration: const BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        )),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          child: TabBar(
                            controller: _tabController,
                            unselectedLabelColor: Colors.black,
                            indicator: const BoxDecoration(
                                color: AppTheme.color3,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            tabs: const [
                              Tab(
                                child: Text(
                                  'Product',
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Detail',
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Review',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 14),
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${productDetail.name}',
                                    style: AppTextStyle.heading2CustomColor,
                                  ),
                                  Text(
                                    '${decimalFormat.format(double.parse(productDetail.price))}',
                                    style: AppTextStyle.heading3CustomColor,
                                  ),
                                  Text(
                                    'Tình trạng: ${productDetail.status ? 'Còn hàng' : 'Hết hàng'}',
                                    style: AppTextStyle.heading3Black,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Loại hàng: ${productDetail.category.name}',
                                    style: AppTextStyle.heading3Black,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Size',
                                    style: AppTextStyle.heading3Black,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10),
                                    width: size.width,
                                    height: 50,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: productDetail.sizeData.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            print(index_size);
                                            setState(() {
                                              index_size = index;
                                            });
                                          },
                                          child: Container(
                                            width: 60,
                                            height: 40,
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            decoration: BoxDecoration(
                                                color: index_size == index
                                                    ? AppTheme.color2
                                                    : null,
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 2,
                                                    style: BorderStyle.solid),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Center(
                                              child: Text(
                                                '${productDetail.sizeData[index].size.sizeName}',
                                                style: AppTextStyle
                                                    .h_grey_no_underline,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Mô tả',
                                      style: AppTextStyle.heading3Black,
                                    ),
                                    Text('${productDetail.description}',
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.black)),
                                  ],
                                ),
                              ),
                              Text('data'),
                            ],
                          ),
                        ))
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}
