import 'package:baithuzakath_app/view/application_screen.dart';
import 'package:baithuzakath_app/view/scheme_screen.dart';
import 'package:baithuzakath_app/view/track_application_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

PageController pageController = PageController();
List<Widget> pages = [
  SchemesListScreen(),
  const MyApplicationsScreen(),
  ApplicationTrackScreen(applicationId: 'your_application_id_here'),
];

final bottomNavigationBarIndexProvider = StateProvider<int>((ref) => 0);
