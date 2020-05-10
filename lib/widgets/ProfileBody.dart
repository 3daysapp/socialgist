import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialgist/i18n.dart';
import 'package:socialgist/model/User.dart';
import 'package:socialgist/view/FollowList.dart';
import 'package:url_launcher/url_launcher.dart';

///
///
///
class ProfileBody extends StatelessWidget {
  final User user;

  // Example of a color with opacity shared in some places
  static final Color softWhite = Colors.white.withOpacity(0.5);

  ///
  ///
  ///
  const ProfileBody(
    this.user, {
    Key key,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, dynamic>> cards = {
      'Following'.i18n: {
        'key': Key('followingCard'),
        'qtd': user.following ?? 0,
        'onTap': () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FollowList(
                  title: 'Following'.i18n,
                  endpoint: 'following',
                  userName: user.login,
                ),
              ),
            )
      },
      'Followers'.i18n: {
        'key': Key('followersCard'),
        'qtd': user.followers ?? 0,
        'onTap': () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FollowList(
                  title: 'Followers'.i18n,
                  endpoint: 'followers',
                  userName: user.login,
                ),
              ),
            )
      },
      'Repositories'.i18n: {
        'key': Key('repositoriesCard'),
        'qtd': (user.publicRepos ?? 0) + (user.totalPrivateRepos ?? 0),
      },
      'Gists'.i18n: {
        'key': Key('gistsCard'),
        'qtd': (user.publicGists ?? 0) + (user.privateGists ?? 0),
      },
    };
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              /// Header Bar
              Container(
                margin: const EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 15.0),
                child: Row(
                  children: [
                    /// Company
                    hasInfo(user.company)
                        ? Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(
                                  Icons.business,
                                  color: softWhite,
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  user.company,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          )
                        : Spacer(),

                    /// Avatar
                    hasInfo(user.avatarUrl)
                        ? Expanded(
                            /// CircleAvatar as a parent with a larger size and
                            /// background color to create a border effect.
                            child: CircleAvatar(
                              backgroundColor: Theme.of(context).accentColor,
                              minRadius: 22.0,
                              maxRadius: 52.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.black54,
                                backgroundImage: NetworkImage(user.avatarUrl),
                                minRadius: 20.0,
                                maxRadius: 50.0,
                              ),
                            ),
                          )
                        : Spacer(),

                    /// Location
                    hasInfo(user.location)
                        ? Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: softWhite,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  user.location,
                                  style: Theme.of(context).textTheme.subtitle1,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        : Spacer(),
                  ],
                ),
              ),

              /// Name
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Text(
                  user.name ?? user.login,
                  style: GoogleFonts.openSans(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: softWhite,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              /// E-mail
              if (hasInfo(user.email))
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    user.email,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                ),

              /// Divider
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  '__________',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              /// Bio
              if (hasInfo(user.bio))
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                  child: Tooltip(
                    message: user.bio,
                    child: Text(
                      user.bio,
                      style: Theme.of(context).textTheme.bodyText2,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

              /// Blog
              if (hasInfo(user.blog))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        user.blog,
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      FutureBuilder<bool>(
                        future: canLaunch(user.blog),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data) {
                            return IconButton(
                              color: softWhite,
                              icon: FaIcon(FontAwesomeIcons.externalLinkAlt),
                              onPressed: () => launch(user.blog),
                            );
                          }
                          return Container(
                            width: 1,
                            height: 1,
                          );
                        },
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 20.0),
          sliver: SliverGrid.extent(
            maxCrossAxisExtent: 200.0,
            childAspectRatio: 1.2,
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 15.0,
            children: cards.keys
                .map(
                  (key) => GestureDetector(
                    key: cards[key]['key'],
                    onTap: cards[key]['onTap'],
                    child: Card(
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '${cards[key]['qtd']}',
                                  style: TextStyle(
                                    fontSize: 50.0,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                                Text(
                                  key,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          ),
                          if (cards[key]['onTap'] != null)
                            Positioned(
                              bottom: 8.0,
                              right: 8.0,
                              child: FaIcon(
                                FontAwesomeIcons.arrowRight,
                                color: softWhite,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  ///
  ///
  ///
  bool hasInfo(String info) {
    return info != null && info.isNotEmpty;
  }
}
