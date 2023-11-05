import 'package:flutter/material.dart';
import 'package:yollo/screens/profile_screen/profile_screen.dart';

import '../assets.dart';
import '../navigation.dart';
import '../theme.dart';
import '../widgets/tabbed_navigator.dart';
import 'home_screen/home_screen.dart';

enum TabItem {
  home,
  orders,
  news,
  profile;

  Widget get icon {
    switch (this) {
      case TabItem.home:
        return AppIcons.home.svgPicture();
      case TabItem.orders:
        return AppIcons.box.svgPicture();
      case TabItem.news:
        return AppIcons.news.svgPicture();
      case TabItem.profile:
        return AppIcons.profile.svgPicture();
    }
  }

  Widget get iconFilled {
    switch (this) {
      case TabItem.home:
        return AppIcons.home.svgPicture(color: AppColors.buttonColor);
      case TabItem.orders:
        return AppIcons.box.svgPicture(color: AppColors.buttonColor);
      case TabItem.news:
        return AppIcons.news.svgPicture(color: AppColors.buttonColor);
      case TabItem.profile:
        return AppIcons.profile.svgPicture(color: AppColors.buttonColor);
    }
  }
}

final MaterialTabController tabController = MaterialTabController();

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const TabItem mainTab = TabItem.home;

  final tabNavigatorKeys = List<GlobalKey<NavigatorState>>.generate(
    TabItem.values.length,
    (index) => GlobalKey(),
    growable: false,
  );

  void onTabSelected(TabItem newSelected) {
    final oldValue = TabItem.values[tabController.index];
    if (newSelected == oldValue) {
      final navigatorState = tabNavigatorKeys[newSelected.index].currentState;
      if (navigatorState == null) {
        return;
      }
      if (navigatorState.isCurrentRouteFirst()) {
        onTabReselectedInFirstRoute(newSelected);
      } else {
        navigatorState.popUntil((route) => route.isFirst);
      }
    } else {
      tabController.index = newSelected.index;
    }
  }

  void onTabReselectedInFirstRoute(TabItem tabItem) {
    //no-op
  }

  Future<bool> onWillPop() async {
    final tabIndex = tabController.index;
    final currentTab = TabItem.values[tabIndex];
    final navigatorState = tabNavigatorKeys[tabIndex].currentState;

    if (navigatorState == null) {
      //let the system handle back button
      return true;
    }

    final isFirstRouteInCurrentTab = !(await navigatorState.maybePop());
    if (isFirstRouteInCurrentTab) {
      //if not on the 'main' tab
      if (currentTab != mainTab) {
        //select 'main' tab
        tabController.index = mainTab.index;
        //back button handled by app
        return false;
      }
    }
    //let system handle back button if we're on the first route
    return isFirstRouteInCurrentTab;
  }

  Widget buildTabWidget(BuildContext context, int index) {
    final tab = TabItem.values[index];
    final Widget child;
    switch (tab) {
      case TabItem.home:
        child = const HomeScreen();
        break;
      case TabItem.orders:
        child = Container();
        break;
      case TabItem.news:
        child = Container();
        break;
      case TabItem.profile:
        child = const ProfileScreen();
        break;
    }
    return MaterialTabView(
      navigatorKey: tabNavigatorKeys[index],
      builder: (context) => child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: MaterialTabNavigator(
          tabBuilder: buildTabWidget,
          controller: tabController,
          tabCount: TabItem.values.length,
          tabSwitchFadeDuration: Duration.zero,
        ),
        bottomNavigationBar: AnimatedBuilder(
          animation: tabController,
          builder: (context, child) => BottomNavigation(
            currentTab: TabItem.values[tabController.index],
            onSelectTab: onTabSelected,
          ),
        ),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  const BottomNavigation({
    super.key,
    required this.currentTab,
    required this.onSelectTab,
  });

  @override
  Widget build(BuildContext context) {
    final tabItems = <Widget>[];
    for (final tab in TabItem.values) {
      final itemWidget = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onSelectTab(tab),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 22),
            if (currentTab == tab) tab.iconFilled else tab.icon,
            const SizedBox(height: 30),
          ],
        ),
      );
      tabItems.add(itemWidget);
    }

    final double additionalBottomPadding = MediaQuery.of(context).padding.bottom;

    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.greyColor)),
          color: AppColors.backgroundColor,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: kBottomNavigationBarHeight + additionalBottomPadding,
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: additionalBottomPadding),
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: Row(
              children: tabItems.map((child) => Expanded(child: child)).toList(growable: false),
            ),
          ),
        ),
      ),
    );
  }
}
