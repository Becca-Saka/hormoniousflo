import 'package:flutter/material.dart';
import 'package:hormoniousflo/data/controller/phase_controller.dart';
import 'package:hormoniousflo/ui/shared/const_colors.dart';
import 'package:provider/provider.dart';
import 'check_in_view.dart';
import 'profile_calender_view.dart';


class MainView extends StatelessWidget {
   MainView({ Key? key }) : super(key: key);

   final List<Widget> screens = [
    const ProfileCalenderView(),
    Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.green,
    ),
    const SizedBox(),
    Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.blue,
    ),
    Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.yellow,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<PhaseController>(
      builder: (context, controller, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            elevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            backgroundColor: kAppColor,
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CheckInView()),
              );
            },
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: PageStorage(
            child: IndexedStack(
              index: controller.selectedIndex,
              children: screens,
            ),
            bucket: PageStorageBucket(),
          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 5,
            child: SizedBox(
              height: 60,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    navItems(
                      Icons.person,
                      'Profile',
                      index: 0,
                      onPressed: () => controller.setSelectedIndex(0),
                      selectedIndex: controller.selectedIndex,
                    ),
                    navItems(
                      Icons.dehaze,
                      'Program',
                      index: 1,
                      onPressed: () => controller.setSelectedIndex(1),
                      selectedIndex: controller.selectedIndex,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 25, left: 7, right: 4),
                      child: Text(
                        'Check-in',
                        style: TextStyle(
                          color: kBlueGreyColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    navItems(
                      Icons.loop,
                      'Lifestyle',
                      index: 3,
                      onPressed: () => controller.setSelectedIndex(3),
                      selectedIndex: controller.selectedIndex,
                    ),
                    navItems(
                      Icons.settings,
                      'Settings',
                      index: 4,
                      onPressed: () => controller.setSelectedIndex(4),
                      selectedIndex: controller.selectedIndex,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  InkWell navItems(IconData icon, String text,
      {required int index,
      required Function() onPressed,
      required int selectedIndex,
      bool isSelected = false}) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: selectedIndex == index ? kAppColor : kBlueGreyColor,
            size: 22,
          ),
          Text(
            text,
            style: TextStyle(
              color: selectedIndex == index ? kAppColor : kBlueGreyColor,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}