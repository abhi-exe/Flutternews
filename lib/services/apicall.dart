import 'dart:convert';

import 'package:flutter_application_1/models/article.dart';
import 'package:http/http.dart' as http;





class Apiservice{
  static Future<List<Article>> apisrv() async{
    http.Response response;
    Uri url=Uri.parse('https://mocki.io/v1/acefac3f-bad4-4769-9266-ead50a56ff3a');
    await  Future.delayed(const Duration(seconds: 2));
    response=await http.get(url);
    if(response.statusCode==200){
        final data = jsonDecode(response.body);
        final List<Article> list =[];
        for(int i=0; i< data['articles'].length;i++){
          final entry= data['articles'][i];
          list.add(Article.fromJson(entry));
        }
        return list;
    }
    else{
      throw Exception("Server Error");
    }
  } 

}
