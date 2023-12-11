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
  List<MenuModels> mainMenuList = [
    MenuModels(icon: Icons.home_outlined,name: "Dashboard"),
    MenuModels(icon: Icons.person_outline_outlined,name: "HRMS"),
    MenuModels(icon: Icons.newspaper_rounded,name: "CRM"),
    MenuModels(icon: Icons.crop_square,name: "Inventory"),
    MenuModels(icon: Icons.account_balance_wallet_outlined,name: "Account"),
    MenuModels(icon: Icons.note_alt_outlined,name: "Blog")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/banner/hrms_logo.jpg",height: 50,),
                  SizedBox(
                    width: 100,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: mainMenuList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          setState(() {
                            selectedMenu = index;
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 75,
                              decoration: BoxDecoration(color: selectedMenu == index ? selectedBg : Colors.transparent,
                              borderRadius: BorderRadius.circular(5)),
                                child: Icon(mainMenuList[index].icon)),
                            const SizedBox(height: 5,),
                            Text(mainMenuList[index].name,style: menuStyle)
                          ],
                        ),
                      );
                    },),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
