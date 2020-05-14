import 'package:flutter/material.dart';
import 'package:tinder_cards/widget/item_card.dart';
import '../model/user.dart';

class ProfileCardDraggable extends StatelessWidget {
  final int cardNum;
  final User user;

  ProfileCardDraggable({this.cardNum, this.user});

  @override
  Widget build(BuildContext context) {
    return ItemCard(
      cardNumb: cardNum,
      user: user,
    );
  }
}
