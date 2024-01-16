import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/alert_dialog.dart';
import '../../data/response.dart';
import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../utils/assets.dart';
import '../../utils/enums.dart';
import '../../utils/navigation.dart';
import '../../utils/theme.dart';

class CreateUserAuto extends StatelessWidget {
  const CreateUserAuto({super.key});

  Future<void> onCreateOrderButtonTap(BuildContext context) async {
    final l10n = context.l10n;
    alertDialog(
      context,
      title: l10n.confirmOrder,
      onTap: () async {
        final ref = ProviderScope.containerOf(context, listen: false);
        final apiClient = ref.read(apiClientProvider);
        final user = ref.read(authControllerProvider);
        try {
          await apiClient.createOrderBox(
            createOrderBox: CreateOrderBox(
              clientFrom: user?.username ?? '',
              clientTo: '',
              phoneFrom: user?.phone ?? '',
              phoneTo: '',
              addressFrom: user?.address,
              addressTo: '',
              tarif: '0',
              amount: '0',
              weight: '0',
              placeCount: 0,
              valuta: Currency.tmt,
              status: OrderStatus.call,
              comment: '',
              payment: PaymentMethod.after.asValue(context),
              regionFrom: user?.regionId.toString(),
              regionTo: '0',
              discount: '0',
              volumeSm: '0',
              weightMax: '0',
              minSm: '0',
              maxSm: '0',
              delivery: '0',
            ),
          );
          if (context.mounted) {
            showSnackBar(l10n.orderCreated, backgroundColor: AppColors.greenColor);
          }
        } catch (e) {
          log(e.toString());
          if (context.mounted) {
            showSnackBar(l10n.hasErrorPleaseReaped, backgroundColor: AppColors.redColor);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListTile(
      onTap: ()=> onCreateOrderButtonTap(context),
      splashColor: AppColors.buttonColor,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.whiteColor),
        borderRadius: BorderRadius.circular(4),
      ),
      contentPadding: const EdgeInsets.all(10),
      title: Text(
        l10n.callTaxi,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        l10n.autoCompleteOrder,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: AppIcons.truck.svgPicture(height: 54),
    );
  }
}
