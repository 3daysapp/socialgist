import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:socialgist/i18n.dart';
import 'package:socialgist/model/User.dart';
import 'package:socialgist/provider/AuthUserProvider.dart';
import 'package:socialgist/provider/UserFollowersProvider.dart';
import 'package:socialgist/provider/UserFollowingProvider.dart';
import 'package:socialgist/provider/UserGistProvider.dart';
import 'package:socialgist/util/Config.dart';
import 'package:socialgist/util/ProfileHeroImage.dart';
import 'package:socialgist/view/FollowList.dart';
import 'package:socialgist/view/UserGist.dart';
import 'package:url_launcher/url_launcher.dart';

///
///
///
class ProfileBody extends StatefulWidget {
  final User user;

  ///
  ///
  ///
  const ProfileBody(
    this.user, {
    Key key,
  }) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

///
///
///
class _ProfileBodyState extends State<ProfileBody> {
  final Color softWhite = Colors.white.withOpacity(0.5);
  bool amIFollowing = true;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    _followRefresh();
  }

  ///
  ///
  ///
  void _followRefresh() async {
    bool following = await AuthUserProvider(
      context: context,
    ).amIFollowing(widget.user);
    if (mounted) setState(() => amIFollowing = following);
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, dynamic>> cards = {
      'Following'.i18n: {
        'key': Key('followingCard'),
        'qtd': widget.user.following ?? 0,
        'onTap': () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FollowList(
                  title: 'Following'.i18n,
                  provider: UserFollowingProvider(
                    context: context,
                    user: widget.user,
                  ),
                ),
              ),
            ),
      },
      'Followers'.i18n: {
        'key': Key('followersCard'),
        'qtd': widget.user.followers ?? 0,
        'onTap': () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FollowList(
                  title: 'Followers'.i18n,
                  provider: UserFollowersProvider(
                    context: context,
                    user: widget.user,
                  ),
                ),
              ),
            ),
      },
      'Repositories'.i18n: {
        'key': Key('repositoriesCard'),
        'qtd': (widget.user.publicRepos ?? 0) +
            (widget.user.totalPrivateRepos ?? 0),
      },
      'Gists'.i18n: {
        'key': Key('gistsCard'),
        'qtd': (widget.user.publicGists ?? 0) + (widget.user.privateGists ?? 0),
        'onTap': () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UserGist(
                  provider: UserGistProvider(
                    context: context,
                    user: widget.user,
                  ),
                ),
              ),
            ),
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
                    hasInfo(widget.user.company)
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
                                  widget.user.company,
                                  style: Theme.of(context).textTheme.subtitle1,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        : Spacer(),

                    /// Avatar
                    hasInfo(widget.user.avatarUrl)
                        ? Expanded(
                            /// CircleAvatar as a parent with a larger size and
                            /// background color to create a border effect.
                            child: GestureDetector(
                              onTap: () {
                                ProfileHeroImage.show(
                                  context: context,
                                  tag: 'profilePhoto',
                                  image: NetworkImage(widget.user.avatarUrl),
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).accentColor,
                                minRadius: 22.0,
                                maxRadius: 52.0,
                                child: Hero(
                                  tag: 'profilePhoto',
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    backgroundImage:
                                        NetworkImage(widget.user.avatarUrl),
                                    minRadius: 20.0,
                                    maxRadius: 50.0,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Spacer(),

                    /// Location
                    hasInfo(widget.user.location)
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
                                  widget.user.location,
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
                padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 2.0),
                child: Text(
                  widget.user.name ?? widget.user.login,
                  style: GoogleFonts.openSans(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: softWhite,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              /// E-mail
              if (hasInfo(widget.user.email))
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    widget.user.email,
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
              if (hasInfo(widget.user.bio))
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                  child: Tooltip(
                    message: widget.user.bio,
                    child: Text(
                      widget.user.bio,
                      style: Theme.of(context).textTheme.bodyText2,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

              /// Blog
              if (hasInfo(widget.user.blog))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Text(
                          widget.user.blog,
                          style: Theme.of(context).textTheme.subtitle1,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      FutureBuilder<bool>(
                        future: canLaunch(widget.user.blog),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data) {
                            return IconButton(
                              color: softWhite,
                              icon: FaIcon(FontAwesomeIcons.externalLinkAlt),
                              onPressed: () => launch(widget.user.blog),
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

              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (widget.user.login != Config().me.login)
                      amIFollowing
                          ? FlatButton.icon(
                              icon: FaIcon(
                                FontAwesomeIcons.userMinus,
                                color: softWhite,
                              ),
                              label: Text('Following'.i18n),
                              onPressed: () async {
                                await AuthUserProvider(
                                  context: context,
                                ).unfollow(widget.user);
                                _followRefresh();
                              },
                            )
                          : FlatButton.icon(
                              icon: FaIcon(
                                FontAwesomeIcons.userPlus,
                                color: softWhite,
                              ),
                              label: Text('Follow'.i18n),
                              onPressed: () async {
                                await AuthUserProvider(
                                  context: context,
                                ).follow(widget.user);
                                _followRefresh();
                              },
                            ),
                    FlatButton.icon(
                      onPressed: () => Share.share(
                        widget.user.htmlUrl,
                        subject: 'Shared from SocialGist'.i18n,
                      ),
                      icon: FaIcon(
                        FontAwesomeIcons.shareAlt,
                        color: softWhite,
                      ),
                      label: Text('Share'.i18n),
                    ),
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
