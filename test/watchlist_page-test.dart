import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:watchlist_project/features/presentation/bloc/watchlist_bloc.dart';
import 'package:watchlist_project/features/presentation/bloc/watchlist_event.dart';
import 'package:watchlist_project/features/presentation/bloc/watchlist_state.dart';
import 'package:watchlist_project/features/presentation/pages/watchlist_page.dart';
import 'package:watchlist_project/features/domain/entity/symbol_entity.dart';

class MockWatchlistBloc extends MockBloc<WatchlistEvent, WatchlistState>
    implements WatchlistBloc {}

class FakeWatchlistEvent extends Fake implements WatchlistEvent {}
class FakeWatchlistState extends Fake implements WatchlistState {}

void main() {
  late MockWatchlistBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(FakeWatchlistEvent());
    registerFallbackValue(FakeWatchlistState());
  });

  setUp(() {
    mockBloc = MockWatchlistBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<WatchlistBloc>.value(
        value: mockBloc,
        child: const WatchlistView(),
      ),
    );
  }

  testWidgets('renders app bar title', (tester) async {
    when(() => mockBloc.state).thenReturn(WatchlistLoading());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Watchlist'), findsOneWidget);
  });

  testWidgets('shows loading indicator when state is loading', (tester) async {
    when(() => mockBloc.state).thenReturn(WatchlistLoading());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows list of symbols when loaded', (tester) async {
    when(() => mockBloc.state).thenReturn(
      WatchlistLoaded([
        SymbolEntity(symbol: 'AAPL'),
        SymbolEntity(symbol: 'GOOGL'),
      ]),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('AAPL'), findsOneWidget);
    expect(find.text('GOOGL'), findsOneWidget);
  });

  testWidgets('shows empty state message when no symbols', (tester) async {
    when(() => mockBloc.state).thenReturn(WatchlistLoaded([]));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('No symbols available'), findsOneWidget);
  });

  testWidgets('shows error message when error occurs', (tester) async {
    when(() => mockBloc.state).thenReturn(WatchlistError('Something went wrong'));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Something went wrong'), findsOneWidget);
  });
}
