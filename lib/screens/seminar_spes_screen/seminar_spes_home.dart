import 'package:flutter/material.dart';
import '../profile_screen/profile_page.dart';
import 'discover_page.dart';
import 'icons.dart';

import 'widgets/svg_asset.dart';

class SeminarSpecHomePage extends StatefulWidget {
  const SeminarSpecHomePage({Key? key}) : super(key: key);

  @override
  State<SeminarSpecHomePage> createState() => _SeminarSpecHomePageState();
}

class _SeminarSpecHomePageState extends State<SeminarSpecHomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    DiscoverPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          enableFeedback: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const SvgAsset(assetName: AssetName.discover),
              label: '',
              tooltip: 'Discover',
              activeIcon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xff4A80F0).withOpacity(0.3),
                        offset: const Offset(0, 4),
                        blurRadius: 20),
                  ],
                ),
                child: const SvgAsset(
                    assetName: AssetName.discover, color: Color(0xff4A80F0)),
              ),
            ),
            BottomNavigationBarItem(
              icon: const SvgAsset(assetName: AssetName.chart),
              label: '',
              tooltip: 'Charts',
              activeIcon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xff4A80F0).withOpacity(0.3),
                        offset: const Offset(0, 4),
                        blurRadius: 20),
                  ],
                ),
                child: const SvgAsset(
                  assetName: AssetName.chart,
                  color: Color(0xff4A80F0),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: const SvgAsset(assetName: AssetName.profile),
              label: '',
              tooltip: 'Profile',
              activeIcon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xff4A80F0).withOpacity(0.3),
                        offset: const Offset(0, 4),
                        blurRadius: 20),
                  ],
                ),
                child: const SvgAsset(
                  assetName: AssetName.profile,
                  color: Color(0xff4A80F0),
                ),
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
          backgroundColor: const Color(0xff1C2031),
        ),
      ),
    );
  }
}
