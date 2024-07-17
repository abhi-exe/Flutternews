import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/article_details_screen.dart';
import 'package:flutter_application_1/models/article.dart';
import 'package:flutter_application_1/services/apicall.dart';
import 'package:flutter_application_1/services/dataprovider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Homepg extends ConsumerWidget{
  const Homepg({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final datawatcher=ref.watch(dataProvider);

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
        centerTitle: false,
        actions: const [],
      ),
      body: RefreshIndicator(onRefresh: () async {return ref.refresh(articleProvider);},
        child: Center(
          child: datawatcher.when(data: (datawatcher){
            List<Article> mylist=datawatcher.map((e)=>e).toList();
            return ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        Article article = mylist[index];
                        return ListTile(
                          //leading: Image.network('https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp'),
                          //leading: CircleAvatar(backgroundImage: NetworkImage(article.imageurl)),
                          leading: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 44,
                              minHeight: 44,
                              maxWidth: 64,
                              maxHeight: 64,
                            ),
                            child:
                                Image.network(article.imageurl, fit: BoxFit.cover),
                          ),
                          title: Text(article.title),
                          subtitle: Text(article.publishedAt),
                          isThreeLine: true,
                          //trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: ()=>detpagenav(context, article),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                            color: Colors.black,
                          ),
                      itemCount: mylist.length);
          }, error: (err,s)=>Text(err.toString()), loading:() {return const Column(mainAxisAlignment: MainAxisAlignment.center,children: [Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('We are Loading News...',style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),),
                ),
                LinearProgressIndicator(color: Colors.red,)],);
              }),
        ),
      ),
    );
}
detpagenav(context, Article article){
    Navigator.push(context,MaterialPageRoute(builder: (context)=> ArticleDetailsScreen(article: article)));
  }
}