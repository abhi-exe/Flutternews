import 'dart:convert';

import 'package:http/http.dart' as http;


class Article{
   String author;
   String descrp;
   String title;
   String publishedAt;
   String content;
   String sourceid;
   String sourcename;
   String imageurl;
   String url;

  Article({
    required this.author,
    required this.title,
    required this.descrp,
    required this.publishedAt,
    required this.content,
    required this.sourceid,
    required this.sourcename,
    required this.imageurl,
    required this.url,
   });

   factory Article.fromJson(Map<String, dynamic> json){
    return Article(author: json['author'],
    title: json['title'],
    descrp: json['description'],
    publishedAt: json['publishedAt'],
    content: json['content'],
    sourceid: json['source']['id'],
    sourcename: json['source']['name'],
    imageurl: json['urlToImage'],
    url: json['url']
    );
   }
}


class Apiservice{
  static Future<List<Article>> apisrv() async{
    http.Response response;
    Uri url=Uri.parse('https://mocki.io/v1/a3b52530-9ce3-4d02-b057-e59ef3aab339');
    await  Future.delayed(const Duration(seconds: 5));
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
