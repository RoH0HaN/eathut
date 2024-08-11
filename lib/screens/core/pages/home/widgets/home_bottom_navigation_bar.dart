import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/icons.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                LineAwesomeIcons.heart,
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                LineAwesomeIcons.file_contract_solid,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                // Get.toNamed(AppRoutes.addFood);
              },
              child: SvgPicture.asset(
                AppIcons.homeIcon,
                width: 50,
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                LineAwesomeIcons.bell,
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                LineAwesomeIcons.user,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
