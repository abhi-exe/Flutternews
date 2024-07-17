import 'apicall.dart';
import 'package:flutter_application_1/models/article.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dataProvider= FutureProvider<List<Article>>((ref) async {
  return ref.watch(articleProvider).apisrv();
});
