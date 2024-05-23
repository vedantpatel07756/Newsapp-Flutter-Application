// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/helper/data.dart';
import "package:newsapp/models/CategoryModels.dart";
import 'package:newsapp/models/articlemodule.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/views/article_views.dart';
import 'package:newsapp/views/catagary_views.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModels> myCategories= <CategoryModels>[];
  List<Articlemodule> articles= <Articlemodule>[];

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    myCategories=getCategories();
    getNews();
  }


  getNews() async{
    News newsclass=News();
    await newsclass.getnews();
    articles = newsclass.news;
    setState(() {
      _loading=false;
    });
  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            Text("News"),
            Text("App",style: TextStyle(
              color: Colors.blue
            ),)
          ],
        ),
        elevation: 0.0,
      ),
      body:_loading ? Container(
        child: CircularProgressIndicator(),
      ): SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child:Column(
            children: [
              // Categories 
              Container(
                height: 70,
                child: ListView.builder(
                  itemCount: myCategories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return CatagoryTitle(
                      imageUrl:myCategories[index].imageUrl,
                      catagoryName:myCategories[index].categoryName,
        
                    );
                  },
                ),
              ),
        
              // Blogs 
              Container(
                padding: EdgeInsets.only(top: 6),
                child: ListView.builder(
                  itemCount: articles.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder:(context,index){
                    return BlogTile(imageUrl: articles[index].urlToImage, title: articles[index].title, desc: articles[index].description,url:articles[index].url);
                  } ),
              )
            ],
          ) ,
        ),
      )
    );
  }
}

class CatagoryTitle extends StatelessWidget {

  final String imageUrl, catagoryName;

  const CatagoryTitle({super.key,required this.imageUrl, required this.catagoryName});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CatagoryNews(category: catagoryName.toLowerCase())));
      },
      child: Container(
        margin: EdgeInsets.only(right:16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl,width: 120,height: 60,fit: BoxFit.cover,)),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              width: 120,height: 60,
              child: Text(catagoryName, style: const TextStyle(
              color: Colors.white,
              ),),
            )
          ],
        ),
      ),
    );
  }
}


class BlogTile extends StatelessWidget {

  final String imageUrl,title,desc,url;
  const BlogTile({ super.key,required this.imageUrl, required this.title, required this.desc,required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
  
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleView(blogurl: url)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl)),
            const SizedBox(height: 12,),
            Text(title,style:const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            )),
            const SizedBox(height: 8,),
            Text(desc, style: const TextStyle(
              fontSize: 12,
              color: Colors.black45,
            )),
          ],
        ),
      ),
    );
  }
}