import 'dart:convert';

import 'package:flutter_application_1/models/article.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Apiservice{
   Future<List<Article>> apisrv() async{
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

final articleProvider= Provider<Apiservice>((ref){
  return Apiservice();
});


//final articleProvider=Provider<Future<List<Article>>>((ref)=>Apiservice.apiserv());