import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/tab_provider.dart';
import '../screens/home_screen.dart';
import '../screens/more_screen.dart';
import '../screens/search_screen.dart';


class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Access TabProvider using context
    final tabProvider = Provider.of<TabProvider>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.black,
          height: 70,
          child: TabBar(
            onTap: (index) {
              // Update the selected tab index in the provider
              tabProvider.updateTabIndex(index);
            },
            tabs: const [
              Tab(
                icon: Icon(Icons.home),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.search),
                text: "Search",
              ),
              Tab(
                icon: Icon(Icons.person),
                text: "My Profile",
              ),
            ],
            unselectedLabelColor: const Color(0xFF999999),
            labelColor: Colors.white,
            indicatorColor: Colors.transparent,
          ),
        ),
        body: TabBarView(
          children: [
            HomeScreen(),
            SearchScreen(),
            ProfilesPage(),
          ],
        ),
      ),
    );
  }
}
