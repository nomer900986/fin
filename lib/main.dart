

import 'package:financial_analysis/signin.dart';
import 'package:financial_analysis/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:financial_analysis/card_list.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

num balance = revenue - expenses;
num revenue = 3000;
num expenses = 1000;
num forecast = 3000;
num remains = forecast - expenses;
String login = "";
String password = "";
String email = "";
String response = '';


Future<void>main() async {

  runApp(const MyApp());




}

Future<void> sendMessage(Socket socket, String message) async {
  print('Client: $message');
  socket.write(message);
  await Future.delayed(Duration(seconds: 2));


}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title of Application',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignInPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }

}


int selectedIndex = 0;
int recentIndex = 0;
Widget _myControl = MyControl();
Widget _myOperations = MyOperations();
Widget _myPlans = MyPlans();
Widget _myMore = MyMore();
Widget _myPlus = MyPlus();
String name_cart = '';
String sum_cart = '';

Widget getBody( ) {
  if (selectedIndex == 0) {
    return _myControl;
  } else if (selectedIndex == 1) {
    return _myOperations;
  } else if (selectedIndex==2){
    return _myPlus;
  }else if(selectedIndex==3) {
    return _myPlans;
  } else {
    return _myMore;
  }
}


class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        unselectedFontSize: 11,
        selectedFontSize: 11,
        currentIndex: selectedIndex,
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined,size: 30),
            label: 'Управление',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted_outlined,size: 30),
            label: 'Операции',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline,size: 45),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined, size: 30, color: Colors.black),
            label: 'Аккаунт',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined, size: 30, color: Colors.black),
            label: 'Настройки',
          ),
        ],
        onTap: (int index) {
          onTapHandler(index);
        },
      ),
    );
  }

  void onTapHandler(int index)  {
    this.setState(() {
      selectedIndex = index;
    });
  }
}

