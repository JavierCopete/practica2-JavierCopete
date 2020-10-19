import 'package:flutter/material.dart';
import 'dog_model.dart';
import 'dart:async';

class DogDetailPage extends StatefulWidget {
  final Dog dog;
  DogDetailPage(this.dog);

  @override
  _DogDetailPageState createState() => new _DogDetailPageState();
}

class _DogDetailPageState extends State<DogDetailPage> {
  final double dogAvarterSize = 150.0;
  double _sliderValue = 10.0;

  Widget get addYourRating {
    return new Column(
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Flexible(
                flex: 1,
                child: new Slider(
                  activeColor: Colors.cyan, //Cambiar color barra puntuacion
                  min: 0.0,
                  max: 15.0,
                  value: _sliderValue,
                  onChanged: (newRating) {
                    setState(() {
                      _sliderValue = newRating;
                    });
                  },
                ),
              ),
              new Container(
                width: 50.0,
                alignment: Alignment.center,
                child: new Text('${_sliderValue.toInt()}',
                    style: Theme.of(context).textTheme.display1),
              ),
            ],
          ),
        ),
        submitRatingButton,
      ],
    );
  }

  //Cambiar la puntuacion de 10 a 5
  void updateRating() {
    if (_sliderValue < 5) {
      _ratingErrorDialog();
    } else {
      setState(() {
        widget.dog.rating = _sliderValue.toInt();
      });
    }
  }

  //Mensaje al poner una puntuacion menor de 5
  Future<Null> _ratingErrorDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('Error!'),
            content: new Text("Ellos son buenos periquitos :("),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Vuelve a intentarlo'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

//cambiar color boto puntuar
  Widget get submitRatingButton {
    return new RaisedButton(
      onPressed: () => updateRating(),
      child: new Text('Puntúa!'),
      color: Colors.cyan,
    );
  }

  Widget get dogImage {
    return new Hero(
      tag: widget.dog,
      child: new Container(
        height: dogAvarterSize,
        width: dogAvarterSize,
        constraints: new BoxConstraints(),
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              const BoxShadow(
                  offset: const Offset(1.0, 2.0),
                  blurRadius: 2.0,
                  spreadRadius: -1.0,
                  color: const Color(0x33000000)),
              const BoxShadow(
                  offset: const Offset(2.0, 1.0),
                  blurRadius: 3.0,
                  spreadRadius: 0.0,
                  color: const Color(0x24000000)),
              const BoxShadow(
                  offset: const Offset(3.0, 1.0),
                  blurRadius: 4.0,
                  spreadRadius: 2.0,
                  color: const Color(0x1f000000))
            ],
            image: new DecorationImage(
                fit: BoxFit.cover,
                image: new NetworkImage(widget.dog.imageUrl ?? ''))),
      ),
    );
  }

//Cambiar icon de la estrella
  Widget get rating {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Icon(
          Icons.favorite_border,
          size: 40.0,
        ),
        new Text(
          '${widget.dog.rating}/10',
          style: Theme.of(context).textTheme.display2,
        )
      ],
    );
  }

//Cambiar fondo y opacidad al entrar a un periquito
  Widget get dogProfile {
    return new Container(
      padding: new EdgeInsets.symmetric(vertical: 32.0),
      decoration: new BoxDecoration(
        image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.7), BlendMode.dstATop),
            image: new NetworkImage(
                "https://i.pinimg.com/originals/90/6e/9f/906e9f31df45658088049e29f35ebd0a.jpg"),
            fit: BoxFit.cover),
      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          dogImage,
          new Text(
            '${widget.dog.name}',
            style: TextStyle(fontSize: 40.0), //Cambiar tamaño del titulo
          ),
          new Text(
            widget.dog.location,
            style: TextStyle(fontSize: 20.0),
          ),
          new Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: new Text(widget.dog.description),
          ),
          rating
        ],
      ),
    );
  }

//Cambiar color parte superior dentro
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(26, 35, 85, 1),
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(26, 35, 85, 1),
        title: new Text('Conoce el ${widget.dog.name}'),
      ),
      body: new ListView(
        children: <Widget>[dogProfile, addYourRating],
      ),
    );
  }
}
