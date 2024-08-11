import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/controllers/category_controller.dart';
import 'package:sample/controllers/language_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryController categoryController = Get.put(CategoryController());
  final LanguageController languageController = Get.put(LanguageController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getCategoryApiCall());
  }

  Future<void> getCategoryApiCall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode');
    await categoryController.getCategory(
      languageCode ?? languageController.currentLocale.value.languageCode,
    );

    if (categoryController.categoriesModelData.value != null &&
        categoryController.categoriesModelData.value!.categories != null &&
        categoryController.categoriesModelData.value!.categories!.isNotEmpty) {
      categoryController.setCategoryId(categoryController
          .categoriesModelData.value!.categories!.first.categoryId!);
      await categoryController.getProduct(
        languageCode ?? languageController.currentLocale.value.languageCode,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('categories'.tr),
      ),
      body: Column(
        children: [
          // This is working properly
          Obx(
            () {
              if (categoryController.categoriesModelData.value == null) {
                return const Center(child: CircularProgressIndicator());
              }
              var categories =
                  categoryController.categoriesModelData.value!.categories;
              if (categories == null || categories.isEmpty) {
                return const Center(child: Text('No Data'));
              }

              // Display the categories
              return Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      padding: const EdgeInsets.only(left: 20),
                      itemBuilder: (context, index) {
                        var category = categories[index];
                        var categoryId = category.categoryId!;

                        return InkWell(
                          radius: 50,
                          onTap: () {
                            categoryController.setCategoryId(categoryId);
                            categoryController.getProduct(languageController
                                .currentLocale.value.languageCode);
                          },
                          child: GetBuilder<CategoryController>(
                              builder: (controller) {
                            return Column(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      categoryId == controller.categoryId
                                          ? Colors.amber
                                          : Colors.transparent,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(category.image!),
                                  ),
                                ),
                                Text(category.name!)
                              ],
                            );
                          }),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(width: 20);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          // This is not working properly

          GetBuilder<CategoryController>(
            builder: (controller) {
              final productModel = controller.productModelData.value;

              if (productModel == null || productModel.products == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final products =
                  productModel.products![controller.categoryId.toString()] ??
                      [];

              return Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        tileColor: Colors.grey.shade100,
                        leading: CircleAvatar(
                          child: Image.network(product.images!.first),
                        ),
                        trailing: Text('Rs : ${product.cost}'),
                        title: Text(product.name!),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showLanguageDialog,
        child: const Icon(Icons.cached_rounded),
      ),
    );
  }

  // Show Dialog to change language
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: const Text('Choose a language to continue.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                languageController.changeLanguage('en', 'Us');
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('English'),
            ),
            TextButton(
              onPressed: () {
                languageController.changeLanguage('ar', 'SA');
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Arabic'),
            ),
          ],
        );
      },
    );
  }
}
