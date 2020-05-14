import 'package:flutter/material.dart';
import 'package:tinder_cards/model/location.dart';
import 'package:tinder_cards/model/name.dart';
import 'package:tinder_cards/model/picture.dart';
import 'package:tinder_cards/model/results.dart';
import 'package:tinder_cards/utils/utils.dart';

import '../model/user.dart';
import 'components/avatar.dart';

const double _sizeItemBottom = 30.0;
const double _sizeAvatar = 75.0;
const double _widthTab = 250.0;
const double _widthTabView = 200.0;
const double _heightTabView = 60.0;

typedef OnItemBottomClick();

// ignore: must_be_immutable
class ItemCard extends StatefulWidget {
  final int cardNumb;

  ItemCard({Key key, this.cardNumb}) : super(key: key);

  User user = User(results: [
    Results(
        email: 'abc@gmail.com',
        location: Location(city: 'HN', state: 'VN', street: 'HQV'),
        name: Name(
          first: 'Ngoc',
          last: 'Nguyen',
        ),
        picture: Picture(thumbnail: 'https://randomuser.me/api/portraits/thumb/women/90.jpg'))
  ]);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  String content;

  TabController _tabController;

  List<Widget> listTabBarViews = [];

  @override
  void initState() {
    super.initState();
    listTabBarViews = [
      Container(
          alignment: Alignment.center,
          child: Text(
            '${widget.user.results[0].name.last}, ${widget.cardNumb}',
            style: TextStyle(color: Colors.blue),
          )),
      Container(
          alignment: Alignment.center,
          child: Text(
            '${widget.user.results[0].location.state}, ${widget.user.results[0].location.city}, ${widget.user.results[0].location.street}',
            style: TextStyle(color: Colors.blue),
          )),
      Container(
          alignment: Alignment.center,
          child: Text(
            '${widget.user.results[0].email}',
            style: TextStyle(color: Colors.blue),
          )),
    ];
    _tabController = TabController(vsync: this, length: listTabBarViews.length);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: _content(),
          ),
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: const Divider(
              height: 1,
              color: Colors.grey,
            ),
          ),
          Positioned(
            child: AvatarRadius(
              url: widget.user.results[0].picture?.thumbnail,
              width: _sizeAvatar,
              height: _sizeAvatar,
            ),
          )
        ],
      ),
    );
  }

  _content() => Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: mPadding,
            ),
            SizedBox(
              height: mPadding,
            ),
            Text(
              '${widget.user.results[0].name.first}, ${widget.cardNumb}',
            ),
            SizedBox(
              height: mPadding,
            ),
            Container(
              width: _widthTabView,
              height: _heightTabView,
              child: TabBarView(
                controller: _tabController,
                children: listTabBarViews,
              ),
            ),
            SizedBox(
              height: mPadding,
            ),
            _tabBar(),
          ],
        ),
      );

  _tabBar() {
    return Container(
      width: _widthTab,
      child: Column(
        children: <Widget>[
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.blue,
            labelColor: Colors.white,
            labelPadding: const EdgeInsets.all(0),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.all(0),
            indicatorWeight: 1,
            isScrollable: false,
            unselectedLabelColor: Colors.red,
            indicator: ShapeDecoration(
              shape: Border(
                bottom: BorderSide(
                  color: Colors.green,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            tabs: <Widget>[
              Tab(
                icon: Image.asset(
                  'assets/images/social.png',
                  width: _sizeItemBottom,
                  height: _sizeItemBottom,
                  fit: BoxFit.cover,
                ),
              ),
              Tab(
                icon: Image.asset(
                  'assets/images/location.png',
                  width: _sizeItemBottom,
                  height: _sizeItemBottom,
                  fit: BoxFit.cover,
                ),
              ),
              Tab(
                icon: Image.asset(
                  'assets/images/mail.png',
                  width: _sizeItemBottom,
                  height: _sizeItemBottom,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
