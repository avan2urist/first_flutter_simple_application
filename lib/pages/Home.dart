import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> todoList = [];
  String? _userToDo;

  @override
  void initState() {
    super.initState();
    todoList.addAll(['Buy milk', 'Wash the dishes', 'Buy potatoes']);
  }

void _menuOpen() {
  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Row(
         mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Own simple menu'),
              Padding(
                padding: EdgeInsets.only(bottom: 25),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                  },
                  child: Text('Main menu'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }));
}

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The list business'),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.tablet),
            onPressed: _menuOpen,
          )
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(todoList[index]),
            child: Card(
              child: ListTile(
                title: Text(todoList[index]),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete_sweep,
                    color: Colors.deepOrangeAccent,
                  ),
                  onPressed: () {
                    setState(() {
                      todoList.removeAt(index);
                    });
                  },
                ),
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                todoList.removeAt(index);
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add the business'),
                content: TextField(
                  decoration: InputDecoration(hintText: 'Enter your task'),
                  onChanged: (String value) {
                    _userToDo = value;
                  },
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      if (_userToDo != null && _userToDo!.isNotEmpty) {
                        setState(() {
                          todoList.add(_userToDo!);
                        });
                        Navigator.of(context).pop();
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content:
                                  Text('Please enter a task before adding.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                )
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text('Add'),
                  )
                ],
              );
            },
          );
        },
        child: Icon(
          Icons.beach_access,
          color: Colors.deepOrangeAccent,
        ),
      ),
    );
  }
}
