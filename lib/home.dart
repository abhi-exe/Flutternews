import 'package:flutter/material.dart';
import 'package:flutter_application_1/apicall.dart';
import 'package:flutter_application_1/article_details_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Article>> futurearticles;

  @override
  void initState() {
    super.initState();
    futurearticles = Apiservice.apisrv();
  }

  // loadnews() async{
  //   final results= await Apiservice.apisrv();
  //   print(results.length);
  //   for(int i=0;i<results.length;i++){
  //     print(results[i].title);
  //   }
  // }
  // void refresh() {
  //   setState(() {
  //     futurearticles = Apiservice.apisrv();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
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
      body: RefreshIndicator(onRefresh:() async{
        var articles= await Apiservice.apisrv();
        setState(() {
          futurearticles=Future.value(articles);
        });
      } ,child: Center(
        child: FutureBuilder<List<Article>>(
          future: futurearticles,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    Article article = snapshot.data![index];
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
                  itemCount: snapshot.data!.length);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Column(mainAxisAlignment: MainAxisAlignment.center,children: [Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('We are Loading News...',style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),),
            ),
            LinearProgressIndicator(color: Colors.red,)],);
          },
        ),
      ),)
    );




    // return Container(
    //   color: Colors.grey,
    //   padding: const EdgeInsets.all(18.0),
    //   child: const Text('This is News', style: TextStyle(fontFamily: 'Georgia', fontSize: 45.0),),
    // );
  }

  detpagenav(context, Article article){
    Navigator.push(context,MaterialPageRoute(builder: (context)=> ArticleDetailsScreen(article: article)));
  }
}
