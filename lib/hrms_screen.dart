import 'package:flutter/material.dart';
import 'package:hrms_task/utils/custom_button.dart';
import 'package:hrms_task/utils/custom_card.dart';
import 'package:hrms_task/utils/hrms_colors.dart';
import 'package:hrms_task/utils/hrms_style.dart';
import 'package:hrms_task/utils/my_custom_scroll_behavior.dart';

import 'models/menu_model.dart';

class HrmsScreen extends StatefulWidget {
  const HrmsScreen({super.key});

  @override
  State<HrmsScreen> createState() => _HrmsScreenState();
}

class _HrmsScreenState extends State<HrmsScreen> {
  final MyCustomScrollBehavior _myCustomScrollBehavior = MyCustomScrollBehavior();
  int selectedMenu = 1;
  int selectedSubMenu = 2;
  bool darkMode = false;
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
    MenuModels(icon: Icons.playlist_add_check, name: "Reports", suffix: Icons.keyboard_arrow_right_rounded)
  ];
  List<MenuModels> cardItemList = [
    MenuModels(name: "Miss Punch Approved",subName: "14"),
    MenuModels(name: "Miss Punch Rejected",subName: "21"),
    MenuModels(name: "Leave Approved",subName: "15"),
    MenuModels(name: "Leave Rejected",subName: "5"),
    MenuModels(name: "Holiday",subName: "21")
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/banner/hrms_logo.jpg",
                height: 50,
              ),
              const SizedBox(
                height: 20,
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
                      padding: const EdgeInsets.only(bottom: 20.0),
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
                                decoration: BoxDecoration(color: selectedMenu == index ? selectedBg : Colors.transparent, borderRadius: BorderRadius.circular(8)),
                                child: Icon(mainMenuList[index].icon, size: 20, color: textColor)),
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
          Container(
            width: 150,
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 10,
                ),
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: subMenuList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  width: 90,
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedSubMenu = index;
                      });
                    },
                    child: Container(
                      width: 75,
                      height: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(color: selectedSubMenu == index ? selectedBg : Colors.transparent, borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(subMenuList[index].icon, size: 18, color: selectedSubMenu == index ? selectedTextColor : textColor),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(subMenuList[index].name, style: menuStyle.copyWith(color: selectedSubMenu == index ? selectedTextColor : textColor)),
                          const Spacer(),
                          if (subMenuList[index].suffix != null) Icon(subMenuList[index].suffix, size: 18, color: selectedSubMenu == index ? selectedTextColor : textColor)
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: width - 250,
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customCard(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: [
                      Text("Home > HRMS > Leaves", style: menuStyle.copyWith(fontWeight: FontWeight.normal)),
                      const Spacer(),
                      Text("Dark Mode", style: menuStyle.copyWith(fontWeight: FontWeight.normal)),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: 40,
                        height: 20,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Switch(
                            value: darkMode,
                            inactiveThumbColor: selectedTextColor,
                            onChanged: (bool value) {
                              setState(() {
                                darkMode = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: width * 0.18,
                        height: 25,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: searchBg, // Set your desired background color
                        ),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.search_rounded,
                              size: 18,
                              color: textColor,
                            ),
                            contentPadding: EdgeInsets.only(bottom: 18, right: 0),
                          ),
                          cursorHeight: 15,
                          style: menuStyle.copyWith(fontSize: 12, fontWeight: FontWeight.normal),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Stack(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.notification_important_outlined,
                              size: 18,
                              color: textColor,
                            ),
                          ),
                          Positioned(
                            right: 2,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.redAccent),
                              child: const Text("3", style: notificationTextStyle),
                            ),
                          )
                        ],
                      ),
                      Stack(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Icon(
                              Icons.messenger_outline,
                              size: 18,
                              color: textColor,
                            ),
                          ),
                          Positioned(
                            right: 2,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.redAccent),
                              child: const Text("3", style: notificationTextStyle),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 10),
                      Image.asset(
                        "assets/image/profile.png",
                        height: 25,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [Text("Leaves", style: menuStyle.copyWith(fontSize: 12)),
                    const Spacer(),
                    customButton(icon: Icons.add_circle, title: "Add Leave", onPressed: () {}),
                    const SizedBox(width: 10,),
                    customButton(icon: Icons.add_circle, title: "Add Miss Punch", onPressed: () {}),
                  ],
                ),
                ScrollConfiguration(
                  behavior: _myCustomScrollBehavior.copyWith(scrollbars: false),
                  child: SizedBox(
                    width: width,
                    height: 110,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: cardItemList.length,
                      itemBuilder: (context, index) {
                        return customCard(
                          width: width * 0.138,
                          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(cardItemList[index].name, style: cardTextStyle),
                            const Spacer(),
                            Container(
                              width: 40,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: colorList[index],
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Text(cardItemList[index].subName!, style: menuStyle.copyWith(fontSize: 15,color: Colors.white))),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
