import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/category.dart';
import 'package:safe_food/src/resource/provider/category_provider.dart';
import 'package:safe_food/src/resource/provider/product_detail_provider.dart';
import 'package:safe_food/src/resource/provider/product_provider.dart';
import 'package:safe_food/src/resource/utils/enums/helpers.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String url = '';
  final GlobalKey<FormState> _addProductKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  Color colorValidate = Colors.black;
  Category? selectedCategory;

  Future<void> getImage() async {
    String imagePath = '';
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath = pickedFile.path;
    }
    setState(() {
      url = imagePath;
    });
  }

  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false).getListCategory(1);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void reloadUI() {
    Provider.of<ProductDetailProvider>(context, listen: false)
        .getListProductDetail();
    nameController.text = '';
    descriptionController.text = '';
    priceController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFf5f5fa),
      ),
      child: categoryProvider.isLoad
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFFf5f5fa),
                elevation: 0,
                leading: IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: const Text("ADD PRODUCT",
                    style: AppTextStyle.heading2Black),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Form(
                    key: _addProductKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                                width: 180,
                                height: 200,
                                child: IconButton(
                                  onPressed: () {
                                    getImage();
                                  },
                                  icon: url == ''
                                      ? const FaIcon(
                                          FontAwesomeIcons.image,
                                          size: 160,
                                        )
                                      : Image.file(
                                          File(url),
                                          fit: BoxFit.cover,
                                          width: 160,
                                        ),
                                )),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'Product name',
                              style: AppTextStyle.heading4Medium,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 15, right: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: colorValidate, width: 0.8),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Image.asset(
                                        'assets/images/btnCancel.png'),
                                    onPressed: () {
                                      nameController.clear();
                                    },
                                  ),
                                  hintText: 'Enter product name',
                                  hintStyle: AppTextStyle.heading4Grey,
                                  border: InputBorder.none,
                                  errorStyle: AppTextStyle.heading4Red),
                              validator: (input) {
                                if (input!.isEmpty || input == '') {
                                  setState(() {
                                    colorValidate = Colors.red;
                                  });
                                  return 'You have not entered the value';
                                } else {
                                  setState(() {
                                    colorValidate = Colors.black;
                                  });
                                }
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'Description',
                              style: AppTextStyle.heading4Medium,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 15, right: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: colorValidate, width: 0.8),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextFormField(
                              controller: descriptionController,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Image.asset(
                                        'assets/images/btnCancel.png'),
                                    onPressed: () {
                                      descriptionController.clear();
                                    },
                                  ),
                                  hintText: 'Enter description',
                                  hintStyle: AppTextStyle.heading4Grey,
                                  border: InputBorder.none,
                                  errorStyle: AppTextStyle.heading4Red),
                              validator: (input) {
                                if (input!.isEmpty || input == '') {
                                  setState(() {
                                    colorValidate = Colors.red;
                                  });
                                  return 'You have not entered the value';
                                } else {
                                  setState(() {
                                    colorValidate = Colors.black;
                                  });
                                }
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'Product price',
                              style: AppTextStyle.heading4Medium,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 15, right: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: colorValidate, width: 0.8),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextFormField(
                              controller: priceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Image.asset(
                                        'assets/images/btnCancel.png'),
                                    onPressed: () {
                                      priceController.clear();
                                    },
                                  ),
                                  hintText: 'Enter price',
                                  hintStyle: AppTextStyle.heading4Grey,
                                  border: InputBorder.none,
                                  errorStyle: AppTextStyle.heading4Red),
                              validator: (input) {
                                if (input!.isEmpty || input == '') {
                                  setState(() {
                                    colorValidate = Colors.red;
                                  });
                                  return 'You have not entered the value';
                                } else {
                                  setState(() {
                                    colorValidate = Colors.black;
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Column(
                              children: [
                                const Text(
                                  'Loại hàng',
                                  style: AppTextStyle.heading4Medium,
                                ),
                                Container(
                                  width: 120,
                                  padding: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 0.8),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8))),
                                  child: Consumer<CategoryProvider>(
                                      builder: (context, categoryProvider, _) {
                                    List<Category> categories =
                                        categoryProvider.listCategory;
                                    Category? defaultCategory;

                                    if (selectedCategory == null &&
                                        categories.isNotEmpty) {
                                      defaultCategory = categories[0];
                                      selectedCategory = defaultCategory;
                                    }
                                    return DropdownButton<Category>(
                                      value: selectedCategory,
                                      elevation: 16,
                                      style: AppTextStyle.heading4Grey,
                                      onChanged: (Category? newValue) {
                                        setState(() {
                                          selectedCategory = newValue!;
                                        });
                                      },
                                      items: categories
                                          .map<DropdownMenuItem<Category>>(
                                              (Category value) {
                                        return DropdownMenuItem<Category>(
                                          value: value,
                                          child: Text(value.name!),
                                        );
                                      }).toList(),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: TextButton(
                                onPressed: () async {
                                  if (_addProductKey.currentState!.validate()) {
                                    await productProvider
                                        .createProduct(
                                            selectedCategory!.id!,
                                            nameController.text,
                                            descriptionController.text,
                                            double.parse(priceController.text))
                                        .then((message) => {
                                              reloadUI(),
                                              showSuccessDialog(
                                                  context, message)
                                            })
                                        .catchError((error) =>
                                            {showErrorDialog(context, error)});
                                  }
                                },
                                child: Container(
                                  width: size.width - 50,
                                  height: 50,
                                  margin: const EdgeInsets.only(top: 10),
                                  decoration: const BoxDecoration(
                                      color: AppTheme.analyse3,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: const Center(
                                    child: Text(
                                      'Add Product',
                                      style: AppTextStyle.heading3Light,
                                    ),
                                  ),
                                )),
                          )
                        ]),
                  ),
                ),
              ),
            ),
    );
  }
}
