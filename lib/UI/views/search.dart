import 'package:algolia/algolia.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:teukoo/UI/shared/bottom_nav_bar.dart';
import 'package:teukoo/UI/widgets/my_widgets/colors.dart';
import 'package:teukoo/constants/route_names.dart';
import 'package:teukoo/models/user.dart';
import 'package:teukoo/service_locator.dart';
import 'package:teukoo/services/algolia_service.dart';
import 'package:teukoo/services/navigation_service.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.primaryBackground,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SearchBar(
            loader: Center(child: CircularProgressIndicator(
              strokeWidth: 5,
                valueColor: AlwaysStoppedAnimation(
                  MyColor.nextCamera,
                ),
            ),), 
            cancellationWidget: Text(
              'Cancel',
              style: TextStyle(color: Color(0xFFFFFFFF)),
            ),
            hintText: "Search ",
            hintStyle: TextStyle(
              color: Color(0xFFFFFFFF),
            ),
            icon: Icon(Icons.search, color: Color(0xFFFFFFFF)),
            iconActiveColor: Color(0xFFFFFFFF),
            textStyle: TextStyle(
              color: Color(0xFFFFFFFF),
            ),
            searchBarStyle: SearchBarStyle(
              backgroundColor: Color(0xFF313947),
              padding: EdgeInsets.all(10),
              borderRadius: BorderRadius.circular(60),
            ),
            onSearch: search,
            onItemFound: (UserSearch usersearch, int index) {
              return ListView(shrinkWrap: true, children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: (usersearch.profileUrl == "null") ? AssetImage('assets/logoImage.png') : NetworkImage(usersearch.profileUrl) ,
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(
                    usersearch.username,
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 20),
                  ),
                  subtitle: Text(usersearch.surname,
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13)),
                  onTap: () {
                    _navigationService.navigateTo(ProfileRoute,
                        arguments: usersearch.id);
                  },
                ),
                Divider(
                  color: Color(0xFFFFFFFF),
                ),
              ]);
            },
          ),
        ),
        bottomNavigationBar: AppBottomNav(),
      ),
    );
  }

  Future<List<UserSearch>> search(String search) async {
    List<AlgoliaObjectSnapshot> _results = [];
    AlgoliaQuery query = AlgoliaService.algolia.instance.index("Users");
    query = query.search(search);
    _results = (await query.getObjects()).hits;
    return List.generate(_results.length, (int index) {
      AlgoliaObjectSnapshot snap = _results[index];
      return UserSearch(
        "${snap.data['id']}",
        "${snap.data['profileUrl']}",
        "${snap.data['username']}",
        "${snap.data['surname']}",
      );
    });
  }
}
