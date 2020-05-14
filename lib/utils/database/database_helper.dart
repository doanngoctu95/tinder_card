import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:tinder_cards/model/user_favorite/user_favorite.dart';

class DatabaseHelper {

	static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
	static Database _database;                // Singleton Database

	String userTable = 'user_table';
	String colId = 'id';
	String colName = 'name';
	String colLocation = 'location';
	String colEmail = 'email';

	DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

	factory DatabaseHelper() {

		if (_databaseHelper == null) {
			_databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
		}
		return _databaseHelper;
	}

	Future<Database> get database async {

		if (_database == null) {
			_database = await initializeDatabase();
		}
		return _database;
	}

	Future<Database> initializeDatabase() async {
		// Get the directory path for both Android and iOS to store database.
		Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + 'user.db';

		// Open/create the database at a given path
		var userDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return userDatabase;
	}

	void _createDb(Database db, int newVersion) async {

		await db.execute('CREATE TABLE $userTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, '
				'$colLocation TEXT, $colEmail TEXT)');
	}

	// Fetch Operation: Get all user objects from database
	Future<List<Map<String, dynamic>>> getUserMapList() async {
		Database db = await this.database;

		var result = await db.query(userTable, orderBy: '$colName ASC');
		return result;
	}

	// Insert Operation: Insert a user object to database
	Future<int> insertUser(UserFavorite user) async {
		Database db = await this.database;
		var result = await db.insert(userTable, user.toMap());
		return result;
	}

	// Update Operation: Update a user object and save it to database
	Future<int> updateUser(UserFavorite user) async {
		var db = await this.database;
		var result = await db.update(userTable, user.toMap(), where: '$colId = ?', whereArgs: [user.id]);
		return result;
	}

  	Future<int> updateUserCompleted(UserFavorite user) async {
		var db = await this.database;
		var result = await db.update(userTable, user.toMap(), where: '$colId = ?', whereArgs: [user.id]);
		return result;
	}

	// Delete Operation: Delete a user object from database
	Future<int> deleteUser(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $userTable WHERE $colId = $id');
		return result;
	}

	// Get number of user objects in database
	Future<int> getCount() async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $userTable');
		int result = Sqflite.firstIntValue(x);
		return result;
	}

	// Get the 'Map List' [ List<Map> ] and convert it to 'user List' [ List<UserFavorite> ]
	Future<List<UserFavorite>> getUserList() async {

		var userMapList = await getUserMapList(); // Get 'Map List' from database
		int count = userMapList.length;         // Count the number of map entries in db table

		List<UserFavorite> userList = List<UserFavorite>();
		// For loop to create a 'userList' from a 'Map List'
		for (int i = 0; i < count; i++) {
			userList.add(UserFavorite.fromMapObject(userMapList[i]));
		}

		return userList;
	}

}







