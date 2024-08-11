import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/controllers/post_controller.dart';
import 'package:sample/model/post_model.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final PostController postController = Get.put(PostController());
  @override
  void initState() {
    super.initState();
    postController.getPostData('en');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('post'.tr),
      ),
      body: Obx(() {
        return postController.postModelData.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: postController.postModelData.length,
                itemBuilder: (context, index) {
                  PostModel data = postController.postModelData[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(data.id.toString()),
                    ),
                    title: Text(data.title!),
                  );
                },
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _showLanguageDialog,
        child: const Icon(Icons.ads_click),
      ),
    );
  }

  void _changeLanguage(String languageCode, String? countryCode) {
    var locale = Locale(languageCode, countryCode);
    Get.updateLocale(locale);
    postController.getPostData(locale.languageCode);
  }

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
                _changeLanguage('en', 'US');
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('English'),
            ),
            TextButton(
              onPressed: () {
                _changeLanguage('ar', 'SA');
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
