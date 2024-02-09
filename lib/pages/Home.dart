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
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Custom Menu', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                },
                icon: Icon(Icons.arrow_back),
                label: Text('Return to Main Menu'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ],
          ),
        ),
      );
    },
  ));
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
