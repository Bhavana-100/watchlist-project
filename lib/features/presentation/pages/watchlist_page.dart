import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocBuilder, BlocProvider, ReadContext;
import 'package:watchlist_project/core/utils/constants.dart';
import 'package:watchlist_project/features/data/datasource/mock_watchlist_data.dart';
import 'package:watchlist_project/features/domain/usecase/new_watchlist.dart';
import 'package:watchlist_project/features/presentation/bloc/watchlist_bloc.dart';
import 'package:watchlist_project/features/presentation/bloc/watchlist_event.dart';
import 'package:watchlist_project/features/presentation/bloc/watchlist_state.dart';
import 'package:watchlist_project/features/presentation/pages/search_page.dart';
import 'package:watchlist_project/features/presentation/pages/watchlist_detail.dart';
import 'package:watchlist_project/features/repository_impl/watchlist_repository.impl.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataSource = MockWatchlistDataSource();
    final repo = WatchlistRepositoryImpl(dataSource: dataSource);
    final usecase = GetWatchlist(repo);

    return BlocProvider(
      create: (_) => WatchlistBloc(getWatchlist: usecase),
      child: const WatchlistView(),
    );
  }
}

class WatchlistView extends StatefulWidget {
  const WatchlistView({Key? key}) : super(key: key);

  @override
  State<WatchlistView> createState() => _WatchlistViewState();
}

class _WatchlistViewState extends State<WatchlistView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: Constants.groups.length,
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WatchlistBloc>().add(ChangeGroup(Constants.groups[0]));
    });

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      final group = Constants.groups[_tabController.index];
      context.read<WatchlistBloc>().add(ChangeGroup(group));
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.teal,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.teal,
          tabs: Constants.groups.map((g) => Tab(text: g)).toList(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SearchPage(name: '', details: ''),
                    ),
                  ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      'Search and Add Scripts',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<WatchlistBloc, WatchlistState>(
              builder: (context, state) {
                if (state is WatchlistLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is WatchlistLoaded) {
                  if (state.symbols.isEmpty) {
                    return const Center(
                      child: Text(
                        'No symbols available',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }
                  return ListView.separated(
                    itemCount: state.symbols.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final s = state.symbols[index].symbol;
                      final price = (100 + index * 25).toDouble();
                      return ListTile(
                        title: Text(
                          s,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          'NSE · ${price.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Colors.grey.shade400,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => WatchlistDetailPage(
                                    name: s,
                                    details: 'Price of $s: $price',
                                  ),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (state is WatchlistError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
