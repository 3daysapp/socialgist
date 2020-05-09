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
        SerializableFinder loginBtn = find.byValueKey('loginBtn');
        await driver.waitFor(loginBtn);

        await screenshot(driver, config, (_count++).toString());

        await driver.tap(loginBtn);

        SerializableFinder exploreTab = find.byValueKey('exploreTab');
        await driver.waitFor(exploreTab);

        await Future.delayed(Duration(seconds: 10));

        await screenshot(driver, config, (_count++).toString());

        SerializableFinder profileTab = find.byValueKey('profileTab');
        await driver.waitFor(profileTab);

        await driver.tap(profileTab);

        await Future.delayed(Duration(seconds: 5));

        await screenshot(driver, config, (_count++).toString());
      },
      timeout: Timeout(Duration(minutes: 2)),
    );
  });
}
