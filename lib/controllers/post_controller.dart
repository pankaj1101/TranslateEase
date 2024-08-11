import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:sample/model/post_model.dart';

class PostController extends GetxController {
  RxList<PostModel> postModelData = <PostModel>[].obs;

  Future<void> getPostData(String lang) async {
    try {
      String endPoint = 'https://jsonplaceholder.typicode.com/posts?lang=$lang';
      var response = await get(
        Uri.parse(endPoint),
        headers: {
          'Accept-Language': lang,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        postModelData.value =
            jsonData.map((e) => PostModel.fromJson(e)).toList();
      }
    } catch (e) {
      print('Exception $e');
    }
  }
}
