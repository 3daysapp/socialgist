import 'package:flutter_driver/flutter_driver.dart';
import 'package:screenshots/screenshots.dart';
import 'package:test/test.dart';

///
///
///
void main() {
  ///
  ///
  ///
  group('end-to-end-test', () {
    FlutterDriver driver;
    final config = Config();
    int _count = 0;

    ///
    ///
    ///
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    ///
    ///
    ///
    tearDownAll(() async {
      if (driver != null) await driver.close();
    });

    ///
    ///
    ///
    test(
      '[Start test]',
      () async {
        SerializableFinder homeButton = find.byValueKey('homeButton');

        /// Login
        SerializableFinder loginBtn = find.byValueKey('loginBtn');
        await driver.waitFor(loginBtn);

        await screenshot(driver, config, (_count++).toString());

        await driver.tap(loginBtn);

        /// Explore Tab
        SerializableFinder exploreTab = find.byValueKey('exploreTab');
        await driver.waitFor(exploreTab);

        await Future.delayed(Duration(seconds: 10));

        await screenshot(driver, config, (_count++).toString());

        /// Starred Gists Tab
        SerializableFinder starredGistsTab = find.byValueKey('starredGistsTab');
        await driver.waitFor(starredGistsTab);

        await driver.tap(starredGistsTab);

        await Future.delayed(Duration(seconds: 3));

        /// Profile Tab
        SerializableFinder profileTab = find.byValueKey('profileTab');
        await driver.waitFor(profileTab);

        await driver.tap(profileTab);

        await Future.delayed(Duration(seconds: 5));

        await screenshot(driver, config, (_count++).toString());

        /// Followers
        SerializableFinder followersCard = find.byValueKey('followersCard');
        await driver.waitFor(followersCard);

        await driver.tap(followersCard);

        await Future.delayed(Duration(seconds: 5));

        /// Home
        await driver.waitFor(homeButton);

        await driver.tap(homeButton);

        // TODO - Remove
        await Future.delayed(Duration(seconds: 2));

        /// Profile
        await driver.waitFor(profileTab);

        await driver.tap(profileTab);

        // TODO - Remove
        await Future.delayed(Duration(seconds: 2));

        /// Following
        SerializableFinder followingCard = find.byValueKey('followingCard');
        await driver.waitFor(followingCard);

        await driver.tap(followingCard);

        await Future.delayed(Duration(seconds: 5));

        /// Home
        await driver.waitFor(homeButton);

        await driver.tap(homeButton);

        /// Final
        await Future.delayed(Duration(seconds: 5));
      },
      timeout: Timeout(Duration(minutes: 2)),
    );
  });
}