class MyControl extends StatefulWidget {
  const MyControl({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyControlState();
  }
}

class MyControlState extends State<MyControl> {
  String dropdownValue = 'Сентябрь';
  @override
  Widget build(BuildContext context) {
    //return Center(child: Text("Contacts"));
    return Scaffold(
      backgroundColor: const Color.fromRGBO(235,233,233,1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                icon: const Icon(
                  Icons.account_circle_outlined, size: 30, color: Colors.black,
                ),
              onPressed: () {  },

            );
          },
        ),
        actions: <Widget>[

          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_drop_down_outlined),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.white,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь','Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white10,
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Container( padding: const EdgeInsets.fromLTRB(0,0,0,50), child: Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft:Radius.circular(30),
                bottomRight:Radius.circular(30),
              ),
            ),
            child: Column(
              children: <Widget> [
                const Text(
                  'Баланс счетов',
                  textAlign: TextAlign.center,
                ),
                Text(
                  balance.toString()+ ' ₽',
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget> [
                    Row(
                      children: const [
                        Icon(Icons.expand_less, color: Colors.green),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text('Доходы'),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(Icons.expand_more,color: Colors.red),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text('Затраты'),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  verticalDirection: VerticalDirection.up,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget> [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Text(
                            revenue.toString() + ' ₽',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Text(
                            expenses.toString() + ' ₽',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
              ),
              Container( padding: const EdgeInsets.fromLTRB(0,0,0,50), child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                padding: const EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              fixedSize: MaterialStateProperty.all(const Size.fromWidth(175)),
                              backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(196, 196, 196, 1)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    //side: const BorderSide(color: Colors.red)

                                  )
                              )
                          ),
                          onPressed: () {
                            showDialog(context: context, builder: (BuildContext context){
                              return AlertDialog(
                                title: Text('Добавить карту'),
                                content:Container(
                                  width: 300,
                                  height: 200,
                                  child:Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('Название карты: '),
                                          SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: TextField(
                                              onChanged: (String value){
                                                name_cart = value;
                                              },
                                            ),
                                          ),
                                        ],

                                      ),

                                      Row(
                                        children: [
                                          Text('Баланс карты: '),
                                          SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: TextField(
                                              onChanged: (String value){
                                                sum_cart = value;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(onPressed:(){
                                    setState(() {
                                      todoList.add(name_cart);
                                      sum_List.add(sum_cart);
                                    });
                                    Navigator.of(context).pop();

                                  },
                                      child: Text('Добавить')),
                                ],
                              );
                            });

                          },
                          child: const Text('Открыть новый счет', style: TextStyle(
                            color: Colors.black,
                          ),),
                        ),
                        const SizedBox(height: 30),
                      ],

                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: card(),
                          )
                        ]
                    ),

                  ],
                ),
              ),
              ),
              Container( padding: const EdgeInsets.fromLTRB(0,0,0,50), child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(

                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children:  const [
                          Text('Состояние на предыдущий месяц')
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.attach_money_outlined,),
                          Text(' Всего потрачено: ' + remains.toString() + ' ₽',)
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Text('Баланс счетов: ' + forecast.toString() + ' ₽'),
                          Text("Доходы: " +expenses.toString() + ' ₽')
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyOperations extends StatefulWidget {
  const MyOperations({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyOperationsState();
  }
}

class MyOperationsState extends State<MyOperations> {
  List<String> months = ['Сентябрь', 'Октябрь', 'Ноябрь','Декабрь','Январь'];
  String month = 'Сентябрь';
  int index = 0;
  String dropdownValue = 'Операции';
  num monthBalance = 0.0;
  num balance = 0.0;

  increaseMonth(){
    setState(() {
      if (index + 1 > months.length - 1) {
        index = 0;
        month = months.first;
      } else {
        index++;
        month = months.elementAt(index);
      }
    });
  }

  decreaseMonth(){
    setState(() {
      if (index - 1 < 0) {
        index = months.length - 1;
        month = months.last;
      } else {
        index--;
        month = months.elementAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title:
            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_drop_down_outlined),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['Операции', 'Доходы', 'Расходы',]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          actions: <Widget> [
            Builder(
                builder: (BuildContext context) {
                  return IconButton(
                      icon: const Icon(
                        Icons.search_outlined, size: 30, color: Colors.black,),
                      onPressed: () {
                      }
                  );
                }
            ),
            Builder(
                builder: (BuildContext context) {
                  return IconButton(
                      icon: const Icon(
                        Icons.sort_outlined, size: 30, color: Colors.black,),
                      onPressed: () {
                      }
                  );
                }
            ),
        ]

      ),
      body:
      Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Column(
                children: [

                  Row(

                    children: [
                      Icon(Icons.shopping_bag_outlined, size: 30,),
                      Text(' Текущий баланс \n ₽ '+balance.toString()),
                    ],
                  )
                  
                ],
              ),
              
              Column(
                children: [
                  
                  Row(
                    children: [
                      Icon(Icons.account_balance_wallet_outlined, size: 30,),
                      Text(' Месячный баланс \n ₽ '+monthBalance.toString()),
                    ],
                  )
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }
}

class MyPlus extends StatefulWidget{
  const MyPlus({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyPlusState();
  }
}

class MyPlusState extends State<MyPlus>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return Scaffold(
          backgroundColor: const Color.fromRGBO(235,233,233,1),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text("Добавить операцию"),
          ),
          body:
          Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height - 208 ,
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft:Radius.circular(30),
                              topRight:Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(

                                    style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        fixedSize: MaterialStateProperty.all(Size.fromWidth(MediaQuery.of(context).size.width - 20)),
                                        backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(0, 0, 0, 0.25)),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18.0),
                                              //side: const BorderSide(color: Colors.red)

                                            )
                                        )
                                    ),

                                    onPressed: () {},
                                    child: const Text('Доход', style: TextStyle(
                                      color: Colors.black,
                                    ),),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(

                                    style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        fixedSize: MaterialStateProperty.all(Size.fromWidth(MediaQuery.of(context).size.width - 20)),
                                        backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(0, 0, 0, 0.25)),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18.0),
                                              //side: const BorderSide(color: Colors.red)

                                            )
                                        )
                                    ),

                                    onPressed: () {},
                                    child: const Text('Расход', style: TextStyle(
                                      color: Colors.black,
                                    ),),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(

                                    style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        fixedSize: MaterialStateProperty.all(Size.fromWidth(MediaQuery.of(context).size.width - 20)),
                                        backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(0, 0, 0, 0.25)),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18.0),
                                              //side: const BorderSide(color: Colors.red)

                                            )
                                        )
                                    ),

                                    onPressed: () {},
                                    child: const Text('Перевод', style: TextStyle(
                                      color: Colors.black,
                                    ),),
                                  ),
                                ],
                              ),

                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
          )
      );
  }

}

