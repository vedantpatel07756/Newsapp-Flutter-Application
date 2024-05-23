import 'dart:convert';

import 'package:newsapp/models/articlemodule.dart';
import 'package:http/http.dart' as http;

class News{

  List<Articlemodule> news=[];

  Future<void> getnews() async{
     String url="https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=f53fc72b54724215b83b6cca9fbf49e7";

     var response = await http.get(Uri.parse(url));
     var jsonData = jsonDecode(response.body);

     if(jsonData["status"]=="ok"){

      jsonData["articles"].forEach((element){

        if(element["urlToImage"] != null && element["description"] != null && element["author"] != null && element["content"] != null){

          Articlemodule articleModule = Articlemodule(
              author:element["author"],
              title:element["title"],
              description:element["description"],
              url:element["url"],
              urlToImage:element["urlToImage"],
              content: element["content"],
             
             );

             news.add(articleModule);

        }

      });
     }

  }

 
}

class CatogoryNews{
  
  List<Articlemodule> news=[];

  Future<void> getcatsnews(String category) async{
     String url="https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=f53fc72b54724215b83b6cca9fbf49e7";

     var response = await http.get(Uri.parse(url));
     var jsonData = jsonDecode(response.body);

     if(jsonData["status"]=="ok"){

      jsonData["articles"].forEach((element){

        if(element["urlToImage"] != null && element["description"] != null && element["author"] != null && element["content"] != null){

          Articlemodule articleModule = Articlemodule(
              author:element["author"],
              title:element["title"],
              description:element["description"],
              url:element["url"],
              urlToImage:element["urlToImage"],
              content: element["content"],
             
             );

             news.add(articleModule);

        }

      });
     }

  }

 
}