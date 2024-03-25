import 'package:firebase_database/firebase_database.dart';

class UserMethods {
  late DatabaseReference _database;

  // To be called before writeNewUser
  void initializeDatabase() {
    _database = FirebaseDatabase.instance.ref();
  }

  void writeNewUser(String userId, String name, String email) {
    final user = {'username': name, 'email': email};

    _database.child('users').child(userId).set(user);
  }
}
