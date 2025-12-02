import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:baithuzakath_app/controllers/navifation_bar_controller.dart';
import 'package:baithuzakath_app/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationBarPage extends ConsumerWidget {
  const NavigationBarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(bottomNavigationBarIndexProvider);

    final pageController = PageController(initialPage: pageIndex);

    final NotchBottomBarController controller = NotchBottomBarController(
      index: pageIndex,
    );

    return Scaffold(
      appBar: AppBar(),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        bottomBarItems: const [
          BottomBarItem(
            activeItem: Icon(
              Icons.home_filled,
              color: Color.fromRGBO(49, 121, 90, 1),
            ),
            inActiveItem: Icon(Icons.home_filled),
          ),
          BottomBarItem(
            activeItem: Icon(Icons.work, color: Color.fromRGBO(49, 121, 90, 1)),
            inActiveItem: Icon(Icons.work),
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.person),
            activeItem: Icon(
              Icons.person,
              color: Color.fromRGBO(49, 121, 90, 1),
            ),
          ),
        ],
        notchBottomBarController: controller,
        onTap: (int index) {
          ref.read(bottomNavigationBarIndexProvider.notifier).state = index;

          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        },
        kIconSize: R.sw(20, context),
        kBottomRadius: R.sw(30, context),
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: pages,
        onPageChanged: (int index) {
          ref.read(bottomNavigationBarIndexProvider.notifier).state = index;
          controller.index = index;
        },
      ),
    );
  }
}
