import 'package:flutter/material.dart';

import '../../components/field_text.dart';
import '../../components/drop_down_menu.dart';
import '../../theme.dart';
import '../authorization/registration_screen.dart';

class CreateOrder extends StatelessWidget {
  const CreateOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yuki Yollo'),
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
              const Center(
                child: Text(
                  'Ugradyjy',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      children: [
                        FieldText(),
                        SizedBox(height: 15),
                        FieldText(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 17),
                  Container(
                    height: 105,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.whiteColor, width: 0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.photo_camera,
                      color: AppColors.buttonColor,
                      size: 70,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              DropDownMenu<City>(
                value: City(),
                values: [],
                hint: '',
                children: [],
              ),
              const SizedBox(height: 12),
              DropDownMenu<City>(
                value: City(),
                values: [],
                hint: '',
                children: [],
              ),
              const SizedBox(height: 12),
              const FieldText(),
              const SizedBox(height: 12),
              const FieldText(
                maxHeight: 80,
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Flexible(child: FieldText()),
                  const SizedBox(width: 10),
                  const Flexible(child: FieldText()),
                  const SizedBox(width: 10),
                  Flexible(
                    child: DropDownMenu<City>(
                      value: City(),
                      values: [],
                      hint: '',
                      children: [],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Agramy',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                        WidgetSpan(child: SizedBox(width: 10)),
                        TextSpan(
                          text: 'Kg',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 30),
                  const Expanded(child: FieldText(maxHeight: 35)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Gowrumi',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                        WidgetSpan(child: SizedBox(width: 10)),
                        TextSpan(
                          text: 'm3',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Expanded(child: FieldText(maxHeight: 35)),
                  const SizedBox(width: 10),
                  const Expanded(child: FieldText(maxHeight: 35)),
                  const SizedBox(width: 10),
                  const Expanded(child: FieldText(maxHeight: 35)),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Alyjjy',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 13),
              const FieldText(),
              const SizedBox(height: 13),
              const FieldText(),
              const SizedBox(height: 13),
              DropDownMenu<City>(
                value: City(),
                values: [],
                hint: '',
                children: [],
              ),
              const SizedBox(height: 13),
              DropDownMenu<City>(
                value: City(),
                values: [],
                hint: '',
                children: [],
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
                child: const Text(
                  'Yatda Sakla',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
