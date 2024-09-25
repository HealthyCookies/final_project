import 'package:flutter/material.dart';

Future<int?> showCcalEditDialog(BuildContext context) async {
  int? totalCcal;

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.all(8.0),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 4.0,
          vertical: 16.0,
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: double.maxFinite,
          child: AlertDialog(
            content: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                totalCcal = int.tryParse(value);
              },
            ),
          ),
        ),
      );
    },
  );

  return totalCcal;
}