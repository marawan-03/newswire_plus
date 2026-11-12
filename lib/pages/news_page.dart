import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:news_app/logic/publisher_logo.dart';
import 'package:news_app/pages/article_details_page.dart';

import '../logic/date_formating.dart';
import '../models/news_model.dart';
import '../api_services/news_service.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final _service = NewsService();
  final _scrollController = ScrollController();

  final List<News> _articles = [];
  bool _isLoading = false;
  String? _error;
  String? _cursor;

  @override
  void initState() {
    super.initState();
    _loadMore();

    _scrollController.addListener(() {
      final pos = _scrollController.position;
      if (pos.pixels >= pos.maxScrollExtent - 600) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    if (_isLoading) return;

    try {
      final result = await _service.fetchNews(cursor: null);
      if (!mounted) return;

      setState(() {
        _articles
          ..clear()
          ..addAll(result.articles);
        _cursor = result.nextCursor;
        _error = null;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Refresh failed')));
    }
  }

  Future<void> _loadMore() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final result = await _service.fetchNews(cursor: _cursor);
      if (!mounted) return;

      setState(() {
        _articles.addAll(result.articles);
        _cursor = result.nextCursor;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_articles.isEmpty && _isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_articles.isEmpty && _error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text('error:\n$_error', textAlign: TextAlign.center),
            TextButton(onPressed: _loadMore, child: const Text('Retry')),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        controller: _scrollController,

        padding: const EdgeInsets.only(bottom: 100),
        itemCount: _articles.length + 1,
        itemBuilder: (context, index) {
          if (index == _articles.length) {
            if (_isLoading) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (_error != null) {
              return Center(
                child: TextButton(
                  onPressed: _loadMore,
                  child: const Text('Error, tap to retry'),
                ),
              );
            }
            return const SizedBox.shrink();
          }

          final article = _articles[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ArticleDetailsPage(article: article),
                ),
              );
            },
            child:
                Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline
                        ),
                      ),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                PublisherLogo(
                                  publisher: PublisherFilter(article.publisher),
                                  hw: 40,
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      PublisherFilter(article.publisher),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    Text(
                                      timeAgo(article.published_at),
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              article.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    )
                    .animate(delay: index < 8 ? (index * 80).ms : 0.ms)
                    .fadeIn(delay: 40.ms)
                    .slideY(begin: 0.2, duration: 40.ms),
          );
        },
      ),
    );
  }
}
