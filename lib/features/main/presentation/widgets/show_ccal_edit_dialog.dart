import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../app_router/app_router.dart';

Future<int?> showCcalEditDialog(BuildContext context) async {
  int? totalCcal;

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.all(8.0),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 4.0,
          vertical: 16.0,
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter how much calories do you need daily?'),
              const SizedBox(height: 16.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (String value) {
                    totalCcal = int.tryParse(value);
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              TextButton(
                onPressed: () => context.router.maybePop(totalCcal),
                child: const Text('Ok'),
              )
            ],
          ),
        ),
      );
    },
  );

  return totalCcal;
}
