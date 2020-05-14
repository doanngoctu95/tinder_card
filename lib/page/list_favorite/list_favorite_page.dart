import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tinder_cards/model/user_favorite/user_favorite.dart';
import 'package:tinder_cards/utils/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class UserFavoriteListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserFavoriteListPageState();
  }
}

class UserFavoriteListPageState extends State<UserFavoriteListPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<UserFavorite> userFavoriteList;
  int count = 0;

  
  @override
  Widget build(BuildContext context) {
    if (userFavoriteList == null) {
      userFavoriteList = List<UserFavorite>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('List User favorited'),
      ),
      body: getUserListView(),
    );
  }

  ListView getUserListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text(getFirstLetter(this.userFavoriteList[position].name),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.userFavoriteList[position].name + this.userFavoriteList[position].id.toString(),
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(this.userFavoriteList[position].location),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(Icons.delete,color: Colors.red,),
                  onTap: () {
                    _delete(context, userFavoriteList[position]);
                  },
                ),
              ],
            ),
            onTap: () {
              print("ListTile Tapped");
            },
          ),
        );
      },
    );
  }

  getFirstLetter(String title) {
    return title.substring(0, 2);
  }

  void _delete(BuildContext context, UserFavorite user) async {
    int result = await databaseHelper.deleteUser(user.id);
    if (result != 0) {
      _showSnackBar(context, 'User Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }
  

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<UserFavorite>> userListFuture = databaseHelper.getUserList();
      userListFuture.then((userList) {
        setState(() {
          this.userFavoriteList = userList;
          this.count = userList.length;
        });
      });
    });
  }
  
}
