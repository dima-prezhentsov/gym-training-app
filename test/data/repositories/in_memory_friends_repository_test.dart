import 'package:flutter_test/flutter_test.dart';
import 'package:gym_training_app/data/repositories/in_memory_friends_repository.dart';
import 'package:gym_training_app/domain/models/progress_overview.dart';

void main() {
  test('demo friends and history are available without backend', () async {
    final repository = InMemoryFriendsRepository(
      now: () => DateTime(2026, 9, 30),
    );
    final friends = await repository.list();
    expect(friends.where((friend) => friend.isAccepted), hasLength(1));
    expect(await repository.loadHistory('demo-anna'), isNotEmpty);
    final progress = await repository.loadProgress(
      'demo-anna',
      ProgressPeriod.allTime,
    );
    expect(progress.workoutCount, greaterThan(0));
  });

  test('share toggles do not grant access to pending requests', () async {
    final repository = InMemoryFriendsRepository();
    await expectLater(
      repository.setSharing('demo-max', stats: true, history: true),
      throwsStateError,
    );
    await repository.accept('demo-max');
    final updated = await repository.setSharing(
      'demo-max',
      stats: true,
      history: false,
    );
    expect(updated.sharesStats, isTrue);
    expect(updated.sharesHistory, isFalse);
  });
}
