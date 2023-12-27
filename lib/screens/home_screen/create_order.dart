import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/drop_down_menu.dart';
import '../../components/field_text.dart';
import '../../components/pick_poto.dart';
import '../../data/response.dart';
import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../theme.dart';
import '../authorization/registration_screen.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({super.key});

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  ValueNotifier<File?>? img = ValueNotifier<File?>(null);

  List<RegionResults>? regions;
  List<RegionResults>? city;

  RegionResults? selectedRegion;
  RegionResults? selectedRecipientRegion;
  RegionResults? selectedCity;
  RegionResults? selectedRecipientCity;

  PaymentMethod? selectedPayment;

  void updateUi() {
    setState(() {
      //no-op
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.sendCargo),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        bottom: const PreferredSize(
          preferredSize: Size(double.infinity, 20),
          child: Divider(color: AppColors.greyColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Form(
          child: Column(
            children: [
              Center(
                child: Text(
                  l10n.sender,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        FieldText(
                          hintText: context.l10n.fio,
                        ),
                        const SizedBox(height: 15),
                        const FieldText(
                          hintText: '+99365343434',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 17),
                  PickPhoto(
                    onSelectImg: img,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Consumer(
                builder: (context, ref, child) {
                  final regionsHi = ref.watch(regionsHiProvider);
                  final results = regionsHi.asData?.value.results;
                  return DropDownMenu<RegionResults?>(
                    value: selectedRegion,
                    values: results,
                    hint: l10n.selectRegion,
                    items: results?.map((e) {
                      return e.name ?? '-';
                    }).toList(),
                    children: results
                        ?.map(
                          (e) => DropdownMenuItem<RegionResults?>(
                            value: e,
                            child: Text(
                              e.name,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        selectedRegion = val;
                        ref.read(regionsCityProvider(selectedRegion!.name));
                        updateUi();
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 12),
              Consumer(
                builder: (context, ref, child) {
                  final regionsCity = ref.watch(regionsCityProvider(selectedRegion?.name ?? '-'));
                  final results = regionsCity.asData?.value.results;
                  return DropDownMenu<RegionResults?>(
                    value: selectedCity,
                    values: results,
                    isLoading: regionsCity.isLoading,
                    hint: l10n.selectCity,
                    items: results?.map((e) {
                      return e.name ?? '-';
                    }).toList(),
                    children: results
                        ?.map(
                          (e) => DropdownMenuItem<RegionResults?>(
                            value: e,
                            child: Text(
                              e.name,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        selectedCity = val;
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 12),
              FieldText(
                hintText: l10n.address,
              ),
              const SizedBox(height: 12),
              FieldText(
                hintText: l10n.aboutProduct,
                maxHeight: 80,
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Flexible(
                    child: FieldText(
                      hintText: l10n.price,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: FieldText(
                      hintText: l10n.delivery,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: DropDownMenu<PaymentMethod>(
                      fontSize: 12,
                      value: PaymentMethod.after,
                      values: PaymentMethod.values,
                      hint: l10n.payment,
                      items: PaymentMethod.values.map((e) {
                        return e.title ?? '-';
                      }).toList(),
                      children: PaymentMethod.values
                          .map(
                            (e) => DropdownMenuItem<PaymentMethod>(
                              value: e,
                              child: Text(
                                e.title,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        if (val != null) {
                          selectedPayment = val;
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: l10n.weight,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                        const WidgetSpan(child: SizedBox(width: 10)),
                        TextSpan(
                          text: l10n.kg,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: FieldText(
                      verticalPadding: 8,
                      hintText: l10n.kg,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: l10n.volume,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                        const WidgetSpan(child: SizedBox(width: 10)),
                        TextSpan(
                          text: l10n.m3,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: FieldText(
                      verticalPadding: 8,
                      hintText: l10n.sm(30),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FieldText(
                      verticalPadding: 8,
                      hintText: l10n.sm(30),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FieldText(
                      verticalPadding: 8,
                      hintText: l10n.sm(40),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Alyjjy',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 13),
              FieldText(hintText: l10n.fio),
              const SizedBox(height: 13),
              const FieldText(hintText: '+99362222222'),
              const SizedBox(height: 13),
              Consumer(
                builder: (context, ref, child) {
                  final regionsHi = ref.watch(regionsHiProvider);
                  final results = regionsHi.asData?.value.results;
                  return DropDownMenu<RegionResults?>(
                    value: selectedRecipientRegion,
                    values: results,
                    hint: l10n.selectRegion,
                    items: results?.map((e) {
                      return e.name ?? '-';
                    }).toList(),
                    children: results
                        ?.map(
                          (e) => DropdownMenuItem<RegionResults?>(
                        value: e,
                        child: Text(
                          e.name,
                        ),
                      ),
                    )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        selectedRecipientRegion = val;
                        ref.read(regionsCityProvider(selectedRecipientRegion!.name));
                        updateUi();
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 13),
              Consumer(
                builder: (context, ref, child) {
                  final regionsCity = ref.watch(regionsCityProvider(selectedRegion?.name ?? '-'));
                  final results = regionsCity.asData?.value.results;
                  return DropDownMenu<RegionResults?>(
                    value: selectedRecipientCity,
                    values: results,
                    isLoading: regionsCity.isLoading,
                    hint: l10n.selectCity,
                    items: results?.map((e) {
                      return e.name ?? '-';
                    }).toList(),
                    children: results
                        ?.map(
                          (e) => DropdownMenuItem<RegionResults?>(
                        value: e,
                        child: Text(
                          e.name,
                        ),
                      ),
                    )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        selectedRecipientCity = val;
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(const Size(double.infinity, 46)),
                ),
                child: Text(
                  l10n.saveIt,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum PaymentMethod {
  before('Onunden'),
  after('Sonundan');

  final String title;

  const PaymentMethod(this.title);
}
