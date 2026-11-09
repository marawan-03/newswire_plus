import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/pages/news_page.dart';
import 'package:news_app/pages/search_page.dart';
import 'package:news_app/pages/settings_page.dart';

import 'logic/app_strings.dart';

class AppCore extends StatefulWidget {
  const AppCore({super.key});

  @override
  State<AppCore> createState() => _AppCoreState();
}

class _AppCoreState extends State<AppCore> {
  int _index = 0;
  bool _showBar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.surface,

      //Appbar
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        centerTitle: true,
        title: SvgPicture.asset(
          Theme.of(context).brightness == Brightness.light
              ? 'assets/light_mode_appbar_logo.svg'
              : 'assets/dark_mode_appbar_logo.svg',
          height: 23,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),

      //body of the app
      body: NotificationListener<UserScrollNotification>(
        onNotification: (n) {
          if (n.direction == ScrollDirection.reverse && _showBar) {
            setState(() => _showBar = false);
          } else if (n.direction == ScrollDirection.forward && !_showBar) {
            setState(() => _showBar = true);
          }
          return false;
        },
        child: IndexedStack(
          index: _index,
          children: [
            NewsPage(),
            SearchPage(),
            SettingsPage()],
        ),
      ),

      //Navbar
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: AnimatedSlide(
          offset: _showBar ? Offset.zero : Offset(0, 1),
          duration: const Duration(milliseconds: 300),
          child: NavigationBar(
            animationDuration: const Duration(milliseconds: 600),
            selectedIndex: _index,
            onDestinationSelected: (i) => setState(() => _index = i),
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.newspaper_outlined),
                selectedIcon: const Icon(Icons.newspaper),
                label: AppStrings.of(context, 'news'),
              ),
              NavigationDestination(
                icon: const Icon(Icons.search),
                selectedIcon: const Icon(Icons.search),
                label: AppStrings.of(context, 'search'),
              ),
              NavigationDestination(
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                label: AppStrings.of(context, 'settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
