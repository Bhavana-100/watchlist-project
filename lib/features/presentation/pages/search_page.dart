import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist_project/features/presentation/bloc/search/search_bloc.dart';
import 'package:watchlist_project/features/presentation/bloc/search/search_event.dart';
import 'package:watchlist_project/features/presentation/bloc/search/search_state.dart';
import 'package:watchlist_project/features/presentation/pages/watchlist_detail.dart';
class SearchPage extends StatelessWidget {
  final String name;
  final String details;
  const SearchPage({Key? key, required this.name, required this.details})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(),
      child: const SearchView(),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Search symbol',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (q) => context.read<SearchBloc>().add(SearchQueryChanged(q)),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchLoaded) {
                    return ListView.builder(
                      itemCount: state.results.length,
                      itemBuilder: (context, idx) => ListTile(
                        title: Text(state.results[idx]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => WatchlistDetailPage(
                                name: state.results[idx],
                                details: 'Details about ${state.results[idx]}',
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is SearchEmpty) {
                    return const Center(child: Text('No results'));
                  } else if (state is SearchError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}