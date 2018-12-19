import 'package:database_intro_android/Models/user.dart';
import 'package:database_intro_android/Utils/database_helper.dart';
import 'package:flutter/material.dart';
//import 'package:sqflite/sqflite.dart';

List _users;

void main() async {
  var db = DatabaseHelper();

  //Add user
  //int saveduser =
 /* await db.saveUser(User("William", "Mart"));
  await db.saveUser(User("Beatriz", "bia"));
  await db.saveUser(User("Filipe", "fips")); */

  //int count = await db.getCount();
  //print("Count $count");

  //retrieving a user
/*   User returnUser = await db.getUser(1);
  print("ID ${returnUser.id}");
  print("Nome ${returnUser.username}");
  print("Pass ${returnUser.password}");
  print("================"); */

/*   User userUpdated = User.fromMap({
    "username" : "nome1",
    "password" : "pass1",
    "id" : 1
  }); */

  // Update
  //await db.updateUser(userUpdated);

  //delete a user
/*    int userDeleted = await db.deleteUser(0);
  print("Delete user $userDeleted");  */

  _users = await db.getAllUsers();

  for (int i = 0; i < _users.length; i++) {
    User user = User.map(_users[i]);
    print("${user.id} ${user.username}");
    //Erase record inner loop
    //int userDel = await db.deleteUser(user.id);
    //print("User deleted $userDel");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyApp',
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acesss SQLite'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (_, int position) {
          return Card(
            color: Colors.white,
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.blueAccent,
                child: Text("${User.fromMap(_users[position]).username.substring(0,1)}",style: TextStyle(fontSize: 28),),
              ),
              title: Text("ID: ${User.fromMap(_users[position]).id}"),
              subtitle:
                  Text("User: ${User.fromMap(_users[position]).username}"),
              onTap: () => print("${User.fromMap(_users[position]).password}"),
            ),
          );
        },
      ),
    );
  }
}
