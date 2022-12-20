import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AuthPageViewModel extends ChangeNotifier{
  PageController _pageController = PageController();
  PageController get authPageController =>_pageController;
  void NavigateToIndex({required int index}){
    _pageController.animateToPage(index, duration: Duration(milliseconds: 900), curve: Curves.easeInOutCubicEmphasized);
  }
}