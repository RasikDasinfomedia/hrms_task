import 'package:flutter/material.dart';
import 'package:hrms_task/utils/leave_bar_chart.dart';
import 'package:hrms_task/utils/custom_button.dart';
import 'package:hrms_task/utils/custom_calendar_app.dart';
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
    MenuModels(name: "Miss Punch Approved", subName: "14"),
    MenuModels(name: "Miss Punch Rejected", subName: "21"),
    MenuModels(name: "Leave Approved", subName: "15"),
    MenuModels(name: "Leave Rejected", subName: "5"),
    MenuModels(name: "Holiday", subName: "21")
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
                          color: searchBg,
                        ),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.search_rounded,
                              size: 18,
                              color: textColor,
                            ),
                            hintText: "Search",
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
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Text("Leaves", style: menuStyle.copyWith(fontSize: 12)),
                            const Spacer(),
                            customButton(icon: Icons.add_circle, title: "Add Leave", onPressed: () {}),
                            const SizedBox(
                              width: 10,
                            ),
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
                                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                                          decoration: BoxDecoration(color: colorList[index], borderRadius: BorderRadius.circular(8)),
                                          child: Text(cardItemList[index].subName!, style: menuStyle.copyWith(fontSize: 15, color: Colors.white))),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            customCard(
                              width: width * 0.29,
                              padding: const EdgeInsets.only(top: 10, right: 17, left: 17),
                              child: CustomCalendarApp(
                                [],
                              ),
                            ),
                            customCard(margin: const EdgeInsets.only(left: 10), width: width * 0.47, height: width * 0.26, child: LeavesBarChart())
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              width: width * 0.18,
                              height: 30,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white, border: Border.all(color: dividerColor, width: 1)),
                              child: TextField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.search_rounded,
                                    size: 18,
                                    color: textColor,
                                  ),
                                  hintText: "Search",
                                  contentPadding: EdgeInsets.only(bottom: 17, right: 0),
                                ),
                                cursorHeight: 15,
                                style: menuStyle.copyWith(fontSize: 12, fontWeight: FontWeight.normal),
                              ),
                            ),
                            Spacer(),
                            Container(
                              height: 30,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(left: 10),
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white, border: Border.all(color: dividerColor, width: 1)),
                              child: Row(
                                children: [
                                  Text("Filter by", style: cardTextStyle.copyWith(fontWeight: FontWeight.normal)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.filter_alt_outlined,
                                    size: 18,
                                    color: textColor,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            customButton(height: 30, icon: Icons.upload_file_outlined, title: "Export to Excel", onPressed: () {}),
                            SizedBox(
                              width: 5,
                            ),
                            customCard(
                              blurRadius: 3,
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.list,
                                size: 18,
                                color: textColor,
                              ),
                            ),
                            customCard(
                              blurRadius: 3,
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.grid_view,
                                size: 18,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                        customCard(
                          blurRadius: 5,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text("Leaves Details", style: menuStyle.copyWith(fontSize: 12)),
                              const SizedBox(
                                height: 10,
                              ),
                              ScrollConfiguration(
                                behavior: _myCustomScrollBehavior.copyWith(scrollbars: false),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                      columnSpacing: width * 0.038,
                                      headingRowColor: MaterialStateProperty.all(searchBg),
                                      columns: const [
                                        DataColumn(
                                          label: Text('Image'),
                                        ),
                                        DataColumn(
                                          label: Text('Name'),
                                        ),
                                        DataColumn(
                                          label: Text('Time off Type'),
                                        ),
                                        DataColumn(
                                          label: Text('Description'),
                                        ),
                                        DataColumn(
                                          label: Text('Start Date'),
                                        ),
                                        DataColumn(
                                          label: Text('End Date'),
                                        ),
                                        DataColumn(
                                          label: Text('Duration'),
                                        ),
                                        DataColumn(
                                          label: Text('Status'),
                                        ),
                                      ],
                                      rows: List.generate(
                                          10,
                                          (index) => DataRow(cells: [
                                                DataCell(Image.asset(
                                                  "assets/image/profile.png",
                                                  height: 25,
                                                )),
                                                const DataCell(Text('Kmsae')),
                                                const DataCell(Text('Paid Time Off')),
                                                const DataCell(Text('Sick')),
                                                const DataCell(Text('11-11-2023')),
                                                const DataCell(Text('20-11-2023')),
                                                const DataCell(Text('10 Days')),
                                                DataCell(Row(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                                      decoration:
                                                          BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, border: Border.all(color: greenBg, width: 1)),
                                                      child: Row(
                                                        children: [
                                                          Container(height: 5, width: 5, decoration: const BoxDecoration(shape: BoxShape.circle, color: greenBg)),
                                                          Text("Approved", style: cardTextStyle.copyWith(fontWeight: FontWeight.normal, color: greenBg)),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                        margin: EdgeInsets.only(left: 5),
                                                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, border: Border.all(color: greenBg, width: 1)),
                                                        child: Icon(
                                                          Icons.done,
                                                          color: greenBg,
                                                          size: 16,
                                                        )),
                                                  ],
                                                )),
                                              ]))),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
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
