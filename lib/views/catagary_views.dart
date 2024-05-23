import 'package:flutter/material.dart';
import 'package:newsapp/models/articlemodule.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/views/home.dart';
class CatagoryNews extends StatefulWidget {
  final String category;
  const CatagoryNews({super.key,required this.category});

  @override
  State<CatagoryNews> createState() => _CatagoryNewsState();
}

class _CatagoryNewsState extends State<CatagoryNews> {

   List<Articlemodule> articles= <Articlemodule>[];
  bool _loading=true; 
   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCatNews();
  }

  
  getCatNews() async{
    CatogoryNews newsclass=CatogoryNews();
    await newsclass.getcatsnews(widget.category);
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
        actions: [
          Opacity(
            opacity: 0,
            child:Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            )
          )
        ],
        centerTitle: true,
        elevation: 0.0,
      ),

      body:_loading ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ): 
      SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
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
          ),
        ),
      )
    );
  }
}