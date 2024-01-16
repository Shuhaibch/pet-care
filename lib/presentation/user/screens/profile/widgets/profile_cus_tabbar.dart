import 'package:flutter/material.dart';

class ProfileCustTabbar extends StatelessWidget {
  const ProfileCustTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            
            bottom: const TabBar(
              dividerHeight: 0,
              indicatorWeight: 1,
              isScrollable: true,
              tabs: [
                Tab(
                  icon: Icon(Icons.perm_media_outlined),
                  text: "Post",
                ),
                Tab(
                  icon: Icon(Icons.report_gmailerrorred),
                  text: "Report",
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Text('post'),
              Text('post'),
            ],
          )),
    );
  }
}
