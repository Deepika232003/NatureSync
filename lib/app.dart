import 'package:flutter/material.dart';

import 'package:naturesync/presentation/screens/dashboard/dashboard_screen.dart';

class NatureSync extends StatelessWidget {
  const NatureSync({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}
