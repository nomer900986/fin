import 'package:flutter/material.dart';
List todoList = [];
List sum_List = [];
class card extends StatefulWidget{
  //const card ({required Key key}): super (key: key);
  @override
  _cardList createState() => _cardList();
}
class _cardList extends State<card>{

  @override
  void initState() {
    super.initState();
    todoList.addAll([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,

       body: ListView.builder(
          itemCount: todoList.length,
            itemBuilder: (BuildContext context, int index){
            return Dismissible(
                key: Key(todoList[index]),
                child: Card(
                  color: Colors.white38,
                  child: ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Text(todoList[index]+'\n'+'Баланс: '+sum_List[index]+' ₽'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_sweep),
                      color: Colors.red[900], onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Подтверждение удаления'),
                          content: const Text('Вы действительно хотите удалить данную карту?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Нет'),
                              child: const Text(
                                  'Нет',
                                style: TextStyle(
                                  color: Colors.red,
                                ) ,
                              ),
                            ),
                            TextButton(
                              onPressed: () =>{
                                Navigator.pop(context, 'Да'),
                                setState(() {
                                todoList.removeAt(index);
                                sum_List.removeAt(index);
                                }),
                            },
                              child: const Text('Да',
                              style: TextStyle(
                                color: Colors.green,
                              ),),
                            ),
                          ],
                        ),
                      );


                    },
                    ),
                    //subtitle: Text(),
                  )

                ),
              onDismissed: (direction){
                  setState(() {
                    todoList.removeAt(index);
                    sum_List.removeAt(index);
                  });
              },
            );
            }
        ),
    );

  }

}