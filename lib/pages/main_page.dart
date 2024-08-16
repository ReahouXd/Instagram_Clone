import 'package:flutter/material.dart';
import 'package:instagram_clone/pages/add_page.dart';
import 'package:instagram_clone/pages/favorite_page.dart';
import 'package:instagram_clone/pages/home_page.dart';
import 'package:instagram_clone/pages/profile_page.dart';
import 'package:instagram_clone/pages/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  int _prevIndex = -1;
  List<Widget> _screenList = [];

  final HomePage _homePage = HomePage();
  final SearchPage _searchPage = const SearchPage();
  final AddPage _addPage = const AddPage();
  final FavoritePage _favoritePage = const FavoritePage();
  final ProfilePage _profilePage = const ProfilePage();

  @override
  void initState() {
    super.initState();
    _screenList = [
      _homePage,
      _searchPage,
      _addPage,
      _favoritePage,
      _profilePage
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        controller: _pageController,
        children: _screenList,
      ),
      bottomNavigationBar: _buildBottom(),
    );
  }

  Widget _buildBottom() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _prevIndex = _currentIndex;
          _currentIndex = index;
          if (_prevIndex == _currentIndex) {
            switch (_currentIndex) {
              case 0:
                homePageKey.currentState?.gotoTop();
                break;
              case 1:
                break;
            }
          }
        });
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black.withOpacity(0.5),
      showUnselectedLabels: false,
      showSelectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 28,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            size: 28,
          ),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_box_outlined,
            size: 28,
          ),
          label: "Add",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.movie_creation_outlined,
            size: 28,
          ),
          label: "Favorite",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            size: 28,
          ),
          label: "Profile",
        ),
      ],
    );
  }
}

