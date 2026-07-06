import 'package:flutter_carplay/flutter_carplay.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CPNowPlayingButton', () {
    test('serializes repeat button', () {
      final button = CPNowPlayingRepeatButton(id: '<repeat>');

      expect(button.uniqueId, '<repeat>');
      expect(button.toJson(), {
        '_elementId': '<repeat>',
        'type': 'repeat',
      });
    });

    test('serializes shuffle button', () {
      final button = CPNowPlayingShuffleButton(id: '<shuffle>');

      expect(button.uniqueId, '<shuffle>');
      expect(button.toJson(), {
        '_elementId': '<shuffle>',
        'type': 'shuffle',
      });
    });

    test('serializes add to library button', () {
      final button = CPNowPlayingAddToLibraryButton(id: '<addToLibrary>');

      expect(button.uniqueId, '<addToLibrary>');
      expect(button.toJson(), {
        '_elementId': '<addToLibrary>',
        'type': 'addToLibrary',
      });
    });

    test('serializes more button', () {
      final button = CPNowPlayingMoreButton(id: '<more>');

      expect(button.uniqueId, '<more>');
      expect(button.toJson(), {
        '_elementId': '<more>',
        'type': 'more',
      });
    });

    test('serializes playback rate button', () {
      final button = CPNowPlayingPlaybackRateButton(id: '<playbackRate>');

      expect(button.uniqueId, '<playbackRate>');
      expect(button.toJson(), {
        '_elementId': '<playbackRate>',
        'type': 'playbackRate',
      });
    });

    test('serializes image button', () {
      final button = CPNowPlayingImageButton(
        id: '<image>',
        image: 'sfsymbol:heart',
        onPress: () {},
      );

      expect(button.uniqueId, '<image>');
      expect(button.toJson(), {
        '_elementId': '<image>',
        'type': 'image',
        'image': 'sfsymbol:heart',
      });
    });

    test('generates a unique id when none is given', () {
      final first = CPNowPlayingRepeatButton();
      final second = CPNowPlayingRepeatButton();

      expect(first.uniqueId, isNotEmpty);
      expect(first.uniqueId, isNot(second.uniqueId));
    });
  });
}
