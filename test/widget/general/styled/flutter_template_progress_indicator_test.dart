import 'package:flutter_template/common/widgets/styled/flutter_template_progress_indicator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../di/test_kiwi_util.dart';
import '../../../util/test_util.dart';

void main() {
  setUp(() async {
    await TestKiwiUtil.init();
  });

  testWidgets('FlutterTemplateProgressIndicator initial state', (tester) async {
    const sut = FlutterTemplateProgressIndicator.light();

    await TestUtil.loadWidgetWithText(tester, sut);
    await TestUtil.takeScreenshot(tester, 'flutter_template_progress_indicator_light');
  });

  testWidgets('FlutterTemplateProgressIndicator initial state dark', (tester) async {
    const sut = FlutterTemplateProgressIndicator.dark();

    await TestUtil.loadWidgetWithText(tester, sut);
    await TestUtil.takeScreenshot(tester, 'flutter_template_progress_indicator_dark');
  });
}
