import 'package:shared/presentation/widgets/widgets.dart';
import 'package:core/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'tabs/home_tab_page.dart';
import 'tabs/settings_tab_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ValueNotifier<int> _selectedTab = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder(
      valueListenable: _selectedTab,
      builder: (context, currentTab, _) => Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          title: Text(
            currentTab == 0
                ? string.of(context).users
                : string.of(context).settings,
          ),
          centerTitle: false,
          titleTextStyle: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Backdrop(
          child: SafeArea(
            child: IndexedStack(
              key: const ValueKey('nav_bar_view_key'),
              index: currentTab,
              children: const [
                HomeTabPage(
                  key: PageStorageKey('home_nav_page_key'),
                ),
                SettingsTabPage(
                  key: PageStorageKey('settings_nav_page_key'),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          key: const ValueKey('nav_bar_key'),
          currentIndex: currentTab,
          onTap: (i) => _selectedTab.value = i,
          items: {
            0: {
              'icon': Iconsax.home,
              'active_icon': Iconsax.home_2,
              'label': string.of(context).home,
            },
            1: {
              'icon': Iconsax.setting_44,
              'active_icon': Iconsax.setting_45,
              'label': string.of(context).settings,
            },
          }
              .entries
              .map(
                (e) => BottomNavigationBarItem(
                  key: ValueKey(e.key),
                  icon: Icon(e.value['icon'] as IconData),
                  activeIcon: Icon(e.value['active_icon'] as IconData),
                  label: e.value['label'] as String,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
