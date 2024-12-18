import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oshop_coderay/features/home/presentation/controllers/home_controller.dart';
import 'package:oshop_coderay/features/home/presentation/pages/product_category_page.dart';
import 'package:oshop_coderay/features/home/presentation/pages/product_page.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/constants/colors.dart';

import 'home_page.dart';

class DashboardPage extends StatefulWidget {
  final int currentTab;
  const DashboardPage({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final homeController = Get.find<HomeController>();
  late int _selectedIndex;
  bool _searchFocused = false;

  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  void _onSearchFocusTapped(bool change) {
    _searchFocused = change;
    setState(() {});
  }

  @override
  void initState() {
    _selectedIndex = widget.currentTab;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appbar() {
      return AppBar(
        centerTitle: true,
        title: const Text(
          'Oshop Store',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1), // Ketebalan garis
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05), blurRadius: 3)
                ]), // Warna garis
            height: 1, // Tinggi garis
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Assets.icons.notification.svg(height: 22.0),
          ),
          IconButton(
            onPressed: () {},
            icon: Assets.icons.cart.svg(height: 22.0),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: (_selectedIndex < 2) ? appbar() : null,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomePage(
            onSearchChange: (change) {
              setState(() {
                _onSearchFocusTapped(change);
              });
            },
            onTabChange: (tab) {
              _onItemTapped(tab);
            },
          ),
          // const SearchPage(),
          // const CartPage(),
          (homeController.categoryTrigger.value != 0)
              ? ProductCategoryPage(
                  category: homeController.categoryTrigger.value)
              : ProductPage(
                  focusStatus: _searchFocused,
                ),
          const Center(
            child: Text('This Page 2'),
          ),
          const Center(
            child: Text('This Page 3'),
          ),
          // const AccountPage(),
          const Center(
            child: Text('This Page 4'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Assets.icons.home.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: Assets.icons.home.svg(),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.search.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: Assets.icons.search.svg(),
            label: 'EXPLORE',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.order.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: Assets.icons.order.svg(),
            label: 'ORDER',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.person.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: Assets.icons.person.svg(),
            label: 'ACCOUNT',
          ),
        ],
      ),
    );
  }
}
