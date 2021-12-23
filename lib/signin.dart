import 'dart:io';
import 'dart:typed_data';

import 'main.dart';
import 'package:flutter/material.dart';
import 'signup.dart';

class SignInPage extends StatefulWidget{
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(235,233,233,1),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("Профиль"),
        ),
        body:

        Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
              child: Column(
                children:<Widget> [
                  _getLogHead(),
                  _getLog(),
                  _getLogSignIn(context),
                  _getLogFoot(context),
                  /*_getPage(),*/

                ],
              ),
            )
          ],
        )

    );
  }
}

_getLogHead(){
  return Expanded(flex: 3, child: Column(children: [Text("Hello!", style: TextStyle(fontSize: 65),)],));
}
_getLog(){
  return Expanded(
    flex: 4,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "login"),
              onChanged: (String value){
                login = value;
              },
            )),
        SizedBox(
          height: 15,
        ),
        Expanded(child: TextField(decoration: InputDecoration(labelText: "password"),
          onChanged: (String value){
            password = value;
          },
        )),
        SizedBox(
          height: 15,
        ),
      ],
    ),
  );
}
_getLogSignIn(context){
  return Expanded(
      flex: 1,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Вход", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),),
            GestureDetector(
              onTap:() async {
                int port =8000;

                Socket client = await Socket.connect('192.168.1.69', port);
                port=port+1;
                await sendMessage(client, "Authorization\n");
                client.flush();

                client = await Socket.connect('192.168.1.69', port);
                port = port+1;
                await sendMessage(client, login+"\n");
                client.flush();

                client = await Socket.connect('192.168.1.69', port);
                port = port +1;
                await sendMessage(client, password+"\n");
                client.flush();

                final socket = await Socket.connect('192.168.1.69', 9000);
                socket.listen(

                    // handle data from the server
                        (Uint8List data) {
                      final serverResponse = String.fromCharCodes(data);                //переменная которая содержит ответ от сервера
                      response = serverResponse;
                      print('Server: $serverResponse');
                    },
                    onError: (error) {
                  print(error);
                  socket.destroy();
                },

                // handle server ending connection
                onDone: () {
                print('Server left.');
                socket.destroy();
                },
                );

                /*client = await Socket.connect('192.168.1.69', port);
                await sendMessage(client, "Card\n");
                port=port+1;
                client.flush();*/

                /*client = await Socket.connect('192.168.1.69', port);
                await sendMessage(client, "Close\n");
                port=port+1;
                client.flush();*/

                if (response=="ok"){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                } else if (response=="no"){
                  return showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: const <Widget>[
                              Text('Ошибка. Попробуйте снова.'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
                response = "";
              },
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade800,
                radius: 40,
                child: Icon(Icons.arrow_forward_ios_outlined),
              ),
            )
          ]
      ));
}
_getLogFoot(context){
  return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
            },
            child: Text(
              'Регистрация',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline
              ),),
          ),
          Text(
            'Забыли пароль',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline
            ),
          )
        ],
      ));
}