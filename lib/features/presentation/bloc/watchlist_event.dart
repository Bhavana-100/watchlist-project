import 'package:equatable/equatable.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object?> get props => [];
}

class ChangeGroup extends WatchlistEvent {
  final String group;
  const ChangeGroup(this.group);

  @override
  List<Object?> get props => [group];
}
