import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noticias/src/models/category_model.dart';
import 'package:noticias/src/models/news_models.dart';
import 'package:http/http.dart' as http;


final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY='98d35a25b0064167bb3fe66f38bda50b';



class NewsService with ChangeNotifier{

  List<Article> headlines = [];

  String _selecteCategory='technology';



  List<Categoria> categorias= [

    Categoria( FontAwesomeIcons.building, 'business' ),
    Categoria( FontAwesomeIcons.tv, 'entertainment' ),
    Categoria( FontAwesomeIcons.addressCard, 'general' ),
    Categoria( FontAwesomeIcons.headSideVirus, 'health' ),
    Categoria( FontAwesomeIcons.vials, 'science' ),
    Categoria( FontAwesomeIcons.volleyballBall, 'sports' ),
    Categoria( FontAwesomeIcons.memory, 'technology' )

  ];

  Map<String, List<Article>> categoriaArticles={};

  NewsService(){

    this.getTopHeadlines();

    categorias.forEach((itme) {

      this.categoriaArticles[itme.name] = new List();

    });

  }

  get selecteCategory=>this._selecteCategory;
  set selecteCategory(String valor){
    this._selecteCategory=valor;

    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> get getArticulosCategoriaSeleccionada => this.categoriaArticles[this.selecteCategory];

  getTopHeadlines()async{
    final url='$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=co';
    final resp=await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);

    notifyListeners();

  }

  getArticlesByCategory(String category)async{

    if(this.categoriaArticles[category].length>0){
      return this.categoriaArticles[category];

    }

    final url='$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=co&category=$category';
    final resp=await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.categoriaArticles[category].addAll(newsResponse.articles);

    notifyListeners();
  }

  
}