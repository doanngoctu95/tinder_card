import 'package:flutter/material.dart';
import 'package:tinder_cards/page/list_favorite/list_favorite_page.dart';
import 'package:tinder_cards/user/user_bloc.dart';
import '../model/user.dart';
import '../widget/cards_section_draggable.dart';

class SwipeFeedPage extends StatefulWidget {
  @override
  _SwipeFeedPageState createState() => _SwipeFeedPageState();
}

class _SwipeFeedPageState extends State<SwipeFeedPage> {
  bool showAlignmentCards = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.getUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {}, icon: Icon(Icons.settings, color: Colors.grey)),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.question_answer, color: Colors.grey)),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          StreamBuilder<User>(
            stream: bloc.subject.stream,
            builder: (context, AsyncSnapshot<User> snapshot) {
              print('snapshot data: ${snapshot.data}');
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  return _buildUserWidget(snapshot.data);
                } else
                  return _buildErrorWidget();
              } else if (snapshot.hasError) {
                return _buildErrorWidget();
              } else {
                return _buildLoadingWidget();
              }
            },
          ),
          buttonsRow()
        ],
      ),
    );
  }

  Widget buttonsRow() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 48.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(right: 8.0)),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UserFavoriteListPage();
              }));
            },
            backgroundColor: Colors.white,
            child: Icon(Icons.favorite, color: Colors.green),
          ),
          Padding(padding: EdgeInsets.only(right: 8.0)),

        ],
      ),
    );
  }

  Widget _buildLoadingWidget() => Center(child: CircularProgressIndicator());

  Widget _buildErrorWidget() => Center(child: Text('Error'));

  Widget _buildUserWidget(User data) {
    return CardsSectionDraggable(user: data);
  }
}
