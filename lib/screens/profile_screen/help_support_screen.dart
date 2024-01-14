import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import 'widgets/chat_view_app_bar.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ChatViewAppBar(
          onBack: () => Navigator.pop(context),
          name: l10n.helpSupport,
          isLoading: false,
          subTitle: 'Sub title',
          fetchingStatus: ' Loading messsage',
        ),
      ),
    );
  }
}
