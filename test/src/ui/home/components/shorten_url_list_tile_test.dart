import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nubank_test/src/domain/dto/entities/shortened_url_entity.dart';
import 'package:nubank_test/src/ui/home/components/shortened_url_list_tile.dart';

import '../../../../material_app_testing.dart';

void main() {
  late bool onTapCalled;
  late ShortenedUrlEntity tEntity;

  setUp(() {
    onTapCalled = false;

    tEntity = const ShortenedUrlEntity(
      id: 1,
      url: 'https://sh.ort/abc',
      originalUrl: 'https://verylongurl.com/example/path',
    );
  });

  Future<void> pumpListTile(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialAppTesting(
        builder: (BuildContext context) {
          return ShortenedUrlListTile(
            entity: tEntity,
            onTap: () => onTapCalled = true,
          );
        },
      ),
    );
  }

  group('ShortenedUrlListTile', () {
    testWidgets(
      'given valid entity '
      'when the widget renders '
      'then displays the shortened url, original url, and copy button',
      (tester) async {
        // Arrange
        // (Assuming you initialized tEntity with these strings in setUp)
        const tShortUrl = 'https://sh.ort/abc';
        const tOriginalUrl = 'https://verylongurl.com/example/path';

        // Override the dummy entity just for this test to ensure exact string matching
        tEntity = const ShortenedUrlEntity(
          id: 0,
          url: tShortUrl,
          originalUrl: tOriginalUrl,
        );

        // Act
        await pumpListTile(tester);

        // Then
        // Expecting the short URL text
        expect(find.text(tShortUrl), findsOneWidget);

        // Expecting the original URL text
        expect(find.text(tOriginalUrl), findsOneWidget);

        // Expecting the copy icon button
        expect(find.byIcon(Icons.copy_rounded), findsOneWidget);

        // Optional: verify the FaviconImage is in the tree
        // expect(find.byType(FaviconImage), findsOneWidget);
      },
    );

    testWidgets(
      'given rendered widget '
      'when copy button is tapped '
      'then calls onTap callback',
      (tester) async {
        // Arrange
        await pumpListTile(tester);

        // Act
        await tester.tap(find.byIcon(Icons.copy_rounded));
        await tester.pumpAndSettle();

        // Then
        expect(onTapCalled, isTrue);
      },
    );
  });
}
