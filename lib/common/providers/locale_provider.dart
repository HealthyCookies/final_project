import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<Locale> localeProvider = StateProvider<Locale>(
        (StateProviderRef<Locale> ref) => const Locale('en')
);
