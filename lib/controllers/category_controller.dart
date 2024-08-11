import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:sample/model/category_model.dart';
import 'package:sample/model/product_model.dart';

class CategoryController extends GetxController {
  var categoriesModelData = Rx<CategoriesModel?>(null);
  var productModelData = Rx<ProductResponse?>(null);

  int? categoryId;

  setCategoryId(int categoryID) {
    categoryId = categoryID;
    update();
  }

  Future<void> getCategory(String langCode) async {
    String language = langCode == 'ar' ? 'Arabic' : 'English';

    try {
      String endPoint =
          'your_api_url';
      var response = await get(
        Uri.parse(endPoint),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        categoriesModelData.value =
            CategoriesModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print('Exception $e');
    }
  }

  Future<void> getHomeScreen(String langCode) async {
    String language = langCode == 'ar' ? 'Arabic' : 'English';
    try {
      String endPoint = 'your_api_url';
      var response = await get(
        Uri.parse(endPoint),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        // print('line 42 :: ${jsonDecode(response.body)}');
        // categoriesModelData.value =
        // CategoriesModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print('Exception $e');
    }
  }

  Future<void> getProduct(String langCode) async {
    String language = langCode == 'ar' ? 'Arabic' : 'English';

    try {
      String endPoint = 'your_api_url';
      var response = await get(
        Uri.parse(endPoint),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        productModelData.value =
            ProductResponse.fromJson(jsonDecode(response.body));
        update();
      }
    } catch (e) {
      print('Exception $e');
    }
  }
}
