import 'package:flutter_carplay/flutter_carplay.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CPListSection', () {
    test('serializes section index title', () {
      final section = CPListSection(
        id: '<section>',
        header: 'Popular',
        sectionIndexTitle: 'P',
        items: [],
      );

      expect(section.uniqueId, '<section>');
      expect(section.toJson(), {
        '_elementId': '<section>',
        'header': 'Popular',
        'items': [],
        'sectionIndexEnabled': null,
        'sectionIndexTitle': 'P',
        'runtimeType': 'FCPListSection',
      });
    });

    test('serializes a null section index title when unset', () {
      final section = CPListSection(id: '<section>', items: []);

      expect(section.toJson()['sectionIndexTitle'], isNull);
    });
  });
}
