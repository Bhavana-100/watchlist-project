import 'package:flutter/material.dart';
import 'package:watchlist_project/features/presentation/pages/watchlist_detail.dart';

class SearchPage extends StatefulWidget {
  final String name;
  final String details;
  const SearchPage({Key? key, required this.name, required this.details})
    : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _results = [];

  void _onSearch(String q) {
    final all = [
      'AAPL',
      'GOOGL',
      'AMZN',
      'MSFT',
      'TSLA',
      'BTC',
      'ETH',
      'SOL',
      'VOO',
      'QQQ',
    ];
    setState(() {
      _results =
          all.where((e) => e.toLowerCase().contains(q.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Search symbol',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _onSearch,
            ),
            const SizedBox(height: 12),
            Expanded(
              child:
                  _results.isEmpty
                      ? const Center(child: Text('No results'))
                      : ListView.builder(
                        itemCount: _results.length,
                        itemBuilder:
                            (context, idx) => ListTile(
                              title: Text(_results[idx]),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => WatchlistDetailPage(
                                          name: _results[idx],
                                          details:
                                              'Details about ${_results[idx]}',
                                        ),
                                  ),
                                );
                              },
                            ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
