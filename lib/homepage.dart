import 'package:flutter/material.dart';
import 'package:userapp/utils/databasehelper.dart';
import 'users.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String user1fname,
      user1lname,
      user1email,
      user2fname,
      user2lname,
      user2email,
      user3fname,
      user3lname,
      user3email,
      user4fname,
      user4lname,
      user4email,
      user5fname,
      user5lname,
      user5email,
      user6fname,
      user6lname,
      user6email;

  void getData() async {
    http.Response response =
        await http.get('https://reqres.in/api/users?page=1');
    if (response.statusCode == 200) {
      String dataa = response.body;
      user1fname = jsonDecode(dataa)['data'][0]['first_name'];
      user1lname = jsonDecode(dataa)['data'][0]['last_name'];
      user1email = jsonDecode(dataa)['data'][0]['email'];
      user2fname = jsonDecode(dataa)['data'][1]['first_name'];
      user2lname = jsonDecode(dataa)['data'][1]['last_name'];
      user2email = jsonDecode(dataa)['data'][1]['email'];
      user3fname = jsonDecode(dataa)['data'][2]['first_name'];
      user3lname = jsonDecode(dataa)['data'][2]['last_name'];
      user3email = jsonDecode(dataa)['data'][2]['email'];
      user4fname = jsonDecode(dataa)['data'][3]['first_name'];
      user4lname = jsonDecode(dataa)['data'][3]['last_name'];
      user4email = jsonDecode(dataa)['data'][3]['email'];
      user5fname = jsonDecode(dataa)['data'][4]['first_name'];
      user5lname = jsonDecode(dataa)['data'][4]['last_name'];
      user5email = jsonDecode(dataa)['data'][4]['email'];
      user6fname = jsonDecode(dataa)['data'][5]['first_name'];
      user6lname = jsonDecode(dataa)['data'][5]['last_name'];
      user6email = jsonDecode(dataa)['data'][5]['email'];

      setState(() {
        users.add(Users('$user1fname $user1lname', '$user1email'));
        users.add(Users('$user2fname $user2lname', '$user2email'));
        users.add(Users('$user3fname $user3lname', '$user3email'));
        users.add(Users('$user4fname $user4lname', '$user4email'));
        users.add(Users('$user5fname $user5lname', '$user5email'));
        users.add(Users('$user6fname $user6lname', '$user6email'));
      });
    }
  }

  DatabaseHelper databasehelper = DatabaseHelper();

  final List<Users> users = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User App'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Color(0xff2da9ef),
                  gradient: LinearGradient(
                    colors: [Color(0xff8d70fe), Color(0xff2da9ef)],
                    begin: Alignment.centerRight,
                    end: Alignment(-1.0, -1.0),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20.0,
              left: 18.0,
              child: Container(
                color: Colors.white,
                width: 380.0,
                height: MediaQuery.of(context).size.height / 1.3,
                child: ListView.builder(
                  itemBuilder: (context, position) {
                    return Dismissible(
                      key: Key(users[position].toString()),
                      child: _myListContainer(
                        users[position].name,
                        users[position].email,
                      ),
                      background: _myHiddenContainer(),
                      onDismissed: (direction) {
                        if (direction == (DismissDirection.startToEnd)) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Delete'),
                            ),
                          );
                        }
                        if (users.contains(users.removeAt(position))) {
                          setState(() {
                            users.remove(users.removeAt(position));
                          });
                        } else if (direction == DismissDirection.endToStart) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Delete'),
                            ),
                          );
                        }
                        if (users.contains(users.removeAt(position))) {
                          setState(() {
                            users.remove(users.removeAt(position));
                          });
                        }
                      },
                    );
                  },
                  itemCount: users.length,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff2da9ef),
        foregroundColor: Color(0xffffffff),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                final taskvalue = TextEditingController();
                final subvalue = TextEditingController();
                final time = TextEditingController();
                Color taskcolor;
                return AlertDialog(
                  title: Text('Add New User'),
                  content: Container(
                    height: 250.0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextField(
                            controller: taskvalue,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'First Name',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: TextField(
                            controller: subvalue,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Last Name',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: TextField(
                            controller: time,
                            obscureText: false,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Color(0xff2da9ef),
                      child: Text(
                        'Add User',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          // databasehelper.insertUser(users);
                          users.add(
                            Users(
                              taskvalue.text,
                              subvalue.text,
                            ),
                          );
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        },
        tooltip: 'Add User',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color(0xff2da9ef),
        shape: CircularNotchedRectangle(),
        child: Icon(Icons.menu),
      ),
    );
  }

  Widget _myListContainer(
    String name,
    String email,
  ) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        height: 80.0,
        child: Material(
          color: Colors.white,
          elevation: 14.0,
          shadowColor: Color(0x802196f3),
          child: Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: Text(
                              name,
                              style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: Text(
                              email,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _myHiddenContainer() {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Color(0xff8d70fe),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(Icons.delete),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  //TODO: implement remove
                });
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.delete),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  //TODO: implement remove
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
