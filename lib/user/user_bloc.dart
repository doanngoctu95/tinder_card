import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tinder_cards/repo/repo.dart';

import '../model/user.dart';

class UserBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<User> _subject = BehaviorSubject<User>();

  getUser(BuildContext context) async {
    User response = await _repository.generateListUsers(context);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<User> get subject => _subject;
}

final bloc = UserBloc();
