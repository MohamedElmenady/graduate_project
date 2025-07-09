import 'package:flutter/material.dart';
import 'package:graduate_project/feature/doctor/cnceledScreen.dart';
import 'package:graduate_project/feature/doctor/completedScreen.dart';
import 'package:graduate_project/feature/doctor/upComingScreen.dart';

class TapBarScreen extends StatefulWidget {
  const TapBarScreen({Key? key}) : super(key: key);

  @override
  State<TapBarScreen> createState() => _TapBarScreenState();
}

class _TapBarScreenState extends State<TapBarScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabs = ['Upcoming', 'Completed', 'Cancelled'];

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  Color _getTabColor(int index) {
    if (_tabController.index == index) {
      switch (tabs[index]) {
        case 'Upcoming':
          return Colors.blue;
        case 'Completed':
          return Colors.green;
        case 'Cancelled':
          return Colors.red;
      }
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Appointment',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _getTabColor(_tabController.index),
          tabs: List.generate(
            tabs.length,
            (index) => Tab(
              child: Text(
                tabs[index],
                style: TextStyle(
                  color: _getTabColor(index),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Center(
            child: UpcomingScreen(),
          ),
          Center(child: CompletedScreen()),
          Center(child: CancelledScreen()),
        ],
      ),
    );
  }
}
