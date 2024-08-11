import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello',
          'categories': 'Categories',
          'no_data': 'No Data',
          'post': 'Post',
        },
        'ar_SA': {
          'hello': 'مرحبا',
          'categories': 'الفئات',
          'no_data': 'لا توجد بيانات',
          'post': 'بريد'
        },
      };
}
