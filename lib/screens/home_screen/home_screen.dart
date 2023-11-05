import 'package:flutter/material.dart';

import '../../assets.dart';
import '../../navigation.dart';
import '../../theme.dart';
import 'create_order.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Center(child: AppIcons.logo.svgPicture(height: 23)),
              const SizedBox(height: 47),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.whiteColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(35),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'YOLLO',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'welayatara we Ashgabat shaher ichi eltip bermek hyzmatyny yerine yetiryan hyzmat bolup duryar',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Ish wagty: 09:00 - 18:00',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 76),
              ListTile(
                onTap: () {},
                splashColor: AppColors.buttonColor,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: AppColors.whiteColor),
                  borderRadius: BorderRadius.circular(4),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                title: const Text(
                  'Sürüjini çagyr',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: const Text(
                  'Sargydy automatik doldur ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: AppIcons.truck.svgPicture(height: 54),
              ),
              const SizedBox(height: 19),
              ListTile(
                onTap: () => navigateTo<Widget>(context, const CreateOrder()),
                splashColor: AppColors.buttonColor,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: AppColors.whiteColor),
                  borderRadius: BorderRadius.circular(4),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                title: const Text(
                  'Ýüki Ýollo',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: const Text(
                  'Sargydy elde doldur',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: AppIcons.box.svgPicture(height: 54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
