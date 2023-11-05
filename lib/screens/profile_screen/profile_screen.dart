import 'package:flutter/material.dart';

import '../../assets.dart';
import '../../theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        bottom: const PreferredSize(
          preferredSize: Size(double.infinity, 20),
          child: Divider(
            color: AppColors.greyColor,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          AppIcons.person.svgPicture(),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Plany Planyyew',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              '+99365112233',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.outlined_flag_outlined),
            title: const Text(
              'Dil uytget',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: AppIcons.chevronDown.svgPicture(),
          ),
          ListTile(
            leading: const Icon(Icons.outlined_flag_outlined),
            title: const Text(
              'Dil uytget',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: AppIcons.chevronDown.svgPicture(),
          ),
          ListTile(
            leading: const Icon(Icons.outlined_flag_outlined),
            title: const Text(
              'Dil uytget',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: AppIcons.chevronDown.svgPicture(),
          ),
          ListTile(
            leading: const Icon(Icons.outlined_flag_outlined),
            title: const Text(
              'Dil uytget',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: AppIcons.chevronDown.svgPicture(),
          ),
          ListTile(
            leading: const Icon(Icons.outlined_flag_outlined),
            title: const Text(
              'Dil uytget',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: AppIcons.chevronDown.svgPicture(),
          ),
          ListTile(
            leading: const Icon(Icons.outlined_flag_outlined),
            title: const Text(
              'Dil uytget',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: AppIcons.chevronDown.svgPicture(),
          ),
          ListTile(
            leading: const Icon(Icons.outlined_flag_outlined),
            title: const Text(
              'Dil uytget',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: AppIcons.chevronDown.svgPicture(),
          ),
          ListTile(
            leading: const Icon(Icons.outlined_flag_outlined),
            title: const Text(
              'Dil uytget',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: AppIcons.chevronDown.svgPicture(),
          ),
        ],
      ),
    );
  }
}
