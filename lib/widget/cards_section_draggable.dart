import 'dart:math';

import 'package:flutter/material.dart';
import 'profile_card_draggable.dart';

class CardsSectionDraggable extends StatefulWidget {
  @override
  _CardsSectionState createState() => _CardsSectionState();
}

class _CardsSectionState extends State<CardsSectionDraggable> {
  bool dragOverTarget = false;
  List<ProfileCardDraggable> cards = List();
  int cardsCounter = 0;

  @override
  void initState() {
    super.initState();

    for (cardsCounter = 0; cardsCounter < 3; cardsCounter++) {
      cards.add(ProfileCardDraggable(cardsCounter));
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

      cards[2] = ProfileCardDraggable(cardsCounter);
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
            changeCardsOrder();
            setState(() => dragOverTarget = false);
          },
          onLeave: (_) => setState(() => dragOverTarget = false)),
    );
  }
}
