import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tinder_cards/model/user_favorite/user_favorite.dart';
import 'package:tinder_cards/utils/database/database_helper.dart';
import '../model/user.dart';
import 'profile_card_draggable.dart';

class CardsSectionDraggable extends StatefulWidget {
  final User user;

  const CardsSectionDraggable({Key key, this.user}) : super(key: key);

  @override
  _CardsSectionState createState() => _CardsSectionState();
}

class _CardsSectionState extends State<CardsSectionDraggable> {
  bool dragOverTarget = false;

  // list card, and card[0] is card invisible currently.
  List<ProfileCardDraggable> cards = List();
  int cardsCounter = 0;

  DatabaseHelper helper = DatabaseHelper();

  @override
  void initState() {
    super.initState();

//    helper.initializeDatabase();

    for (cardsCounter = 0; cardsCounter < 3; cardsCounter++) {
      cards.add(ProfileCardDraggable(cardNum: cardsCounter, user: widget.user));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(
      children: <Widget>[
        // Drag target row
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            dragTarget(isLeft: true),
            Flexible(flex: 3, child: Container()),
            dragTarget(isLeft: false)
          ],
        ),
        // Back card
        Align(
          alignment: Alignment(0.0, 1.0),
          child: IgnorePointer(
              child: SizedBox.fromSize(
            size: Size(MediaQuery.of(context).size.width * 0.8,
                MediaQuery.of(context).size.height * 0.5),
            child: cards[2],
          )),
        ),
        // Middle card
        Align(
          alignment: Alignment(0.0, 0.8),
          child: IgnorePointer(
              child: SizedBox.fromSize(
            size: Size(MediaQuery.of(context).size.width * 0.85,
                MediaQuery.of(context).size.height * 0.55),
            child: cards[1],
          )),
        ),
        // Front card
        Align(
          alignment: Alignment(0.0, 0.0),
          child: Draggable(
            feedback: SizedBox.fromSize(
              size: Size(MediaQuery.of(context).size.width * 0.9,
                  MediaQuery.of(context).size.height * 0.6),
              child: cards[0],
            ),
            child: SizedBox.fromSize(
              size: Size(MediaQuery.of(context).size.width * 0.9,
                  MediaQuery.of(context).size.height * 0.6),
              child: cards[0],
            ),
            childWhenDragging: Container(),
          ),
        ),
      ],
    ));
  }

  void changeCardsOrder() {
    setState(() {
      // Swap cards
      var temp = cards[0];
      cards[0] = cards[1];
      cards[1] = cards[2];
      cards[2] = temp;
      cards[2] = ProfileCardDraggable(cardNum: cardsCounter, user: widget.user);
      cardsCounter = Random().nextInt(9999);
    });
  }

  Widget dragTarget({bool isLeft}) {
    return Flexible(
      flex: 2,
      child: DragTarget(
          builder: (_, __, ___) {
            return Container();
          },
          onWillAccept: (_) {
            setState(() => dragOverTarget = true);
            return true;
          },
          onAccept: (_) {
            print('target is: $isLeft');
            print('card is dragged is: ${cards[0].cardNum}');
            changeCardsOrder();
            if(!isLeft) {
              _save();
            }
            setState(() => dragOverTarget = false);
          },
          onLeave: (_) => setState(() => dragOverTarget = false)),
    );
  }

  // Save data to database
  void _save() async {
    int result;
    if (cards[0].cardNum != null && widget.user != null) {
      // insert
      UserFavorite userFavorite = UserFavorite.withId(
          cards[0].cardNum,
          widget.user.results[0].name.first,
          widget.user.results[0].location.city,
          widget.user.results[0].email);
      result = await helper.insertUser(userFavorite);
    } else {
      // update
    }

    if (result != 0) {
      // Success
      print('User Saved Successfully');
    } else {
      // Failure
      print('Problem Saving User');
    }
  }
}
