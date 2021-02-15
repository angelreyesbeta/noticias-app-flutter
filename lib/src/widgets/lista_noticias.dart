import 'package:flutter/material.dart';
import 'package:noticias/src/models/news_models.dart';
import 'package:noticias/src/theme/tema.dart';

class ListaNoticias extends StatelessWidget {

 final List<Article> noticias;

  const ListaNoticias(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index){
        return _Noticia(
          index:index ,
          noticia: this.noticias[index],
        );
      },
      
    );
  }
}

class _Noticia extends StatelessWidget {

  final Article noticia;
  final int index;

  const _Noticia({
  @required this.noticia, 
  @required this.index
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TarjetaTopBar(noticia,index),
        _TarjetaTitulo(noticia),
        _TarjetaImagen(noticia),
        _TarjetaBody(noticia),
        _tarjetaBotones(),
        SizedBox(height: 10,),
        Divider(),
      ],
    );
  }
}
class _tarjetaBotones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          RawMaterialButton(
            onPressed: (){},
            fillColor: miTema.accentColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.star_border),
          ),
          SizedBox(width: 10,),
          RawMaterialButton(
            onPressed: (){},
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.more),
          )
        ],
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {

  final Article noticia;

  const _TarjetaBody(this.noticia); 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child:(noticia.description != null)? Text(noticia.description):'',
      
    );
  }
}

class _TarjetaImagen extends StatelessWidget {

  final Article noticia;

  const _TarjetaImagen( this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
        child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
            child: Container(
          child: (noticia.urlToImage != null) ? FadeInImage(
            placeholder:AssetImage('assets/img/giphy.gif') ,
            image: NetworkImage(noticia.urlToImage),
          ) : Image(
                image: AssetImage('assets/img/no-image.png'),
              )
        ),
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article noticia;

  const _TarjetaTitulo( this.noticia);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(noticia.title, style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
      
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  
  final Article noticias;
  final int index;

  const _TarjetaTopBar(this.noticias, this.index);

  @override

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
           Row(
          
          children: <Widget>[
            Text('${index+1} ', style: TextStyle(color: miTema.accentColor),),
            Text('${noticias.source.name} - '),
            
          ],
          
        ),
        SizedBox(height: 10,),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('${noticias.author}'),
              Text('${noticias.publishedAt}'),
            ],
          )

        ],
          
         
      ),
      

    );
  }
}