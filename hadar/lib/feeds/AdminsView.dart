import 'package:flutter/material.dart';
import 'package:hadar/Design/basicTools.dart';
import 'package:hadar/profiles/profile.dart';
import 'package:hadar/services/DataBaseServices.dart';
import 'package:hadar/users/Admin.dart';
import 'package:provider/provider.dart';

import 'package:hadar/users/User.dart';

import 'feed_items/help_request_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdminsView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Admin>>.value(
      value: DataBaseService().getAllAdmins(),
      initialData: [],
      child: AllAdminsView(),
    );
  }

}

class AllAdminsView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    List<Admin> admins = Provider.of<List<Admin>>(context);
    List<FeedTile> feedTiles = [];

    if (admins != null) {
      feedTiles = admins.map((Admin user) {

        return FeedTile(tileWidget: UserItem(
          user: user, parent: this,
        ),);

      }).toList();
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
        semanticChildCount: (admins == null) ? 0 : admins.length,
        padding: const EdgeInsets.only(bottom: 70.0, top: 40),
        children: feedTiles,
      ),
    );

  }
}


class UserItem extends StatelessWidget {
  UserItem({required this.user, required this.parent})
      : super(key: ObjectKey(user));

  final User user;
  final AllAdminsView parent;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap:(){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfilePage(user)
          ),
        );
      },
      isThreeLine: true,
      title: Row(children: <Widget>[
        Container(
          child: Text(AppLocalizations.of(context)!.nameTwoDots + user.name,
              style: TextStyle(color: BasicColor.clr)),
        ),
        Spacer(),
        Container(
          child: Text(user.email),
          alignment: Alignment.topLeft,
        ),
      ]),
      subtitle: Row(
        children: <Widget>[
          Container(
            child: Text(AppLocalizations.of(context)!.telNumberTwoDots + user.phoneNumber),
            padding: const EdgeInsets.only(top: 8, left: 8),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

