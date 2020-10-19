import 'package:flutter/material.dart';
import 'dart:async';

import 'dog_model.dart';
import 'dog_list.dart';
import 'new_dog_form.dart';

void main() => runApp(MyApp());

//Cambio de titulos
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Periquitos',
      theme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(
        title: 'Calificamos Periquitos!',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//Cambio de los datos de los periquitos
class _MyHomePageState extends State<MyHomePage> {
  List<Dog> initialDoggos = []
    ..add(Dog(
        'Periquito Común',
        'Australia',
        'El periquito común es la clase de periquito que solemos encontrar más a menudo en nuestras casas. Podemos encontrarlos en verde y en azul, pero lo que les caracteriza son las líneas onduladas en horizontal que van desde la cabeza hasta las alas. ',
        'https://wikifaunia.com/wp-content/uploads/2013/11/periquito-comun1.jpg'))
    ..add(Dog(
        'Periquito Canela',
        'Australia',
        'El periquito canela es una raza de periquito caracterizada por tener las líneas onduladas de la cabeza de color marrón claro en vez de negras. En esta variedad de periquito el color principal puede ser verde o azul',
        'https://img.milanuncios.com/fg/3507/13/350713782_1.jpg?VersionId=YVOiB28.sEVL_9iyiy8EFPS7JKJQE.3F'))
    ..add(Dog(
        'Periquito Opalino',
        'Australia',
        'El periquito opalino es una raza de periquito que se caracteriza por tener las alas del mismo color que el color del cuerpo. Las líneas onduladas de las alas son negras pero las de la cabeza en esta raza casi no se distinguen.',
        'https://iorigen.com/wp-content/uploads/2013/08/opalinomalvayayo1.jpg'))
    ..add(Dog(
        'Periquito Ino',
        'Australia',
        'El periquito ino es una clase de periquito que se asemeja a un canario por no tener líneas onduladas. Esta raza de periquito es característica por no tener melanina, que es la sustancia que da color a las líneas onduladas.',
        'https://tandymascotas.alias.ideared.eu/wp-content/uploads/2016/04/ino-tandy-1-274x300.jpg'))
    ..add(Dog('Periquito Rostral', 'Australia', 'El periquito rostral tiene el cuerpo de color azul y el rostro, en vez de blanco, es de color amarillo. ', 'https://www.periquitos-australianos.com/colores/genetica/ejemplo_2.jpg'))
    ..add(Dog('Periquito Perlado', 'Australia', 'El periquito perlado tiene el rostro completamente amarillo si es de la línea verde o completamente blanco si es de la línea azul. Se caracteriza por tener 6 manchas circulares en la zona del cuello que son de color amarillo o blanco con reborde negro.', 'https://i.imgur.com/qLw6O5B.jpg'));

  Future _showNewDogForm() async {
    Dog newDog = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return AddDogFormPage();
    }));
    if (newDog != null) {
      initialDoggos.add(newDog);
    }
  }

//Cambio de color parte titulo
  @override
  Widget build(BuildContext context) {
    var key = new GlobalKey<ScaffoldState>();
    return new Scaffold(
      key: key,
      appBar: new AppBar(
        title: new Text(widget.title),
        backgroundColor: Color.fromRGBO(26, 35, 85, 1),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.add),
            onPressed: _showNewDogForm,
          ),
        ],
      ),

      //Cambio del fondo de pantalla
      body: new Container(
          decoration: new BoxDecoration(
              image: DecorationImage(
            image: new NetworkImage(
                "https://i.pinimg.com/originals/90/6e/9f/906e9f31df45658088049e29f35ebd0a.jpg"),
            fit: BoxFit.cover,
          )),
          child: new Center(
            child: new DogList(initialDoggos),
          )),
    );
  }
}
