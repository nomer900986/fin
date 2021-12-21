import 'package:flutter/material.dart';
import 'package:financial_analysis/home_screen.dart';



void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title of Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
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

class MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  Widget _myControl = MyControl();
  Widget _myOperations = MyOperations();
  Widget _myPlans = MyPlans();
  Widget _myMore = MyMore();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  this.getBody(),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        unselectedFontSize: 11,
        selectedFontSize: 11,
        currentIndex: this.selectedIndex,
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
          this.onTapHandler(index);
        },
      ),
    );
  }

  Widget getBody( ) {
    if (this.selectedIndex == 0) {
      return this._myControl;
    } else if (this.selectedIndex == 1) {
      return this._myOperations;
    } else if (this.selectedIndex==2){
      return this._myPlans;
    }else if(this.selectedIndex==3) {
      return this._myPlans;
    } else {
      return this._myMore;
    }
  }

  void onTapHandler(int index)  {
    this.setState(() {
      this.selectedIndex = index;
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
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return Scaffold(

                        appBar: AppBar(
                          actions: <Widget>[

                            IconButton(
                              icon: const Icon(Icons.settings),

                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute<void>(
                                  builder: (BuildContext context) {
                                    return Scaffold(
                                      appBar: AppBar(
                                      ),
                                      body: const Center(
                                        child: Text(
                                          'This is the next page',
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ),
                                    );
                                  },
                                ));
                              },
                            ),
                          ],
                        ),

                        body: const Center(
                          child: Text(
                            'This is the next page',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      );
                    },
                  )
                  );
                }
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
              Box1(),
              Box2(),
              Box3(),
              Box4(),
              Box5(),
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
        body:
        Container(
            child:
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
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
                          width: MediaQuery.of(context).size.width/2,
                          height: 68,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)
                          ),
                          child: Column(
                          children: [],),),),
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
                            children: [
                              Row(
                                children: [
                                  Text('popka')
                                ],
                              ),
                              Row(
                                children: [
                                  Text('jopka')
                                ],
                              ),
                              Row(
                                children: [
                                  Text('jopka')
                                ],
                              ),
                              Row(
                                children: [
                                  Text('jopkak')
                                ],
                              ),
                            ],
                          )
                      ),
                ],
              )
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
    return Center(child: Text("Popka"));
  }
}


