import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/size.dart';
import 'package:safe_food/src/resource/modules/admin/all_size/create_size/size_form.dart';
import 'package:safe_food/src/resource/provider/size_provider.dart';

class SizeScreen extends StatefulWidget {
  const SizeScreen({super.key});

  @override
  State<SizeScreen> createState() => _SizeScreenState();
}

class _SizeScreenState extends State<SizeScreen> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weighController = TextEditingController();

  @override
  void initState() {
    Provider.of<SizeProvider>(context, listen: false).getListSize();
    super.initState();
  }

  @override
  void dispose() {
    heightController.dispose();
    weighController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeProvider = Provider.of<SizeProvider>(context);
    final List<Size> listSize = sizeProvider.listSize;
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(color: AppTheme.adminbgColor),
      child: sizeProvider.isLoad
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                backgroundColor: AppTheme.adminbgColor,
                elevation: 0,
                title: const Text(
                  'ALL SIZE',
                  style: AppTextStyle.heading2Black,
                ),
                leading: IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  height: size.height - 100,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: listSize.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: size.width,
                              height: 135,
                              margin: const EdgeInsets.symmetric(vertical: 7),
                              padding: const EdgeInsets.only(
                                  left: 35, right: 35, top: 10),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Size name',
                                      style: AppTextStyle.heading3Black,
                                    ),
                                    Text('${listSize[index].sizeName}',
                                        style: AppTextStyle.heading3Black)
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
                                    Text('${listSize[index].height}',
                                        style: AppTextStyle.heading3Black)
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
                                    Text('${listSize[index].weigh}',
                                        style: AppTextStyle.heading3Black)
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: size.width / 2 - 80,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                          color: AppTheme.color1,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: TextButton(
                                        onPressed: () async {
                                          setState(() {
                                            heightController.text =
                                                listSize[index].height!;
                                            weighController.text =
                                                listSize[index].weigh!;
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                    'Update size',
                                                    style: AppTextStyle
                                                        .heading3Black,
                                                  ),
                                                  content: SizedBox(
                                                    height: size.height / 5,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          'Size ${listSize[index].sizeName}',
                                                          style: AppTextStyle
                                                              .heading3Black,
                                                        ),
                                                        TextField(
                                                          controller:
                                                              heightController,
                                                          style: AppTextStyle
                                                              .heading3Black,
                                                          decoration: const InputDecoration(
                                                              prefix: Text(
                                                                  "Height: "),
                                                              prefixStyle:
                                                                  AppTextStyle
                                                                      .heading3Black),
                                                        ),
                                                        TextField(
                                                          controller:
                                                              weighController,
                                                          style: AppTextStyle
                                                              .heading3Black,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border: null,
                                                                  prefix: Text(
                                                                      "Weigh: "),
                                                                  prefixStyle:
                                                                      AppTextStyle
                                                                          .heading3Black),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                        onPressed: () async {
                                                          sizeProvider
                                                              .updateSize(
                                                                  listSize[
                                                                          index]
                                                                      .id!,
                                                                  weighController
                                                                      .text,
                                                                  heightController
                                                                      .text)
                                                              .then((message) =>
                                                                  {
                                                                    sizeProvider
                                                                        .getListSize(),
                                                                    Navigator.pop(
                                                                        context)
                                                                  });
                                                        },
                                                        child: const Text(
                                                          'Update',
                                                          style: AppTextStyle
                                                              .heading3Black,
                                                        )),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        'Cancel',
                                                        style: AppTextStyle
                                                            .heading3Black,
                                                      ),
                                                    )
                                                  ],
                                                );
                                              });
                                        },
                                        child: const Text(
                                          'Update',
                                          style: AppTextStyle.heading3Black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      width: size.width / 2 - 80,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                          color: AppTheme.color2,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: TextButton(
                                        onPressed: () async {},
                                        child: const Text(
                                          'Delete',
                                          style: AppTextStyle.heading3Black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ]),
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SizeForm()));
                        },
                        child: Container(
                          width: size.width,
                          height: 50,
                          decoration: const BoxDecoration(
                              gradient: AppTheme.gradient_analyse3,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: const Center(
                            child: Text(
                              'Create size',
                              style: AppTextStyle.heading2Black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
