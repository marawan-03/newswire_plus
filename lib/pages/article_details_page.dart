import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/logic/app_strings.dart';
import 'package:news_app/logic/auto_direction.dart';
import 'package:news_app/logic/url_launcher.dart';

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
  late Future<ArticleDetails> _future;

  @override
  void initState() {
    super.initState();
    _future = NewsService().fetchDetails((widget.article.uuid));
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
            return const Center(child: CircularProgressIndicator());
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
                    SizedBox(),
                    if (_expanded)
                      GestureDetector(
                        onTap: () => openUrl(details.original_url),
                        child: Text(
                          maxLines: 2,
                          details.original_url,
                          textDirection: directionOf(details.original_url),
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                    Center(
                      child: FilledButton.icon(
                        onPressed: () => setState(() => _expanded = !_expanded),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),

                        iconAlignment: IconAlignment.end,
                        icon: Icon(
                          _expanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 20,
                        ),
                        label: Text(
                          AppStrings.of(context, _expanded ? 'less' : 'more'),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
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
    );
  }
}
