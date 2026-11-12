import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/logic/app_strings.dart';
import 'package:news_app/logic/auto_direction.dart';
import 'package:news_app/logic/url_launcher.dart';
import 'package:news_app/shimmers/article_detailes_shimmer.dart';

import '../logic/date_formating.dart';
import '../logic/publisher_logo.dart';

import '../api_services/article_details_service.dart';
import '../models/article_details_model.dart';
import '../models/news_model.dart';

class ArticleDetailsPage extends StatefulWidget {
  final News article;
  const ArticleDetailsPage({super.key, required this.article});

  @override
  State<ArticleDetailsPage> createState() => _ArticleDetailsPageState();
}

class _ArticleDetailsPageState extends State<ArticleDetailsPage> {
  bool _expanded = false;
  ArticleDetails? _details;
  late Future<ArticleDetails> _future;

  @override
  void initState() {
    super.initState();
    _future = NewsService().fetchDetails((widget.article.uuid));
    _future.then((d) {
      if (mounted) setState(() => _details = d);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        scrolledUnderElevation: 0,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.tertiary,
              ],
            ),
          ),
        ),
        title: SvgPicture.asset('assets/appbar_logo_white.svg', height: 23),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: ArticleDetailsShimmer());
          }
          if (snapshot.hasError) {
            return Center(child: Text('error:\n${snapshot.error}'));
          }
          final details = snapshot.data!;
          return ListView(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    height: 20,
                    child: Container(
                      color: Theme.of(context).colorScheme.tertiary,
                      height: 15,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    child: details.thumbnail == ''
                        ? Container(width: double.infinity, height: 20)
                        : Image.network(details.thumbnail),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 30,
                    child: details.thumbnail == ''
                        ? Container()
                        : DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.7),
                                ],
                              ),
                            ),
                          ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: -1,
                    height: 15,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      details.title,
                      textDirection: directionOf(details.title),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),

                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: [
                          Divider(color: Theme.of(context).colorScheme.outline),
                          Row(
                            children: [
                              PublisherLogo(
                                publisher: PublisherFilter(details.publisher),
                                hw: 40,
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    PublisherFilter(details.publisher),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary,
                                    ),
                                  ),
                                  Text(
                                    [
                                      timeAgo(details.published_at),
                                      if (details.authors.isNotEmpty)
                                        'بقلم: ${details.authors.join(' - ')}',
                                    ].join('  |  '),
                                    style: Theme.of(context).textTheme.labelMedium,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(color: Theme.of(context).colorScheme.outline),
                        ],
                      ),
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 400),
                      alignment: Alignment.topCenter,
                      child: Text(
                        _expanded ? details.body : details.incipit,
                        textDirection: directionOf(details.body),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: _details == null
          ? null
          : SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            spacing: 12,
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => setState(() => _expanded = !_expanded),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  iconAlignment: IconAlignment.end,
                  icon: Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                  label: Text(
                    AppStrings.of(context, _expanded ? 'less' : 'more'),
                  ),
                ),
              ),
              IconButton.outlined(
                onPressed: () => openUrl(_details!.original_url),
                tooltip: AppStrings.of(context, 'open source'),
                icon: const Icon(Icons.link),
                style: IconButton.styleFrom(
                  minimumSize: const Size(48, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
