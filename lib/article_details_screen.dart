import 'package:flutter/material.dart';
import 'package:flutter_application_1/apicall.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailsScreen extends StatelessWidget{
  final Article article;
  const ArticleDetailsScreen({super.key, required this.article});
  void _launchURL(String url) async {
    Uri url1=Uri.parse(url);
  if (await canLaunchUrl(url1)) {
    await launchUrl(url1);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
        title: const Text(
          "Flutter News App",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Georgia',
          ),
        ),
        backgroundColor: const Color.fromARGB(197, 233, 10, 10),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
              Image.network(article.imageurl),
              Container (
                padding: const EdgeInsets.all(8),
                child: Text(article.title, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)), // Container
              Container (
                padding: const EdgeInsets.fromLTRB(10,2, 10,2),
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(article.sourcename),
                    Text(article.publishedAt),
                  ],
                ),),
              Container(
                padding: const EdgeInsets.all(8),
                child: Text(article.content, style:const TextStyle(
                  fontSize: 17,
                  fontFamily: 'Georgia',
                ),),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(120, 40, 120, 0),
                decoration: BoxDecoration(shape: BoxShape.rectangle,borderRadius:BorderRadius.circular(5)),
                child: ElevatedButton(onPressed: () {
                  _launchURL(article.url);
                },
                style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.red),
                child: const Text('Open in Browser'),),
              ) ]// Container
          ), //
    );
  }
}


