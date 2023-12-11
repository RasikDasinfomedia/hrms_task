import 'package:flutter/material.dart';
import 'package:hrms_task/utils/hrms_colors.dart';
import 'package:hrms_task/utils/hrms_style.dart';

import 'models/menu_model.dart';

class HrmsScreen extends StatefulWidget {
  const HrmsScreen({super.key});

  @override
  State<HrmsScreen> createState() => _HrmsScreenState();
}

class _HrmsScreenState extends State<HrmsScreen> {
  int selectedMenu = 1;
  int selectedSubMenu = 2;
  List<MenuModels> mainMenuList = [
    MenuModels(icon: Icons.home_outlined, name: "Dashboard"),
    MenuModels(icon: Icons.person_outline_outlined, name: "HRMS"),
    MenuModels(icon: Icons.newspaper_rounded, name: "CRM"),
    MenuModels(icon: Icons.crop_square, name: "Inventory"),
    MenuModels(icon: Icons.account_balance_wallet_outlined, name: "Account"),
    MenuModels(icon: Icons.note_alt_outlined, name: "Blog")
  ];
  List<MenuModels> subMenuList = [
    MenuModels(icon: Icons.home_outlined, name: "Dashboard"),
    MenuModels(icon: Icons.groups, name: "Team"),
    MenuModels(icon: Icons.exit_to_app_outlined, name: "Leaves"),
    MenuModels(icon: Icons.account_tree_outlined, name: "Tree"),
    MenuModels(icon: Icons.playlist_add_check, name: "Reports",suffix: Icons.chevron_right_sharp)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/banner/hrms_logo.jpg",
                  height: 50,
                ),
                SizedBox(
                  width: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: mainMenuList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedMenu = index;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                  width: 75,
                                  decoration: BoxDecoration(color: selectedMenu == index ? selectedBg : Colors.transparent, borderRadius: BorderRadius.circular(5)),
                                  child: Icon(mainMenuList[index].icon)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(mainMenuList[index].name, style: menuStyle)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            const VerticalDivider(width: 1,color: dividerColor,),
            SizedBox(
              width: 100,
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: subMenuList.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    width: 90,
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedSubMenu = index;
                        });
                      },
                      child: Container(
                        width: 75,
                        decoration: BoxDecoration(color: selectedSubMenu == index ? selectedBg : Colors.transparent, borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(subMenuList[index].icon),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(subMenuList[index].name, style: menuStyle),
                            const Spacer(),
                            if(subMenuList[index].suffix != null)
                            Icon(subMenuList[index].suffix)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const VerticalDivider(width: 1,color: dividerColor,)
          ],
        ),
      ),
    );
  }
}
