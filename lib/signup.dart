import 'main.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget{
@override
_SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: const Color.fromRGBO(235,233,233,1),
      body: Stack(
        children: <Widget> [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.only(left: 25.0, top: 35.0),
              child: Icon(Icons.arrow_back_ios, color: Colors.white,),
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 35,),
          child: Column(
            children: <Widget>[
              _getHeader(),
              _getInputs(),
              _getSignUp(context),
              _getBottomRow(context),
            ],
          ),
          )

        ],
      ),
    );
  }
}

_getHeader(){
  return Expanded(
    flex: 2,
    child: Container(
      alignment: Alignment.bottomLeft,
      child: Text(
        "Регистрация ",
        style: TextStyle(color: Colors.black, fontSize: 37),
      ),
    ),);
}

_getInputs() {
  return Expanded(
    flex: 5,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            labelText: 'Имя',
            labelStyle: TextStyle(color: Colors.black),
          ),
          onChanged: (String value){
            login = value;
          },
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              labelText: 'E-mail',
              labelStyle: TextStyle(color: Colors.black)),
          onChanged: (String value){
            email = value;
          },
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            labelText: 'Пароль',
            labelStyle: TextStyle(color: Colors.black),
          ),
          onChanged: (String value){
            password = value;
          },
        ),
        SizedBox(
          height: 15,
        ),
      ],
    ),
  );
}

_getSignUp(context) {
  return Expanded(
    flex: 2,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Регистрация',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        GestureDetector(
          onTap: (){
            if (true){
            showDialog<String>(
              context: context,
              builder: (BuildContext context1) => AlertDialog(
                title: const Text('AlertDialog Title'),
                content: const Text('AlertDialog description'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () { Navigator.pop(context, 'Cancel');Navigator.pop(context, 'Cancel');},
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () { Navigator.pop(context, 'OK');Navigator.pop(context, 'OK');},
                    child: const Text('OK'),
                  ),
                ],
              ),
            );}
          },
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade800,
            radius: 40,
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ),
        )
      ],
    ),
  );
}

_getBottomRow(context) {
  return Expanded(
    flex: 1,
    child: Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            'Вход',
            style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline),
          ),
        ),
      ],
    ),
  );
}