class MyPlans extends StatefulWidget {
  const MyPlans({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyPlansState();
  }
}

class MyPlansState extends State<MyPlans> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(235,233,233,1),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("Профиль"),
        ),
        body: _getPage()



    );
  }



  _getPage(){
    return Container(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          iconSize: 125,
                          icon: const Icon(
                            Icons.account_circle_outlined, size: 125, color: Colors.black,
                          ),
                          onPressed: () {}
                      ),
                    ],
                  ),
                  Text("Имя пользователя"),
                  Text("popka@gmail.com", style: TextStyle(color: Colors.black54),)
                ],
              ),
            ),
            Container( padding: const EdgeInsets.fromLTRB(0,0,0,0), child: Container(
              width: MediaQuery.of(context).size.width/1.25,
              height: 68,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Зарегистрирован:",style: TextStyle(color: Colors.black54)),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("21.12.2021")
                    ],
                  )
                ],),),),
            Container(
                height: MediaQuery.of(context).size.height /2.5,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft:Radius.circular(30),
                    topRight:Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(

                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              fixedSize: MaterialStateProperty.all(const Size.fromWidth(200)),
                              backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(0, 0, 0, 0.25)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    //side: const BorderSide(color: Colors.red)

                                  )
                              )
                          ),

                          onPressed: () {
                            setState(() {

                            });
                          },
                          child: const Text('Выйти', style: TextStyle(
                            color: Colors.black,
                          ),),
                        ),
                      ],
                    ),

                  ],
                )
            ),
          ],
        )
    );
  }
}

class MyMore extends StatefulWidget {
  const MyMore({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyMoreState();
  }
}

class MyMoreState extends State<MyMore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(235,233,233,1),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("Настройки профиля"),
        ),
        body:
        Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height - 208 ,
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft:Radius.circular(30),
                            topRight:Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(

                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      fixedSize: MaterialStateProperty.all(Size.fromWidth(MediaQuery.of(context).size.width - 20)),
                                      backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(0, 0, 0, 0.25)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            //side: const BorderSide(color: Colors.red)

                                          )
                                      )
                                  ),

                                  onPressed: () {},
                                  child: const Text('Изменить пароль', style: TextStyle(
                                    color: Colors.black,
                                  ),),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(

                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      fixedSize: MaterialStateProperty.all(Size.fromWidth(MediaQuery.of(context).size.width - 20)),
                                      backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(0, 0, 0, 0.25)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            //side: const BorderSide(color: Colors.red)

                                          )
                                      )
                                  ),

                                  onPressed: () {},
                                  child: const Text('Изменить почту', style: TextStyle(
                                    color: Colors.black,
                                  ),),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(

                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      fixedSize: MaterialStateProperty.all(Size.fromWidth(MediaQuery.of(context).size.width - 20)),
                                      backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(0, 0, 0, 0.25)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            //side: const BorderSide(color: Colors.red)

                                          )
                                      )
                                  ),

                                  onPressed: () {},
                                  child: const Text('Изменить имя пользователя', style: TextStyle(
                                    color: Colors.black,
                                  ),),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(

                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      fixedSize: MaterialStateProperty.all(Size.fromWidth(MediaQuery.of(context).size.width - 20)),
                                      backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(0, 0, 0, 0.25)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            //side: const BorderSide(color: Colors.red)

                                          )
                                      )
                                  ),

                                  onPressed: () {},
                                  child: const Text('Выйти', style: TextStyle(
                                    color: Colors.black,
                                  ),),
                                ),
                              ],
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ],
            )
        )
    );
  }
}


