import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/product_detail.dart';
import 'package:safe_food/src/resource/model/review_product.dart';
import 'package:safe_food/src/resource/model/size.dart';
import 'package:safe_food/src/resource/provider/cart_item_provider.dart';
import 'package:safe_food/src/resource/provider/product_detail_provider.dart';
import 'package:safe_food/src/resource/provider/product_provider.dart';
import 'package:safe_food/src/resource/provider/review_product_provider.dart';
import 'package:safe_food/src/resource/provider/size_provider.dart';
import 'package:safe_food/src/resource/utils/enums/helpers.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, @required this.productId});
  final int? productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController contentController = TextEditingController();
  int index_size = -1;
  int amount = 1;

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    Provider.of<ReviewProvider>(context, listen: false)
        .getListReview(widget.productId!);
    Provider.of<SizeProvider>(context, listen: false).getListSize();
    super.initState();
  }

  void reloadUI() {
    setState(() {
      Provider.of<ReviewProvider>(context, listen: false)
          .getListReview(widget.productId!);
      contentController.text = "";
    });
  }

  int getTotalStock(ProductDetail productDetail) {
    int total = 0;
    productDetail.sizeData!.forEach((size) {
      total += size.amount!;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final NumberFormat decimalFormat =
        NumberFormat.simpleCurrency(locale: 'vi-VN');

    final productProvider = Provider.of<ProductProvider>(context);

    final reviewProductProvider = Provider.of<ReviewProvider>(context);
    final List<ReviewProduct> comments = reviewProductProvider.listComment;

    final productdetailProvider = Provider.of<ProductDetailProvider>(context);
    final cartProvider = Provider.of<CartItemProvider>(context);
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
                            await cartProvider
                                .addToCart(
                                    productDetail.id,
                                    productDetail.sizeData[index_size].size.id,
                                    amount)
                                .then((message) => {
                                      setState(() {
                                        amount = 1;
                                      }),
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          message,
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
                            style: AppTextStyle.heading3Light,
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
                            style: AppTextStyle.heading3Light,
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
                      onPressed: () async {
                        await productProvider
                            .createProductFavourite(widget.productId!)
                            .then((message) => {
                                  Provider.of<ProductProvider>(context,
                                          listen: false)
                                      .getListFavorite(),
                                  showSuccessDialog(context, message)
                                })
                            .catchError(
                                (error) => {showErrorDialog(context, error)});
                      },
                      icon: const FaIcon(FontAwesomeIcons.heartCirclePlus)),
                  IconButton(
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.bagShopping)),
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
                      height: 320,
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
                            width: size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 30),
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
                                    Row(
                                      children: [
                                        Text(
                                          decimalFormat.format(double.parse(
                                              productDetail.price)),
                                          style:
                                              AppTextStyle.heading3CustomColor,
                                        ),
                                        const SizedBox(
                                          width: 194,
                                        ),
                                        Text(
                                          'Kho: ${getTotalStock(productDetail)}',
                                          style:
                                              AppTextStyle.heading3CustomColor,
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Tình trạng: ${productDetail.status ? 'Còn hàng' : 'Hết hàng'}',
                                                style:
                                                    AppTextStyle.heading3Black,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Loại hàng: ${productDetail.category.name}',
                                                style:
                                                    AppTextStyle.heading3Black,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            const Text(
                                              'Số lượng',
                                              style: AppTextStyle.heading3Black,
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        amount++;
                                                      });
                                                    },
                                                    icon: const FaIcon(
                                                        FontAwesomeIcons
                                                            .circlePlus)),
                                                Text(
                                                  amount.toString(),
                                                  style: AppTextStyle
                                                      .heading3Black,
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    if (amount > 1) {
                                                      setState(() {
                                                        amount--;
                                                      });
                                                    }
                                                  },
                                                  icon: const FaIcon(
                                                      FontAwesomeIcons
                                                          .circleMinus),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Size',
                                      style: AppTextStyle.heading3Black,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          // padding: EdgeInsets.only(top: 10),
                                          width: size.width / 1.7,
                                          height: 40,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                productDetail.sizeData.length,
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
                                                          width: 1,
                                                          style: BorderStyle
                                                              .solid),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10))),
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
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                        'Thông số',
                                                        style: AppTextStyle
                                                            .heading3Black,
                                                      ),
                                                      content: Consumer<
                                                          SizeProvider>(
                                                        builder: (context,
                                                            sizeProvider,
                                                            child) {
                                                          List<Size> listSize =
                                                              sizeProvider
                                                                  .listSize;
                                                          return SizedBox(
                                                              width: 200,
                                                              height: 250,
                                                              child: ListView
                                                                  .builder(
                                                                itemCount:
                                                                    listSize
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return Container(
                                                                    width: size
                                                                        .width,
                                                                    height: 82,
                                                                    margin: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            7),
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            35,
                                                                        right:
                                                                            35,
                                                                        top:
                                                                            10),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color: Colors
                                                                                .grey,
                                                                            width:
                                                                                0.8),
                                                                        borderRadius:
                                                                            const BorderRadius.all(Radius.circular(10))),
                                                                    child: Column(
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              const Text(
                                                                                'Size name',
                                                                                style: AppTextStyle.heading3Black,
                                                                              ),
                                                                              Text('${listSize[index].sizeName}', style: AppTextStyle.heading3Black)
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              const Text(
                                                                                'Height',
                                                                                style: AppTextStyle.heading3Black,
                                                                              ),
                                                                              Text('${listSize[index].height}', style: AppTextStyle.heading3Black)
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              const Text(
                                                                                'Weigh',
                                                                                style: AppTextStyle.heading3Black,
                                                                              ),
                                                                              Text('${listSize[index].weigh}', style: AppTextStyle.heading3Black)
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                        ]),
                                                                  );
                                                                },
                                                              ));
                                                        },
                                                      ),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                            'Ok',
                                                            style: AppTextStyle
                                                                .heading3Black,
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 39,
                                              decoration: const BoxDecoration(
                                                  color: AppTheme.color2,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8))),
                                              child: const Center(
                                                child: Text(
                                                  'Xem thông số',
                                                  style: AppTextStyle
                                                      .heading4Black,
                                                ),
                                              ),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Mô tả',
                                        style: AppTextStyle.heading3Black,
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          child: Text(
                                              '${productDetail.description}',
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins-Light',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    comments.isEmpty
                                        ? const Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 150),
                                            child: Text(
                                              'Không có bình luận',
                                              style: AppTextStyle.heading3Black,
                                            ),
                                          )
                                        : Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                left: 12,
                                                right: 12,
                                              ),
                                              child: ListView.builder(
                                                itemCount: comments.length,
                                                itemBuilder: (context, index) {
                                                  return Card(
                                                    shadowColor: Colors.black,
                                                    elevation: 4,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 15),
                                                    child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 8,
                                                                    left: 8,
                                                                    top: 8),
                                                            width: 50,
                                                            height: 60,
                                                            child: ClipOval(
                                                                child: comments[index]
                                                                            .user!
                                                                            .userInformation !=
                                                                        null
                                                                    ? Image
                                                                        .network(
                                                                        '${comments[index].user?.userInformation?.userImage}',
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        errorBuilder: (BuildContext context,
                                                                            Object
                                                                                exception,
                                                                            StackTrace?
                                                                                stackTrace) {
                                                                          return const Text(
                                                                              '...');
                                                                        },
                                                                      )
                                                                    : const Icon(
                                                                        Icons
                                                                            .person)),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          SizedBox(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    comments[index].user!.userInformation !=
                                                                            null
                                                                        ? Row(
                                                                            children: [
                                                                              Text('${comments[index].user?.userInformation?.firstName}',
                                                                                  style: const TextStyle(
                                                                                    fontSize: 16,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontFamily: 'Poppins-Light',
                                                                                  )),
                                                                              const SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Text('${comments[index].user?.userInformation?.lastName}',
                                                                                  style: const TextStyle(
                                                                                    fontSize: 16,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontFamily: 'Poppins-Light',
                                                                                  )),
                                                                            ],
                                                                          )
                                                                        : const Text(
                                                                            'Customer',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Poppins-Light',
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.bold)),
                                                                    SizedBox(
                                                                      width: 30,
                                                                    ),
                                                                    Text(
                                                                        comments[index]
                                                                            .createdAt!
                                                                            .split('T')[0],
                                                                        style: AppTextStyle.h_grey_no_underline),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      size.width -
                                                                          150,
                                                                  child: Text(
                                                                    '${comments[index].content}',
                                                                    style: AppTextStyle
                                                                        .h_grey_no_underline,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 6,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ]),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                    Container(
                                      width: size.width - 60,
                                      padding: const EdgeInsets.only(left: 20),
                                      margin: const EdgeInsets.only(bottom: 6),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child: TextField(
                                        controller: contentController,
                                        decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              onPressed: () async {
                                                await reviewProductProvider
                                                    .createComment(
                                                        contentController.text,
                                                        widget.productId!)
                                                    .then((message) => {
                                                          showSuccessDialog(
                                                              context, message)
                                                        })
                                                    .catchError((error) => {
                                                          showErrorDialog(
                                                              context, error)
                                                        });
                                                reloadUI();
                                              },
                                              icon: const Icon(Icons
                                                  .keyboard_double_arrow_right),
                                            ),
                                            icon: const Icon(
                                              Icons.comment_sharp,
                                              color: Colors.grey,
                                            ),
                                            hintText: 'Comment',
                                            labelStyle:
                                                AppTextStyle.heading4Light,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              )),
    );
  }
}
