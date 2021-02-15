
import 'package:flutter/material.dart';
import 'package:noticias/src/models/category_model.dart';
import 'package:noticias/src/services/news_service.dart';
import 'package:noticias/src/theme/tema.dart';
import 'package:noticias/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatefulWidget {
  @override
  _Tab2PageState createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
       
        _ListaCategoria(),
          
        Expanded(
          child:(newsService.getArticulosCategoriaSeleccionada.length==0)
          ? Center(
            child: CircularProgressIndicator()
          ) 
          : ListaNoticias(newsService.getArticulosCategoriaSeleccionada) ,
        )         
        ],
      )
      
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _ListaCategoria extends StatelessWidget { 
  @override

  Widget build(BuildContext context) {
    final categorias=Provider.of<NewsService>(context).categorias;
    return Container(
      width: double.infinity,
      height: 110.0,
        child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categorias.length,
        itemBuilder: (BuildContext context, int index){

          final categoriaName=categorias[index].name;

          return Container(
           // width: 110,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  _CategoryBoton(categorias[index]),
                  SizedBox(height: 5,),
                  Text('${categoriaName[0].toUpperCase()}${categoriaName.substring(1)}')
                  
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryBoton extends StatelessWidget {

  final Categoria categoria;

  const _CategoryBoton(this.categoria);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: (){
       // print('${categoria.name}');
       final newsService = Provider.of<NewsService>(context,listen: false);
       newsService.selecteCategory=categoria.name;
      },

        child: SafeArea(
                  child: Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white

          ),
          child: Icon(
            categoria.icon,
            color: (newsService.selecteCategory==this.categoria.name)
                   ? miTema.accentColor
                   : Colors.black54,
          ),

      ),
        ),
    );
  }
}